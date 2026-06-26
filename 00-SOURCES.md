# Sources Of Truth (Full Uniswap Bounty Workspace)

This workspace contains a local, multi-repo Uniswap bounty review environment.

## Local audit workspace

- Audit workspace: `Full-UniSwap-BugBounty/`
- Active high/critical review prompt:
  - `Full-UniSwap-BugBounty/Prompts/HighCriticalOnly.md`
- Repro and tracking formats:
  - `Full-UniSwap-BugBounty/TestedVectors.md`
  - `Full-UniSwap-BugBounty/ScreenedVectors.md`
  - `Full-UniSwap-BugBounty/GoodBountyTarget.md`
- RPC endpoints for forked testing:
  - `Full-UniSwap-BugBounty/Web3Resources/RPC_URLS.md`

## Local repo evidence (primary)

Use these first before making assumptions:

- `v4-core/`
  - v4 core AMM logic, flash accounting, hooks, settlement, pool math, and security docs.
- `v3-core/`
  - v3 factory/pool logic, tick math, fee accounting, oracle observations, and audits.
- `permit2/`
  - Permit2 signature-transfer and allowance-transfer authority.
- `universal-router/`
  - command routing, Permit2 integration, sweeps, unwraps, partial fills, and deploy-address metadata.
- `UniswapX/`
  - order reactors, Permit2 witness settlement, filler callbacks, deployed reactor versions, and audits.
- `protocol-fees/`
  - token jars, protocol-fee adapters, releasers, burn/release flows, deployments, and audits.
- `liquidity-launcher/`
  - token launch, distribution, LBP strategies, v4 pool initialization, deployed addresses, and audits.
- `continuous-clearing-auction/`
  - CCA factory, auction settlement, price discovery, deployment guide, and audits.
- `interface/`
  - app, package, transaction-building, CI/release, and supply-chain context. Treat as secondary unless a local issue plausibly reaches user funds, malicious transactions, or user-consumed artifacts.

## Scope-relevant gaps

The live Cantina scope references additional areas that are not present in this local checkout at the time of this note:

- v2 core/periphery contracts
- The Compact
- some Unichain L1/bridge/fault-proof contract surfaces

Do not silently exclude those areas. Record them as `scope-relevant but not locally present` and fetch the relevant repo or park the lane when needed.

## Web evidence (volatile; verify when reporting)

- Live bounty rules/scope/reward matrix:
  - `https://cantina.xyz/bounties/f9df94db-c7b1-434b-bb06-d1360abdd1be`
- Uniswap bug bounty entry point:
  - `https://uniswap.org/bug-bounty`
- Uniswap v4 bounty announcement/context:
  - `https://blog.uniswap.org/v4-bug-bounty`
- Uniswap docs:
  - `https://docs.uniswap.org/`
- Foundry/Anvil reference:
  - `https://book.getfoundry.sh/anvil/`

## Freshness note

Dynamic bounty data including scope, payout caps, out-of-scope lists, deployment status, and finding counts can change.
Always re-check the live Cantina page before final submission.

Last verified against live Cantina page: **2026-06-03**
