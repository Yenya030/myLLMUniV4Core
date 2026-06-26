# Uniswap Cantina Bug Bounty: Cheat Sheet

Fast reference for preparing high-signal submissions from this workspace.

## Source of truth

- Live rules: `https://cantina.xyz/bounties/f9df94db-c7b1-434b-bb06-d1360abdd1be`
- Entry point: `https://uniswap.org/bug-bounty`
- Context post: `https://blog.uniswap.org/v4-bug-bounty`
- Active local review prompt: `Full-UniSwap-BugBounty/Prompts/HighCriticalOnly.md`

Last verified against live Cantina page: **2026-06-03**

## Current local posture

Use a **smart-contract-first, supply-chain-aware** review strategy.

Primary local targets:

- `v4-core/`
- `v3-core/`
- `permit2/`
- `universal-router/`
- `UniswapX/`
- `protocol-fees/`
- `liquidity-launcher/`
- `continuous-clearing-auction/`

Secondary/contextual target:

- `interface/` for local transaction-construction, package, release, and app-build issues only when a plausible chain reaches user funds, wallet-draining transactions, malicious artifacts, or deployed operations.

Live-scope gaps in this checkout:

- v2 contracts
- The Compact
- some Unichain contract surfaces

Mark these as `scope-relevant but not locally present` until code is added.

## Hard rules to enforce during testing

- No live testing on public chains.
- No live testing against hosted services or production APIs.
- Use local forks for live-state testing.
- Keep findings confidential until authorized disclosure.
- Re-check live scope before submission.

Workspace execution standard:

- Run local forks with **Anvil**.
- Use RPC endpoints from `Full-UniSwap-BugBounty/Web3Resources/RPC_URLS.md`.
- Prefer native repo tests for PoCs.

## High-value categories

- Theft, permanent freeze, or severe mis-accounting of user, LP, auction, launch, order, or protocol-fee assets.
- Permit/signature/authorization bypass in Permit2, routers, reactors, or release flows.
- Asset custody mismatch across routers, fillers, auctions, launchers, token jars, and releasers.
- Hook/callback/partial-fill/settlement boundary breaks with economic consequence.
- Math/invariant violations with extractable economic impact.
- Deployment/version mismatches where deployed code, README addresses, release tags, or packages disagree in a security-relevant way.
- Release/package/workflow compromise paths that can publish malicious artifacts used by users or integrators.

## Triage pitfalls

- Purely theoretical issues without reproducible exploit path.
- V4 hook issues that are intended extensibility or only defense in depth.
- UniswapX `src/v4/Reactor.sol` findings unless live scope changes; current live text says it is pre-production, deprioritized, and out of scope.
- Findings requiring unrealistic operator assumptions, admin compromise, majority governance control, or whale-level market manipulation.
- Duplicates of known audit findings without new trigger, affected deployment, proof, or impact upgrade.
- Out-of-scope asset/type/version mismatches.
- User-deception, phishing, MITM, or broken-browser assumptions.

## Severity framing guidance

Use bounty risk framing: **Impact x Likelihood**, plus exploit maturity and report quality.

When writing impact:

- State maximum plausible loss/freeze magnitude.
- State repeatability and attacker cost.
- State affected deployment/version/scope bucket.
- State required preconditions explicitly.
- Explain why existing mitigations fail.

## Minimum evidence bar

Each serious candidate should have:

- deterministic repro test/script/fork replay/local build proof
- exact project, file, symbol, and target revision/deployment references
- one-paragraph root-cause statement
- quantified impact and realistic preconditions
- duplicate/out-of-scope analysis
- patch direction concise enough for implementers

## Submission hygiene

- Log attempted vectors in `Full-UniSwap-BugBounty/TestedVectors.md`.
- Log negative screens, parked ideas, duplicate closures, scope gaps, and out-of-scope notes in `Full-UniSwap-BugBounty/ScreenedVectors.md`.
- Promote only strongest vectors to `Full-UniSwap-BugBounty/GoodBountyTarget.md`.
- Re-check live bounty page before submission for scope/reward updates.
