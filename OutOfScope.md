# Out Of Scope

Use this as a local reminder, not as a replacement for the live Cantina page.

Current explicitly noted exclusions and weak lanes:

- v4 hooks that were not developed by Uniswap Labs.
- `UniswapX/src/v4/Reactor.sol` while live scope continues to describe it as pre-production, deprioritized, and out of scope.
- Gas optimization without security impact.
- Theoretical issues without a realistic exploit path.
- Third-party token, oracle, bridge, or protocol bugs unless caused directly by Uniswap-controlled code.
- Known MEV strategies that work as intended.
- Social engineering, phishing, user-device compromise, MITM, or broken-browser assumptions.
- Compromised admin keys unless the vulnerability directly enables the compromise.
- Governance attacks requiring majority control.
- Testnet-only issues without demonstrable mainnet/deployed impact.
- Best-practice critiques without an exploitable vulnerability.
- Economic attacks requiring unrealistic capital.

If live scope and this file disagree, live scope wins. Update this file after verification.
