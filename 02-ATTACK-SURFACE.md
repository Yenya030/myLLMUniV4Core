# Attack Surface Analysis - Uniswap v4 Core

## Overview

This document maps high-signal attack surfaces in `v4-core` for bounty-focused review. It is a v4-specific companion to the broader multi-repo prompt in `Full-UniSwap-BugBounty/Prompts/HighCriticalOnly.md`.

## 1. Core state transition and unlock accounting

Primary code:

- `v4-core/src/PoolManager.sol`
- `v4-core/src/libraries/Pool.sol`
- `v4-core/src/libraries/TransientStateLibrary.sol`
- `v4-core/src/libraries/CurrencyDelta.sol`

High-impact bug classes:

- Broken unlock invariant (net delta not enforced correctly)
- Unauthorized action sequencing inside callback flow
- Incorrect settlement/take/settle interactions leading to asset extraction
- Reentrancy-like state confusion across multi-action unlock sessions

## 2. Hook integration and callback permissions

Primary code:

- `v4-core/src/libraries/Hooks.sol`
- `v4-core/src/interfaces/IHooks.sol`
- `v4-core/src/interfaces/callback/IUnlockCallback.sol`
- `v4-core/docs/security/Known_Effects_of_Hook_Permissions.pdf`

High-impact bug classes:

- Permission bit or callback routing mistakes
- Callback ordering inconsistencies before/after swap/liquidity actions
- Hook return-value abuse producing accounting or fee manipulation
- Unexpected control-flow paths enabling bypass of intended checks

## 3. Math-critical swap/tick/liquidity behavior

Primary code:

- `v4-core/src/libraries/SqrtPriceMath.sol`
- `v4-core/src/libraries/SwapMath.sol`
- `v4-core/src/libraries/TickMath.sol`
- `v4-core/src/libraries/FullMath.sol`
- `v4-core/src/libraries/LiquidityMath.sol`

High-impact bug classes:

- Precision/rounding errors with extractable value
- Boundary over/underflow near tick or sqrt-price limits
- Directional asymmetries causing one-sided value leakage
- Incorrect fee growth/accounting under edge conditions

## 4. Protocol fee and dynamic fee handling

Primary code:

- `v4-core/src/ProtocolFees.sol`
- `v4-core/src/libraries/ProtocolFeeLibrary.sol`
- `v4-core/src/libraries/LPFeeLibrary.sol`

High-impact bug classes:

- Fee mis-accounting between LPs and protocol
- Unauthorized fee parameter manipulation
- Edge-case fee rounding creating systematic drain vectors

## 5. ERC6909 claims/mint/burn accounting

Primary code:

- `v4-core/src/ERC6909.sol`
- `v4-core/src/ERC6909Claims.sol`

High-impact bug classes:

- Claim accounting mismatch leading to over-redemption
- Mint/burn edge cases causing supply/account drift
- Authorization/path confusion between manager and token accounting

## 6. External token and transfer assumptions

Primary code:

- `v4-core/src/interfaces/external/IERC20Minimal.sol`
- transfer and settlement paths in `PoolManager`/libraries

High-impact bug classes:

- Non-standard token behavior breaking assumptions
- State inconsistencies when token transfers fail/revert unexpectedly
- Value extraction via malformed token behaviors in callback sequences

## 7. Initialization and pool-key integrity

Primary code:

- `v4-core/src/types/PoolKey.sol`
- init paths in `v4-core/src/PoolManager.sol`

High-impact bug classes:

- Invalid or ambiguous pool identity construction
- Hook/currency/tick-spacing combinations that bypass assumptions
- Initialization-time states that permit later exploitation

## Practical testing note

Bounty policy forbids live testing on public chains and explicitly recommends local forks.
For this workspace, run live-state experiments via **Anvil + forked RPC** from:

- `Full-UniSwap-BugBounty/Web3Resources/RPC_URLS.md`
