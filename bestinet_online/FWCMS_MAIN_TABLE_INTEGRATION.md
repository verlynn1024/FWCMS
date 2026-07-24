# FWCMS Main-Table Integration — Bestinet Online Portal

**Status:** implemented. Quotation generation runs **after** payment succeeds,
in the dedicated endpoint `pop_fwcms_generate_quotation.jsp` (invoked from
`pop_fwcms_payment_result.jsp` on payment SUCCESS via the `FWCMSQuotation`
controller). The pre-payment endpoint `pop_fwcms_worker_detail_rep.jsp` now
writes only the `TB_FWCMS_ONLINE` tracking row (chosen immigration branch).

> **Post-payment refactor (this change).** The insurance quotation — the FWCMS
> "class" tables — was previously created **before** the payment gateway.
> Under the new business rule it is created **only after payment is
> successful**. The `TB_FWCMS_ONLINE*` tracking tables and the UUID logic are
> unchanged (still written when the user enters from Bestinet); only the
> class-table generation moved. Each quotation also now carries a reusable
> running-number reference (`Q00001`, `Q00002`, …) instead of the Bestinet
> ITR-with-`-0*`-suffix reference. See §5–§9.

## 1. The problem this solves

The Bestinet Online Portal originally persisted a purchased policy **only** into
the online tracking tables:

| Table | Purpose |
| --- | --- |
| `TB_FWCMS_ONLINE` | one row per portal purchase journey (keyed by `UUID`) |
| `TB_FWCMS_ONLINE_DTL` | one row per product in the journey (`I` = FWIG, `H` = FWHS) |
| `TB_FWCMS_ONLINE_WORKER` | worker snapshot per product |

These tables exist **for portal tracking only**. The real FWCMS core ("class")
tables — `TB_FWIGCN`, `TB_FWIGMAST`, `TB_FWIGSCH`, `TB_FWHSCN`, `TB_FWHSSCH`,
`TB_FWHSITEM`, `TB_TRANSACTION` — were never populated. Every downstream FWCMS
module (printing, enquiry, cancellation, endorsement, reporting) reads those
class tables, so none of them could see a portal-issued policy. Issuance in
`pop_fwcms_payment_result.jsp` was a **mock** that stamped `MCK…` cover-note
numbers onto the online DTL row and printed from the online tables alone.

The fix: after payment, insert the journey into the **same class tables** the
legacy eCover flow uses, by **reusing the existing legacy DAOs** (`DB_FWIG`,
`DB_FWHS`) instead of re-writing their SQL. The online tables are retained
purely for portal tracking and UUID linkage.

## 2. Existing (legacy eCover) policy-creation flow

```
FWCMS → eCover
  Get ITR details (Bestinet enquiry)
  Check split policy
  Calculate premium          (calFWIG.jsp / calFWHS.jsp)
  Display premium
  Save cover note  ───────────►  INSERT into the FWCMS class tables
  Generate cover note number
  Print
```

The XML generators in `inputXML.java` (`genFWIGCNXML()`, `genFWHSCNXML()`) are
**read-only** — they `SELECT` from the class tables to build the submission XML.
They confirm the exact table set and column contract but perform **no inserts**;
the inserts are done by `DB_FWIG` / `DB_FWHS` during "Save cover note".

## 3. Existing database insertion sequence

### FWIG (Insurance Guarantee) — `DB_FWIG`

| # | Table | Method | Notes |
| --- | --- | --- | --- |
| 1 | `TB_TRANSACTION` | `insert_transaction()` | class `IG`, type `CN`, `CNSTATUS='SAVED'` |
| 2 | `TB_FWIGCN` | `Insert_FWIGCN()` | cover-note header + employer block; `UKEY = PRINCIPLE + CNCODE` |
| 3 | `TB_FWIGMAST` | `Insert_FWIGMAST()` | `^`-delimited worker & nationality-summary lists; `UKEY2 = UKEY` |
| 4 | `TB_FWIGSCH` | `Insert_FWIGSCH_CFMKT()` | premium schedule + `FWCMSREFNO` / `STAMP_FEES` |

