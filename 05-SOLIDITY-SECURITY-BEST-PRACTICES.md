# Solidity Security Best Practices For Uniswap v4 Reviews

## Overview

This checklist is tailored to identifying exploitable bugs in AMM core logic.

## 1. Arithmetic and precision discipline

- Inspect rounding direction at every value transfer boundary.
- Verify no exploitable asymmetry between exact-in and exact-out paths.
- Confirm boundary checks for tick/price/liquidity math are complete.

## 2. State-machine integrity

- Validate sequencing assumptions across `unlock` callback flow.
- Ensure temporary/transient accounting cannot be left in invalid states.
- Confirm all externally reachable paths preserve core invariants.

## 3. Hook safety model

- Treat hooks as adversarial unless constrained by explicit checks.
- Verify callback permissions map exactly to intended lifecycle hooks.
- Check post-hook state assumptions before continuing core execution.

## 4. Authorization and trust boundaries

- Confirm privileged actions cannot be reached by untrusted callers.
- Check manager-only operations and interface assumptions.
- Validate cross-contract trust (callbacks, fees, claims, token transfers).

## 5. External call and token behavior hardening

- Account for tokens with non-standard transfer behavior.
- Review external calls for reentrancy-like state confusion.
- Ensure failures cannot create partial accounting commits.

## 6. Regression-oriented validation

For every candidate bug:

- Add/adjust the smallest targeted test possible.
- Encode preconditions directly in test setup.
- Record exact command and output in `TestedVectors.md`.

## 7. Bounty-quality reporting

A strong submission includes:

- Concrete impact (economic or protocol integrity)
- Reliable reproduction steps
- Exact affected paths and root cause
- Minimal remediation direction
