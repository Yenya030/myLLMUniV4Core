# Ethereum Smart Contract Security Practices (Uniswap v4-Oriented)

## Overview

For Uniswap v4 core reviews, high-value findings are those that can produce material user/protocol loss or protocol-integrity failures.

## 1. Invariant-first auditing

Prioritize invariants that must hold across all pool actions:

- Unlock session net accounting must reconcile correctly
- Pool state transitions must be monotonic/consistent under valid actions
- Fee accounting must conserve value across LP/protocol buckets
- Hook invocation must not violate authorization boundaries

## 2. Attacker model realism

Use realistic attacker capabilities:

- Arbitrary calldata and transaction ordering
- Malicious hook contracts (within allowed model)
- Adversarial token behaviors (non-standard ERC20 quirks)
- Multi-step exploit sequences inside one unlock flow

Avoid low-value reports that require impossible assumptions.

## 3. Economic impact framing

For bounty acceptance, frame impact in terms of:

- Potential theft/freeze magnitude
- Repeatability and exploit reliability
- Required preconditions and attacker cost
- Whether issue is in default/normal usage paths

## 4. Differential/edge testing

Focus on edge conditions where bugs hide:

- Tick/price boundaries and near-overflow arithmetic
- Zero/one/min-max liquidity transitions
- Fee tier and dynamic fee boundary values
- Cross-function sequencing under callback control

## 5. Proof standard

Do not claim a bug without one of:

- Deterministic failing test in allowed test paths, or
- Minimal repro harness with exact steps and expected/actual mismatch

## 6. Disclosure compliance

Program rules require:

- No public disclosure before authorization
- Private reporting through official bounty channel
- No live testing on public chains

Use local forks (Anvil) for live-state experiments.