Cover-note number: `getFWorkerNo(PRINCIPLE, ACCODE, ISSDATE)` — increments the
per-agent, per-year `TB_FWORKERNO_RUNNO` counter (auto-seeding it on first use)
and formats `YY` + 6-digit running number for this principal.

### FWHS (Hospitalisation Scheme) — `DB_FWHS`

| # | Table | Method | Notes |
| --- | --- | --- | --- |
| 1 | `TB_TRANSACTION` | `insert_transaction()` | class `FWHS`, type `CN`, `STATUS` param |
| 2 | `TB_FWHSCN` | `Insert_FWHSCN2()` | cover-note header + employer block; `UKEY = PRINCIPLE + CNCODE` |
| 3 | `TB_FWHSSCH` | `Insert_FWHSSCH()` | premium schedule + `FWCMSREFNO` |
| 4 | `TB_FWHSITEM` | `Insert_FWHSITEM(Vector)` | one 25-column row per worker; `UKEY = <UKEY>$1$<seq>` |

Cover-note number: `getREFNO(PRINCIPLE, ACCODE, CLS)` — increments a
`TB_CNSERIES` running number and returns `ACCODE-<n>`.

### Reference / supporting tables

`TB_CNSERIES` (FWHS running number), the FWIG cover-note pool table,
`TB_GUARANTOR`, `TB_FWSEARCH`, `TB_GST_CN`, `TB_CNPRINT`, `TB_CONTACT`,
`TB_NMOCCUPATION`, `TB_FWIGPREM`. The portal path populates the core policy set
(transaction + CN + MAST/SCH + ITEM); the guarantor / search / e-invoice tables
are optional legacy add-ons and are not required for printing or enquiry.

## 4. Column contract (how the target columns were verified)

Every column written is verified against **two** independent sources so the
inserts match what downstream modules read:

- `FWCMSOnline.getFWIGPrintData()` / `getFWHSPrintData()` — the print path reads
  from the class tables and shows exactly which columns each document needs.
- `inputXML.genFWIGCNXML()` / `genFWHSCNXML()` — the XML `SELECT`s confirm keys
  (`UKEY` vs `UKEY2`) and column names.

Key linkage:

- `TB_FWIGCN` / `TB_FWHSCN` key on **`UKEY`** = `PRINCIPLE + CNCODE`.
- `TB_FWIGMAST` / `TB_FWIGSCH` / `TB_FWHSSCH` key on **`UKEY2`** (= `UKEY` here).
- `TB_FWHSITEM` keys per-worker on `UKEY LIKE '<UKEY>$1$%'`, ordered by `SEQNO`.

## 5. Bestinet Online Portal integration flow (post-payment generation)

```
FWCMS → eCover
  Get ITR details
  Check split policy
  Calculate premium
  Display premium
  ── worker-detail page → "Make Payment" ──────────────
  POST pop_fwcms_worker_detail_rep.jsp (BEFORE the gateway):
    Stamp chosen immigration branch onto TB_FWCMS_ONLINE   ◄── tracking only
    (NO class-table insert here any more)
  ── (redirect to payment gateway) ────────────────────
  ── (payment confirmed, result page) ─────────────────
  pop_fwcms_payment_result.jsp (PAYMENT=Y):
    1. Stamp payment PAID
    2. FWCMSQuotation.generateQuotation(UUID, USERID)      ◄── NEW (post-payment)
         per product:
           Generate quotation number Q00001…  (DB_RunningNo / TB_RUNNING_NO)
           Generate cover note number         (DB_FWIG.getFWorkerNo / DB_FWHS.getREFNO)
           Insert all quotation tables        (one commit / rollback per product)
           Stamp real CNCODE back onto online DTL
    3. Close journey ISSUED (only if a product really issued)
  Proceed to printing                ◄── reads a real class-table policy
```

The database insertion is therefore done **after** the user completes payment.
The legacy eCover "Save cover note" step still precedes *its own* payment, but
the portal deliberately defers class-table creation until payment success so an
abandoned/failed payment never leaves an orphan quotation.

### Controller: `FWCMSQuotation` (new, thin)

