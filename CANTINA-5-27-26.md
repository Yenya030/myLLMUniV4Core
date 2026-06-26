# Uniswap Cantina Bounty Notes - 2026-05-27

Source checked: `https://cantina.xyz/bounties/f9df94db-c7b1-434b-bb06-d1360abdd1be`

These notes capture live bounty text and triage-relevant details as of 2026-05-27. They are historical raw notes. Use `07-CANTINA-BUG-BOUNTY.md` and `CANTINA-BUG-BOUNTY-CHEAT-SHEET.md` for the current multi-repo working summary. Re-check the live page before submission because scope, rewards, exclusions, and finding counts can change.

Verified headline values on 2026-05-27:

- Program: Uniswap
- Status: Live
- Maximum reward: $15,500,000
- Critical: $15,500,000
- High: $1,000,000
- Medium: $100,000
- Deposit required: $50
- Findings submitted at verification time: 765
- Start date: 26 Nov 2024

Pinned v4-core scope anchor noted for this workspace:

- `b619b6718e31aa5b4fa0286520c455ceb950276d`
- Local git metadata: commit date 2024-11-08, subject `standardize the init code hash (#917)`.
- This commit is an ancestor of the `v4.0.0` release tag, not an arbitrary stale branch. Reproduce v4-core findings against this commit when assessing bounty eligibility unless the live scope says otherwise.

## Raw Working Notes

What We're Looking For

Smart Contract Vulnerabilities

Protocol-level bugs that affect core AMM functionality, liquidity provision, or fee collection
Integration vulnerabilities in hooks, periphery contracts, or external integrations
Economic exploits that enable unfair value extraction or manipulation
Access control issues that bypass intended permissions or restrictions
Infrastructure & Deployment Issues

Deployment configuration errors that could be exploited before contracts are properly configured
Upgrade mechanism vulnerabilities (where applicable)
Cross-chain bridge or messaging vulnerabilities affecting Unichain
Web Application Vulnerabilities

Transaction manipulation that tricks users into signing malicious transactions
Wallet draining attacks through XSS or other client-side vulnerabilities
Phishing vectors on official domains that could compromise user funds
API vulnerabilities that expose sensitive data or enable unauthorized actions
Open Source & Supply Chain Vulnerabilities (Uniswap-owned repos and release pipelines)

Release / CI compromise paths that could publish a malicious build, package, container, or artifact (e.g., tampering with build steps, signing, publishing, or dependencies).
Dependency confusion / namespace takeover risks involving packages used by Uniswap projects (including transitive deps), where exploitability is demonstrated (e.g., realistic install path in CI or consumer environments).
Malicious package injection opportunities (npm/pypi/etc.) via misconfigured publishing, weak provenance, or missing pinning/lockfile controls when you can show impact (what gets executed, where, and who consumes it).
Repository-level compromise primitives (e.g., token leakage, vulnerable GitHub Actions, PR workflow abuse) that could lead to unauthorized code execution in CI, secret exfiltration, artifact tampering, or downstream compromise via released binaries/packages.
Documentation / examples / scripts that meaningfully increase risk (e.g., runnable install scripts, copy-paste snippets) only if there’s a plausible exploit chain (not purely theoretical).
What We're NOT Looking For

Gas optimization suggestions without security impact
Theoretical vulnerabilities with no practical exploit path
Issues in third-party protocols that integrate with Uniswap (unless caused by Uniswap code)
MEV strategies that work as intended (e.g., sandwich attacks using public mempools)
Issues that rely on user error, such as social engineering, phishing, and other scenarios where the user follows malicious instructions supplied by an attacker or otherwise acted against their own interest, including any attack requiring access to or control of an end-user’s device or network traffic (e.g., RATs, physical compromise, MITM attacks)
UI/UX improvements without security implications
Vulnerabilities requiring compromised admin keys (unless the vulnerability enables the compromise)
Vulnerabilities requiring machine compromise of an employee device or the Uniswap Labs team's internal assets (e.g., targeted social engineering attacks against Uniswap team members, attacks involving a compromised developer workstation, etc.)
Any reports that depend on nonstandard or broken browser behavior are out of scope, for example, scenarios that require browsers to ignore established security controls (such as HttpOnly cookie protections or CORS enforcement).
Phishing of any kind (vishing, spearfishing, etc)
Prohibited Actions

No Unauthorized Testing on Production Environments:

Do not test vulnerabilities on mainnet or public testnet deployments without prior authorization
Instead, use local test environments (e.g., Foundry forks) we can reproduce in a simulated environment
Do not test vulnerabilities against any live hosted service
Instead, show how the issue manifests and provide a proof-of-concept we can validate against an isolated environment
No Public Disclosure Without Consent:

Do not publicly disclose details of any vulnerability before your report has been fully resolved (i.e., after final disposition has been established, the report has been closed, and any associated payout has been confirmed)
You must receive written permission from Uniswap Labs prior to any public disclosure, at this time we do not typically allow public disclosure but please feel free to ask us anyway.
No Exploitation or Data Exfiltration:

Do not exploit the vulnerability, rather provide a proof-of-concept with the minimum steps necessary to demonstrate the issue
Do not access private data, engage in social engineering, or disrupt service
No Conflict of Interest:

Individuals currently or formerly employed by Uniswap Labs are ineligible
Those who contributed to the development of the affected code are ineligible
Disclosure Requirements

Please report vulnerabilities directly through the Spearbit/Cantina platform. Include:

A clear description of the vulnerability and its impact
Steps to reproduce the issue, ideally with a proof of concept
Details on the conditions under which the issue occurs
Potential implications if the vulnerability were exploited
Precise impact quantification (e.g., "allows stealing up to $X from pool Y")
Analysis of affected contracts/functions
Consideration of existing mitigations
Reports should be made as soon as possible—ideally within 24 hours of discovery. While we encourage reporting all identified issues, please note that we do not guarantee a payout for every individual bug report. We check for propagation, but if a rare instance is missed, your report is still valuable.

Proof of Concept Requirements

For ALL reports, you must include a functional proof-of-concept demonstrating the vulnerability in realistic conditions. You must also provide a detailed walk-through of the entire attack scenario and all relevant assumptions, preconditions, economic considerations, etc., as well as reproduction steps and an explanation of the impact of the vulnerability.

For smart contract related reports, we strongly recommend writing a Foundry/Forge test suite or script that runs against a fork of a suitable network (e.g. mainnet). This will allow us to rapidly validate your report and determine its severity. You should also include a proposed mitigation where possible. If the exploit is economic in nature, include a clear calculation of the value at risk.

For other types of vulnerabilities, including attacks against web servers or other infrastructure, we recommend providing a minimal attack script written in Typescript or Python. If it is not possible to provide a functional exploit script, your report must outline the vulnerability in sufficient detail to enable our team to confirm its validity. We also encourage you to include a proposed mitigation plan and video demonstration.

Note that failing to provide a functional proof-of-concept greatly increases the probability of your report being rejected.

Report Triage

All submissions are reviewed and assigned for triage based on their scope: issues related to smart contracts and protocol logic are triaged by the Protocols team, and vulnerabilities in web applications and backend systems are triaged by the AppSec team.

Payout Calculator

Final Payout = Base Severity Reward × (0.60 × Impact Score + 0.25 × Likelihood Score + 0.10 × Exploit Maturity Score + 0.05 × Report Quality Score)

Impact Multiplier (60% weight)

Impact
Level	Multiplier
Critical	1.0
High	0.7 - 0.9
Medium	0.4 - 0.6
Low	0.1 - 0.3
Impact is determined by:

Funds at risk
PII/Privacy Data at risk
Scope of affected users
Protocol integrity compromise
Reputational/regulatory exposure
Likelihood Multiplier (25% weight)

Likelihood
Level	Multiplier
High	1.0
Medium	0.6 - 0.8
Low	0.3 - 0.5
Key drivers:

Capital required
Transaction complexity
Timing sensitivity
Detectability
Market condition dependency
Exploit Maturity Modifier (10%) - Subjective

Level
Multiplier
Fully weaponized PoC	1.0
Working local fork exploit	 0.9
Partial PoC	 0.7
Theoretical	 0.4
Report Quality Modifier (5%)

Quality
Multiplier
Exceptional	1.0
Clear & Complete	0.9
Poorly documented	 0.6
Scope with Classification Examples

Smart Contract - Uniswap v4 Core

Critical Impact Examples (Maximum Reward: $15,500,000)

Vulnerability Type	Example Scenario	Why Critical
Theft of Pooled Liquidity	Reentrancy in modifyLiquidity() allows draining all liquidity from a pool during a single transaction	Affects 20%+ of TVL, immediate user fund loss
Accounting Manipulation	Integer overflow in swap calculation lets attackers drain pool reserves	Protocol insolvency, affects all pools
Hook Bypass	Vulnerability allows bypassing before/after hooks on all swaps, enabling unauthorized state changes	Breaks core security assumptions, affects all v4 pools using hooks
Misconfigured Contract Takeover	A misconfigured core protocol component allows taking ownership or DoS	Catastrophic protocol-wide impact
Flash Accounting Bypass	Exploit in flash accounting system allows withdrawing funds without repaying	Direct theft, affects entire protocol TVL
High Likelihood Indicators

