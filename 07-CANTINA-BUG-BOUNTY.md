# Uniswap Cantina Bug Bounty (Working Summary)

This file summarizes bounty details needed for triage-quality security work across the local Uniswap ecosystem checkout.

## Primary references

- `https://uniswap.org/bug-bounty`
- `https://cantina.xyz/bounties/f9df94db-c7b1-434b-bb06-d1360abdd1be`
- `https://blog.uniswap.org/v4-bug-bounty`

Last verified: **2026-06-03**

## 1. Program status and headline values

From the live Cantina page on 2026-06-03:

- Program status: **Live**
- Listed maximum reward: **$15,500,000**
- Deposit required: `$50`
- Findings submitted at verification time: `777`
- Headline payout table includes:
  - Critical: `$15,500,000`
  - High: `$1,000,000`
  - Medium: `$100,000`

These values are volatile. Re-check live scope, finding count, reward caps, and exclusions before submission.

## 2. Scope details most relevant to this workspace

Live rules include broad Uniswap scope, including:

- Smart Contract - Uniswap v4 Core
- Smart Contract - Other Uniswap Contracts
- Web applications and other Uniswap-owned web applications
- Uniswap infrastructure
- Unichain contracts
- v3 core and v3 periphery
- v2 contract code
- The Compact
- Token Launcher
- Continuous Clearing Auction
- Open source and supply-chain vulnerabilities in Uniswap-owned repos and release pipelines

Practical local focus:

- Use a smart-contract-first, supply-chain-aware posture.
- Prioritize locally present contract repos with deployed/current user impact: `v4-core/`, `v3-core/`, `permit2/`, `universal-router/`, `UniswapX/`, `protocol-fees/`, `liquidity-launcher/`, and `continuous-clearing-auction/`.
- Treat `interface/`, CI/CD, package publishing, docs/scripts, and release pipelines as secondary lanes unless a plausible chain reaches malicious transaction construction, wallet drain, artifact compromise, deployed contract compromise, or downstream user/protocol loss.
- Treat v2, The Compact, and missing Unichain contract surfaces as live-scope but not locally present until the relevant code is added.

## 3. Version and deployment handling

- For `v4-core`, the local notes preserve pinned commit `b619b6718e31aa5b4fa0286520c455ceb950276d` as the v4-core scope anchor when live scope references it.
- For repos with deployment tables, deployed-commit branches, release tags, or package versions, tie findings to the deployed/current version actually consumed by users.
- If a candidate exists only on local `main` and not on a deployed/current/pinned target, treat it as lower-confidence unless live scope clearly includes that source.
- The live page explicitly notes `https://github.com/Uniswap/UniswapX/blob/main/src/v4/Reactor.sol` is pre-production, deprioritized, and out of scope at this time.

## 4. Prohibited actions and disclosure constraints

Live rules explicitly state:

- No live testing on public mainnet/testnet deployments.
- Do not test against live hosted services.
- Use local environments such as Foundry forks.
- Do not exploit, exfiltrate data, disrupt service, or publicly disclose without authorization.
- Disclosure timing guidance includes reporting as soon as possible, ideally within 24 hours of discovery.

Workspace policy alignment:

- Live-state experiments must use **Anvil + local forks** with RPCs from `Web3Resources/RPC_URLS.md`.
- Web/app/infrastructure/supply-chain lanes must be reproduced locally or statically unless separate authorization exists.

## 5. Impact/likelihood model used by bounty

The program uses a weighted payout model:

- Impact carries the largest weight.
- Likelihood considers capital requirements, transaction complexity, timing sensitivity, detectability, and market dependency.
- Exploit maturity and report quality also affect payout.

Practical implication for report quality:

- Include explicit exploitability assumptions and expected blast radius.
- Quantify funds at risk or protocol/user impact.
- Show why current mitigations do not prevent the exploit.
- Show why the issue maps to the claimed risk score under the live program.

## 6. Out-of-scope patterns to avoid

The live rules include explicit out-of-scope categories, including:

- gas optimization without security impact
- theoretical issues without practical exploit path
- third-party protocol bugs unless caused by Uniswap code
- known MEV strategies that work as intended
- social engineering, phishing, user-device compromise, or MITM
- compromised admin keys unless the issue enables compromise
- nonstandard or broken browser behavior assumptions
- testnet-only issues without mainnet impact
- best-practice critiques without exploitable vulnerability
- economic attacks requiring unrealistic capital
- governance attacks requiring majority control

Before escalating a finding, check whether it is excluded under the current bounty text and local `ProgramInfo/OutOfScope.md`.

## 7. Submission-quality checklist

For strongest acceptance probability, each report should include:

- Exact affected project, files, contracts, and functions
- Target revision, deployed version, release tag, or package version tested
- Minimal deterministic reproduction
- Concrete impact statement with realistic preconditions
- Precise impact quantification
- Why issue is not duplicate, intended, or out of scope
- Consideration of existing mitigations
- Minimal safe remediation direction

## 8. Local artifact routing

- Active high/critical prompt: `Full-UniSwap-BugBounty/Prompts/HighCriticalOnly.md`
- Candidate vectors: `Full-UniSwap-BugBounty/TestedVectors.md`
- Negative screens and parked ideas: `Full-UniSwap-BugBounty/ScreenedVectors.md`
- Strongest submission targets: `Full-UniSwap-BugBounty/GoodBountyTarget.md`