`FWCMSQuotation.generateQuotation(UUID, USERID)` is the single post-payment
generation entry point. It adds no class-table SQL of its own; per product it

1. allocates the quotation running number (`DB_RunningNo.nextCommitted`);
2. delegates the cover-note number + all class-table inserts to
   `FWCMSOnline.issueMainTables(UUID, INSTYPE, USERID, quotationRef)` — the
   existing legacy issuance path (§3), now passed the quotation reference so it
   is stamped as `FWCMSREFNO` on the schedule row;
3. returns the generated quotation info (class, quotation no, cover note,
   policy no, period) for display.

It is idempotent: a product already carrying a real (non-`MCK`) cover note is
skipped, so a page reload or a duplicate gateway callback never re-inserts or
burns a second quotation number.

### Reusable running number: `DB_RunningNo`

`DB_RunningNo.next(INSCODE, SERIES, PREFIX, WIDTH)` is a generic sequence
generator over `TB_RUNNING_NO(INSCODE, SERIES, RUNNO)` — read-and-increment
under `FOR UPDATE`, auto-seeded on first use, formatted `PREFIX` +
zero-padded counter. The quotation reference uses
`next("08", "FWCMSQREF", "Q", 5)` → `Q00001`. This replaces the old scheme of
appending `-01` / `-02` to the ITR number and is reusable for any future
running number. It mirrors the locking / auto-seed pattern of the legacy
cover-note generators (`DB_FWHS.getREFNO` on `TB_CNSERIES`,
`DB_FWIG.getFWorkerNo` on `TB_FWORKERNO_RUNNO`) but is decoupled from any one
feature.

### Immigration branch selection