Exploitable by any user with basic knowledge
Requires < $1,000 initial capital
Can be executed in a single transaction
No special timing or conditions needed
High Impact Examples (Maximum Reward: $1,000,000)

Vulnerability Type	Example Scenario	Why High
Single Pool Drain	Bug in specific tick math allows draining high-value pools (e.g., WETH/USDC)	0.5–20% of TVL affected
Oracle Manipulation	Time-weighted average price (TWAP) can be manipulated through specific transaction ordering	Price oracle compromise, affects dependent protocols
Lock Bypassing	Reentrancy mechanism can be bypassed to perform unauthorized nested operations	Security model violation, medium exploitation difficulty
Fee Collection Exploit	Bug allows claiming fees belonging to other LPs in specific conditions	Theft of unclaimed yield
Medium Likelihood Indicators

Requires specific pool configurations or parameters
Needs coordination of multiple transactions
Requires moderate capital ($10K–$100K)
Timing-dependent or requires specific market conditions
Medium Impact Examples (Maximum Reward: $100,000)

Vulnerability Type	Example Scenario	Why Medium
Tick Manipulation	Edge case in tick bitmap causes incorrect liquidity allocation or substantially different swap outcomes than expected	Undermines protocol guarantees, impacts only one pool
Rounding Errors	Minor rounding in specific edge cases causes dust-level losses (<$1 per tx)	Minimal economic impact
Low Likelihood Indicators

Requires rare combination of conditions
Very specific pool parameters needed
Affects only certain token pairs or configurations
Limited economic incentive for attacker
Please note https://github.com/Uniswap/UniswapX/blob/main/src/v4/Reactor.sol is a pre-production contract that has been deprioritized and therefor is out of scope at this time.

Smart Contract – Other Uniswap Contracts

Critical Examples – Up to $2,250,000

Contract Type	Example	Impact
Permit2	Signature validation bypass allows spending any user's tokens	Affects all users using Permit2
Universal Router	Command execution bug allows arbitrary calls with user's token approvals	Direct theft from router users
High Examples – Up to $500,000

Contract Type	Example	Impact
NFT Position Manager	Bug allows transferring someone else's liquidity position NFT	Theft of specific positions
Swap Router	Slippage protection can be bypassed, enabling sandwich attacks beyond tolerance	Affects individual swaps
Web Applications (app.uniswap.org and other Uniswap-owned web applications)

Critical Examples – Up to $250,000

Vulnerability Type	Example	Why Critical
Wallet Drain via XSS	Stored XSS injects malicious transaction parameters during swapping that appear legitimate so that output tokens are sent to the attacker’s address	Direct fund theft
Transaction Replacement	MITM attack replaces recipient address in swap UI (extension injection explicitly out of scope)	Funds sent to attacker
High Examples – Up to $50,000

Vulnerability Type	Example	Impact
Gas Estimation Exploit	Malicious input causes massive gas estimation, draining ETH through failed transactions	Economic attack on users
Medium Examples – Up to $10,000

Vulnerability Type	Example	Impact
Reflected XSS	Non-persistent XSS requiring social engineering to exploit	Limited scope, requires user action
General Flaws	Flaws preventing >1,000 users from purchasing/trading	Denial of service
Uniswap Infrastructure

Infrastructure findings include vulnerabilities affecting Uniswap Labs’ operational environment and supporting systems, including:

Cloud infrastructure (e.g., AWS, GCP, Cloudflare, hosted services)
CI/CD pipelines (GitHub Actions, build systems, deployment workflows, NPM packages)
Container registries and artifact storage
DNS configuration and domain management, PKI
Production deployments and configuration management
Public RPC infrastructure (including Unichain RPC & transaction ingress)
Backend services supporting routing, quoting, or transaction preparation
Secrets management systems
Monitoring and alerting systems (if exploitable)
Infrastructure findings must demonstrate clear and actionable security impact.

Critical Examples – Up to $250,000

Vulnerability Type	Example	Why Critical
CI/CD Pipeline Compromise	Attacker gains control over deployment pipeline (GitHub Actions, artifact registry, NPM) and deploys malicious version of app.uniswap.org	Mass wallet-draining via trusted domain; entire user base affected
Cloud IAM / Secrets Compromise	Access to production IAM roles or secrets (backend signing keys, API tokens, deploy keys)	Modify routing logic, manipulate transactions, inject malicious parameters
DNS Hijack of Official Domain	DNS takeover of app.uniswap.org	Pixel-perfect phishing clone; traffic redirection; direct wallet drain
High Examples – Up to $50,000

