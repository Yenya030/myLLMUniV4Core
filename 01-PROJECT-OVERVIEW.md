# Uniswap v4 Core Project Overview

## Project Information

- **Upstream repository:** `Uniswap/v4-core`
- **Workspace path:** `v4-core/`
- **Repository remote:** `https://github.com/Uniswap/v4-core.git`
- **Local checked commit:** `d153b048868a`
- **Project type:** Non-upgradeable AMM core smart contracts
- **Language:** Solidity (tests in Solidity and TS)
- **Package version:** `@uniswap/v4-core@1.0.2` (`v4-core/package.json`)

## What v4-core does

`v4-core` hosts Uniswap v4 core pool logic for:

- Pool creation/initialization
- Swaps
- Liquidity modifications
- Donations
- Settlement/accounting flows
- Hook-based custom behavior around pool lifecycle actions

Core architecture is singleton-oriented around `PoolManager.sol` with an `unlock` + callback flow.

## High-value contract surfaces

Primary contracts and modules:

- Core manager and accounting:
  - `v4-core/src/PoolManager.sol`
  - `v4-core/src/ProtocolFees.sol`
  - `v4-core/src/ERC6909.sol`
  - `v4-core/src/ERC6909Claims.sol`
- Hook integration and permissions:
  - `v4-core/src/libraries/Hooks.sol`
  - `v4-core/src/interfaces/IHooks.sol`
  - `v4-core/src/interfaces/callback/IUnlockCallback.sol`
- Math / price / tick / swap logic:
  - `v4-core/src/libraries/SqrtPriceMath.sol`
  - `v4-core/src/libraries/SwapMath.sol`
  - `v4-core/src/libraries/TickMath.sol`
  - `v4-core/src/libraries/Pool.sol`
- State access helpers:
  - `v4-core/src/Extsload.sol`
  - `v4-core/src/Exttload.sol`

## Test & execution conventions

From `v4-core/justfile` and Foundry config:

- Build: `forge build`
- Test: `forge test --isolate`
- Format: `forge fmt`
- Solidity compiler pinned in `foundry.toml`:
  - `solc = "0.8.26"`
  - `evm_version = "cancun"`
  - `via_ir = true`

## Security reporting policy

Per `v4-core/SECURITY.md`:

- Bug bounty details: `https://uniswap.org/bug-bounty`
- Security contact: `security@uniswap.org`

Do not publish public vulnerability details before coordinated disclosure.

## Audit objective alignment

For this workspace, prioritize vulnerabilities with meaningful protocol impact and bounty viability:

- Theft, permanent freezing, or major value-at-risk accounting failures
- Hook/callback boundary breaks that allow unauthorized state changes
- Invariant violations in swap/liquidity math that produce exploitable mis-accounting
- Permission/model breaks around pool lifecycle or fee handling