When the Bestinet enquiry carries no immigration branch (`immigrationBranchCode`
blank / `"N/A"`), the worker-detail page shows a **required** dropdown of the
master list (`TB_FWCMS_CODE` `TYPE='IMMI_CODE'`). The chosen branch is submitted
to `pop_fwcms_worker_detail_rep.jsp`, which resolves its description (and the G7
`IMMI_ADDRESS` when seeded) and stamps `IMMI_CODE` / `IMMI_DESCP` /
`IMMI_ADDRESS` onto the journey's `TB_FWCMS_ONLINE` row via
`updateFWCMSONLINETRANSImmi` / `updateFWCMSONLINETRANSImmiAddress`. This is
still done **before** payment (it is tracking data), so the branch is captured
in time to be carried into the FWIG quotation tables when they are generated
post-payment (the Guarantee Letter's addressee reads it from there).

### Controller: `FWCMSOnline` (thin, reused)

`FWCMSOnline` remains the issuance **controller** — it holds the legacy DAOs as
beans and adds no class-table SQL of its own. The refactor added a 4-argument
overload so the caller can supply the quotation reference:

```java
private DB_FWIG dbFWIG = new DB_FWIG();
private DB_FWHS dbFWHS = new DB_FWHS();

public String issueMainTables(String UUID, String INSTYPE, String USERID)                  // legacy: FWCMSREFNO = ITR ref
public String issueMainTables(String UUID, String INSTYPE, String USERID, String FWCMSREF) // new:    FWCMSREFNO = quotation ref
```

`issueMainTables()` (unchanged otherwise):

1. loads the journey from the online tables (`getFWCMSONLINETRANS`,
   `getFWCMSONLINEDTL`, `getFWCMSONLINEWORKERList`);
2. skips rows already issued with a real (non-`MCK`) cover note (idempotent);
3. delegates the class-table inserts to `issueFWIG(...)` / `issueFWHS(...)`,
   which drive the `DB_FWIG` / `DB_FWHS` beans through the sequence in §3 inside
   a single `setAutoCommitOff → … → conCommit` transaction (`rollBack` on error);
   the supplied `FWCMSREF` (the quotation running number) is stamped as
   `FWCMSREFNO` on the schedule row — a blank falls back to the ITR reference;
4. stamps the generated `CNCODE` / `POLNO` back onto the online DTL row via
   `updateFWCMSONLINEDTLIssued`, preserving the `UUID` linkage.

### Pre-payment endpoint: `pop_fwcms_worker_detail_rep.jsp` (before the gateway)

The worker-detail page (`pop_fwcms_worker_detail.jsp`) is a pure view; on "Make
Payment" it POSTs to `pop_fwcms_worker_detail_rep.jsp`, which now writes **only
tracking state** — it stamps the chosen immigration branch onto
`TB_FWCMS_ONLINE` and returns `OK`, and the page then redirects to
`pop_fwcms_payment.jsp`. It no longer touches the class tables; quotation
generation moved past the gateway.

### Post-payment generator: `pop_fwcms_generate_quotation.jsp` (after the gateway)

The dedicated generation endpoint. It guards that the journey's payment is
confirmed (`TB_FWCMS_ONLINE.PAYMENT_STATUS='PAID'`) and then calls
`FWCMSQuotation.generateQuotation(UUID, USERID)`. It is the canonical entry
point a real payment-gateway callback should hit once it has stamped the
payment PAID.

### Result page: `pop_fwcms_payment_result.jsp` (after the gateway)

On `PAYMENT=Y` the result page (1) stamps the payment PAID, (2) calls
`FWCMSQuotation.generateQuotation(UUID, USERID)` — the recommended in-process
invocation point, the same logic the dedicated JSP wraps — and (3) closes the
journey `ISSUED` only when at least one product now carries a real (non-`MCK`)
cover note. `PAYMENT=F` previews the failed state and generates nothing.

### Supporting change: `pop_fwcms_capturePremium.jsp`

FWHS workers were not previously persisted to `TB_FWCMS_ONLINE_WORKER` (only
FWIG was). The FWHS branch now snapshots its workers there — mirroring the FWIG
block — so `TB_FWHSITEM` can be populated DB-first at issuance and FWHS printing
reads from the database rather than session.

## 6. Sequence diagram — legacy vs online portal

**Before — quotation generated BEFORE payment:**

```
worker_detail.jsp → "Make Payment"
      │
      ▼
worker_detail_rep.jsp (BEFORE gateway)
   stamp immigration branch
   FWCMSOnline.issueMainTables()  ── INSERT class tables  ◄── quotation created here
      │
      ▼
── payment gateway ──
      │
      ▼
payment_result.jsp
   PAID stamp + journey ISSUED     (quotation already existed)
```

**After — quotation generated AFTER payment success (this change):**

```
worker_detail.jsp → "Make Payment"
      │
      ▼
worker_detail_rep.jsp (BEFORE gateway)
   stamp immigration branch  ◄── tracking only, NO class tables
      │
      ▼
── payment gateway ──
      │
      ▼
payment_result.jsp  (PAYMENT=Y)                     pop_fwcms_generate_quotation.jsp
   1. PAID stamp                                    (same logic, for gateway callback)
   2. FWCMSQuotation.generateQuotation() ───────┐        │
   3. journey ISSUED (if a product issued)      │        │
                                                ▼        ▼
                                       ┌──────────────────────────────┐
                                       │ per product:                 │
                                       │  DB_RunningNo.next → Q00001   │  (quotation no)
                                       │  FWCMSOnline.issueMainTables( │
                                       │      …, quotationRef)         │
                                       │    → getFWorkerNo/getREFNO    │  (cover-note no)
                                       │    → insert class tables      │  ◄── quotation created here
                                       │    → updateFWCMSONLINEDTLIssued│
                                       └──────────────────────────────┘
                                                     │
                                                     ▼
   FWIG: TB_TRANSACTION/TB_FWIGCN/TB_FWIGMAST/TB_FWIGSCH
   FWHS: TB_TRANSACTION/TB_FWHSCN/TB_FWHSSCH/TB_FWHSITEM
                                                     │
                                                     ▼
   Printing / Enquiry / Cancellation / Endorsement / Reporting
   (reads the same class tables the legacy eCover flow writes)
```

The class-table insert methods, tables and ordering are **identical** to the
legacy eCover "Save cover note" — only *when* they run changed (post-payment)
and the reference number stamped on the schedule (quotation running number).

## 7. Deployment prerequisites (data, not code)

1. **Quotation running number** — `DB_RunningNo` needs its counter table:

   ```sql
   CREATE TABLE TB_RUNNING_NO (
       INSCODE VARCHAR(4)  NOT NULL,
       SERIES  VARCHAR(32) NOT NULL,
       RUNNO   VARCHAR(20),
       PRIMARY KEY (INSCODE, SERIES)
   );
   ```

   The row itself is auto-seeded (INSERT … RUNNO=1) on first use; only the
   empty table must exist. (This is the one new object this change requires.)
2. **FWIG cover-note number** — `DB_FWIG.getFWorkerNo` reads/increments
   `TB_FWORKERNO_RUNNO (INSCODE=08, ACCODE, TRANSYR)`, auto-seeded — unchanged.
3. **FWHS cover-note number** — `DB_FWHS.getREFNO` reads/increments
   `TB_CNSERIES (INSCODE=08, SERIES=ACCODE, CLS=FWHS)`, auto-seeded — unchanged.

## 8. Reused legacy methods (no SQL duplicated)

| Concern | Method |
| --- | --- |
| Quotation number (running no.) | `DB_RunningNo.next()` / `.nextCommitted()` (**new, reusable**) |
| Post-payment orchestration | `FWCMSQuotation.generateQuotation()` (**new controller**) |
| FWIG cover-note number | `DB_FWIG.getFWorkerNo()` (reused) |
| FWHS cover-note number | `DB_FWHS.getREFNO()` (reused; the equivalent of the referenced `getCoverNoteFloat2`) |
| Transaction record | `DB_FWIG.insert_transaction()` / `DB_FWHS.insert_transaction()` |
| FWIG CN header | `DB_FWIG.Insert_FWIGCN()` |
| FWIG worker/summary master | `DB_FWIG.Insert_FWIGMAST()` |
| FWIG premium schedule | `DB_FWIG.Insert_FWIGSCH_CFMKT()` |
| FWHS CN header | `DB_FWHS.Insert_FWHSCN2()` |
| FWHS premium schedule | `DB_FWHS.Insert_FWHSSCH()` |
| FWHS worker items | `DB_FWHS.Insert_FWHSITEM()` |
| Online DTL issue stamp | `FWCMSOnline.updateFWCMSONLINEDTLIssued()` (existing) |

## 9. Compatibility, business rules & side effects

- **Quotation only after payment** — the class tables are never written before
  the gateway; an abandoned or failed payment leaves no orphan quotation.
- Transaction ordering matches the legacy save (transaction → CN → master →
  schedule → items), and each product commits/rolls back as one unit.
- Cover-note generation uses the existing legacy generators — no parallel
  numbering scheme. Only the FWCMS *reference* number changed (ITR-with-`-0*`
  → reusable running number `Q00001…`); `FWCMSREFNO` is a display field, not a
  lookup key, so downstream reads are unaffected.
- The online tables remain the portal's tracking record; the `UUID`→`CNCODE`
  linkage is written back after generation so both views stay consistent.
- No legacy business logic was modified; the portal only *calls* it.

### Side effects / dependencies to watch

- **Running-number gaps.** `DB_RunningNo.nextCommitted` commits the number on
  its own connection before the class-table insert. If that insert then rolls
  back, the quotation number is consumed and a gap appears in the series. Gaps
  are expected for running numbers and carry no business meaning.
- **`TB_RUNNING_NO` must exist.** Missing table → generation throws and the
  product is not issued (logged; the issued-policies table simply omits it).
- **Payment must be confirmed first.** `pop_fwcms_generate_quotation.jsp`
  refuses to generate unless `PAYMENT_STATUS='PAID'`; `payment_result.jsp`
  stamps PAID before calling the generator. A real gateway callback must stamp
  PAID before invoking generation.
- **Printing depends on generation.** Documents render only from the class
  tables, so a product whose generation failed will not print until it is
  regenerated (the flow is idempotent, so re-hitting the endpoint retries it).
- **No `MCK…` fallback on this path.** Unlike the previous pre-payment flow,
  the post-payment generator does not stamp a mock cover note on failure — a
  paid product either has a real quotation or is retried; it is never left
  printable with mock data.
