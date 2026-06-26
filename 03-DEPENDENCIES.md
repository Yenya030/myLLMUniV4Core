# Uniswap v4 Dependencies (Security-Relevant Notes)

## Overview

This is a security-focused shortlist of relevant dependencies and toolchain settings for `v4-core`. It remains a v4-specific companion to the broader multi-repo bounty workspace.

Primary dependency sources:

- `v4-core/remappings.txt`
- `v4-core/foundry.toml`
- `v4-core/package.json`
- Foundry libraries under `v4-core/lib/`

## Compiler and EVM settings

From `v4-core/foundry.toml`:

- `solc = "0.8.26"`
- `evm_version = "cancun"`
- `via_ir = true`
- high optimizer runs configured (`optimizer_runs = 44444444`)

Review implication:

- Repros should be validated under repo-native compiler/EVM settings.

## Solidity/testing libraries (from remappings)

- `forge-std`
- `ds-test`
- `@openzeppelin` contracts
- `solmate`
- `hardhat` remap present for mixed tooling compatibility

Review implication:

- Check interactions with helper/test patterns to avoid false positives caused by harness behavior.

## JavaScript/TS test surface

`v4-core/test/js-scripts/` includes scripts used by tests and math cross-checks.

Review implication:

- For math-heavy findings, compare Solidity behavior against test helpers in this directory.

## Operational dependencies for this audit workspace

- Foundry/Anvil runtime behavior:
  - `https://book.getfoundry.sh/anvil/`
- RPC providers for forked testing:
  - `Full-UniSwap-BugBounty/Web3Resources/RPC_URLS.md`

## Security focus areas tied to dependencies

- Compiler-sensitive arithmetic/rounding behavior
- Token behavior assumptions against non-standard ERC20s
- Test harness fidelity when reproducing edge cases
- Forked-state reproducibility under Anvil