Vulnerability Type	Example	Impact
SSRF to Cloud Metadata	SSRF allowing access to AWS IMDS or internal services, demonstrably leveraged for credential retrieval or lateral movement	Privilege escalation, stepping stone to broader compromise
Overly Permissive IAM Policies	Production roles allow unnecessary administrative actions	Viable lateral movement path; potential malicious deployment chain
Production API Exposure Without Auth	Internal/admin APIs accessible without proper auth	Unauthorized routing or operational manipulation
Medium Examples – Up to $10,000

Vulnerability Type	Example	Impact
Minor Privilege Escalation	Escalation within non-production or low-impact service	Limited blast radius; requires chaining
RCE on Unused Instance/System	Legacy unused instance publicly accessible and vulnerable to RCE via outdated dependency	Code execution on internal system owned by Uniswap
Unichain Contracts (L1)

Critical Examples – Up to $2,250,000

Vulnerability Type	Example	Why Critical
Bridge Theft	Canonical bridge vulnerability allows withdrawing ETH without L2 burn	Direct theft of bridged assets
Finality Bypass	Fault proof exploit finalizes invalid state roots	Protocol insolvency
Sequencer Bypass	Force inclusion of malicious transactions bypassing sequencer checks	System integrity compromise
High Examples – Up to $100,000

Vulnerability Type	Example	Why High
Temporary Freeze	Bug allows griefing withdrawals during 7-day challenge period	Temporary fund freeze
Incorrect Bond Math	Challenge bonds drained through dispute sequences	Economic attack on validators
Sequencer Bypass	Malicious inclusion bypasses intended checks	System integrity compromise
NEW: Uniswap v3 Contract Code

v3-Core

Scope

UniswapV3Factory
UniswapV3Pool
All core pool logic and tick math
Deployments
https://docs.uniswap.org/contracts/v3/reference/deployments

Maximum Reward

Critical: $2,250,000
High: $500,000
Medium: $100,000
Example Critical Vulnerabilities

Pool liquidity drainage through tick manipulation
Fee calculation overflow/underflow
Oracle (TWAP) manipulation enabling price attacks
Flash loan callback exploitation
v3-Periphery

Scope

NonfungiblePositionManager (LP NFT minting/management)
SwapRouter and SwapRouter02
QuoterV2 (off-chain quote calculations)
NonfungibleTokenPositionDescriptor
Multicall functionality
Deployments
https://docs.uniswap.org/contracts/v3/reference/deployments

Maximum Reward

Critical: $2,250,000
High: $500,000
Medium: $100,000
Example Critical Vulnerabilities

LP position NFT theft or unauthorized transfers
Slippage protection bypass in router
Unauthorized position modifications
Token approval exploitation through multicall
Example High Vulnerabilities

Incorrect fee collection allowing claiming others' fees
Edge cases in position burning leaving funds locked
Quote manipulation affecting integrators
NEW: Uniswap v2 Contract Code

Scope

UniswapV2Factory
UniswapV2Pair
UniswapV2Router02
Deployments
https://docs.uniswap.org/contracts/v2/reference/smart-contracts/factory

Maximum Reward

Critical: $500,000
High: $100,000
Medium: $50,000
Note
V2 is considered highly stable with years of battle-testing and substantial TVL. Rewards are capped lower than v3/v4 due to maturity, but legitimate critical vulnerabilities remain eligible.

Example Critical Vulnerabilities

Liquidity drain through k-invariant bypass
Reentrancy in swap or liquidity functions
Fee-on-transfer token handling issues causing loss
Example High Vulnerabilities

Price oracle manipulation in low-liquidity pairs
Router slippage protection bypass
NEW: The Compact

Core Compact Contracts (IN SCOPE – PRODUCTION)

Scope

TheCompact.sol – Core attestation and claim system
Compact ERC6909 implementation
Allocation logic
Forced withdrawal mechanisms
Nonce management
Maximum Reward

Critical: $2,250,000
High: $500,000
Medium: $100,000
Example Critical Vulnerabilities

Unauthorized token claims from allocations
Attestation signature forgery or replay
Forced withdrawal exploitation draining user balances
Nonce manipulation enabling double-spends
ERC6909 balance corruption
Example High Vulnerabilities

Allocation lock bypass allowing premature withdrawals
Resource lock griefing attacks
Witness data manipulation in settlements
NEW: Token Launcher + Continuous Clearing Auction

