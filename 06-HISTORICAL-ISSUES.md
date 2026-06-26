# Historical Security References (Uniswap v4)

## 1. Security policy and reporting

Source of truth:

- `v4-core/SECURITY.md`
- `https://uniswap.org/bug-bounty`

## 2. Prior review evidence in-repo

Local audit artifacts in `v4-core/docs/security/audits/`:

- `OpenZeppelin_audit_core.pdf`
- `TrailOfBits_audit_core.pdf`
- `DRAFT_Certora_audit_core.pdf`
- `DRAFT_Spearbit_audit_core.pdf`
- `DRAFT_ABDK_audit_core.pdf`

Additional local security note:

- `v4-core/docs/security/Known_Effects_of_Hook_Permissions.pdf`

## 3. Public program/security context

Uniswap’s v4 bounty announcement references:

- Nine independent audits
- A prior $2.35M security competition with 500+ researchers
- Ongoing bounty process via Cantina

Reference:

- `https://blog.uniswap.org/v4-bug-bounty`

## 4. Why this matters for triage

Many low-signal findings are duplicates of already-known classes from prior audits/competitions.
Before escalating, always check:

- Existing audit coverage for the same pattern
- Whether the issue is explicitly listed as out of scope in the live bounty rules
- Whether exploitability remains after realistic preconditions are applied

## 5. Current-source requirement

Historical context is useful, but **live Cantina scope/reward/out-of-scope rules** are authoritative for submission.