Token Launcher

Scope
Only deployed contracts at the deployment addresses specified in the repository README.

Maximum Reward

Critical: $1,000,000
High: $250,000
Medium: $50,000
Example Critical Vulnerabilities

Initial liquidity theft during launch
Launch sniping or frontrunning
Example High Vulnerabilities

LP position manipulation during initialization
Continuous Clearing Auction (CCA)

Scope
Only deployed auction factories as defined in the repository README.

Maximum Reward

Critical: $1,000,000
High: $250,000
Medium: $50,000
Example Critical Vulnerabilities

Auction manipulation allowing theft of auction proceeds
Settlement bypass enabling unauthorized token claims
Price discovery manipulation
Example High Vulnerabilities

Auction griefing attacks preventing fair participation
Settlement delays causing user fund lockup
MEV exploitation beyond intended auction design
Specific Exclusions

Not Eligible for Rewards

The following categories are explicitly out of scope and not eligible for bounty payouts:

Admin Key Compromise Assumptions
Reports that assume admin key compromise are not eligible unless the reported vulnerability directly enables the compromise.

Known MEV Strategies
Sandwich attacks, arbitrage using public infrastructure, or other MEV behaviors that function as intended within public mempools.

Third-Party Protocol Issues
Bugs in external tokens, price oracles, bridges, or other third-party protocols — even if they affect Uniswap users — unless caused directly by Uniswap-controlled code.

Governance Attacks
Attacks requiring >50% voting power or majority governance control.

Economic Attacks Requiring Massive Capital
Scenarios dependent on unrealistic capital requirements (e.g., “buy all ETH to manipulate price”).

Social Engineering
Phishing campaigns, impersonation, or other user-targeted deception (unless the vulnerability exists on an official Uniswap-owned domain).

Testnet-Only Issues
Vulnerabilities that affect testnet deployments only, unless they demonstrably impact mainnet deployments.

Gas Optimization Suggestions
Gas savings or efficiency improvements without demonstrable security impact.

Best Practice Critiques
General design critiques or deviation from best practices without an exploitable vulnerability.

Theoretical Vulnerabilities
Issues with no realistic, practical exploit path.

Other Terms

By submitting your report, you grant Uniswap Labs any and all rights, including intellectual property rights, needed to validate, mitigate, and disclose the vulnerability. All reward decisions, including eligibility for and amounts of the rewards and the manner in which such rewards will be paid, are made at Uniswap Labs’ sole discretion. The terms and conditions of this Program may be altered at any time. If your report comes across as spam or low-effort AI-generated content, your submission fee will not be refunded. That said, we generally refund submission fees for legitimate, non-spam reports.

What Makes a Strong Submission

✅ Good Submissions

Strong reports typically include:

Precise impact quantification
(e.g., “Allows stealing up to $X from pool Y”)

Clear, reproducible proof of concept (PoC)
Step-by-step reproduction that works in a realistic environment (e.g., mainnet fork).

Detailed analysis of affected contracts/functions
Clear identification of the vulnerable logic and how it is reached.

Consideration of existing mitigations
Explanation of why current protections do not prevent the exploit.

❌ Weak Submissions

The following characteristics significantly reduce the likelihood of a payout:

Vague impact descriptions
(e.g., “could drain funds” without quantification or clear mechanics)

Theoretical issues with no exploit path
No demonstrable way to trigger the vulnerability in practice.

Duplicate of known issues
Previously reported, documented, or acknowledged findings.

Out-of-scope concerns
Issues explicitly excluded under the program’s scope or exclusions.

Enhanced Likelihood Assessment

High Likelihood Checklist

Vulnerabilities are more likely to be rated High Likelihood if they meet most or all of the following:

Exploitable with < $1,000 initial capital
Requires no special privileges, governance power, or whitelisting
Can be executed in fewer than 5 transactions
Works in current market conditions
Profitable at current gas prices
No strict timing dependencies
Medium Likelihood Checklist

Vulnerabilities may be rated Medium Likelihood if they involve:

$10K–$100K initial capital requirements
Specific pool configurations or parameters
5–20 transactions or specific timing requirements
Dependence on market volatility or specific price conditions
Coordination that is feasible but non-trivial
Low Likelihood Checklist

Vulnerabilities are likely to be rated Low Likelihood if they:

Require >$1M capital or whale-level market manipulation
Depend on multiple simultaneous rare conditions
Require unrealistic token pair setups or artificial market scenarios
Would likely be detected and mitigated before completion
Have no clear profit mechanism for the attacker
