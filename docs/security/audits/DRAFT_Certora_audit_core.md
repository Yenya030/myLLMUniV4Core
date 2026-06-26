| Security            | Assessment |     |     | &   |
| ------------------- | ---------- | --- | --- | --- |
| Formal Verification |            |     |     |     |
| DRAFT PRELIMINARY   |            |     |     |     |
Report
| Uniswap |     | v4  | core |     |
| ------- | --- | --- | ---- | --- |
Date 07/24
Prepared for
Uniswap

Table of content
Project Summary.................................................................................................................................................3
Project Scope..................................................................................................................................................3
Project Overview.............................................................................................................................................3
Protocol Overview.....................................................................................................................................3
Findings Summary..........................................................................................................................................4
Severity Matrix.................................................................................................................................................4
Detailed Findings................................................................................................................................................5
Medium Severity Issues................................................................................................................................6
M-01 Incorrect use of "memory-safe" annotation potentially causing executable code corruption.................6
M-02 Tick may not correspond to the sqrtPrice...............................................................................................7
Low Severity Issues......................................................................................................................................8
L-01 Reachable state degeneration due to price change................................................................................8
L-02 Liquidity addition DoS by filling gross liquidity in initializable ticks..........................................................9
L-03 Incorrect assumptions about most significant bits of narrow types.......................................................11
Informational Severity Issues........................................................................................................................12
I-01. Flash accounting cannot be used for actions that require untrusted calls............................................12
I-02. Same currency can generate multiple token ids...................................................................................12
I-03. Array exttload() and extsload() functions may corrupt results due to improper ABI decoding..............13
Formal Verification............................................................................................................................................14
Assumptions and Simplifications...................................................................................................................14
Verification Notations.....................................................................................................................................14
Formal Verification Properties.......................................................................................................................15
Pool Manager................................................................................................................................................15
P-01. Balance deltas are zero whenever the contract is locked....................................................................15
P-02. Pool Initialization is Done Correctly.....................................................................................................16
P-03. Integrity of swap()................................................................................................................................17
P-04. Modify Liquidity Accounting.................................................................................................................18
P-05. Swap Accounting.................................................................................................................................19
P-06. Valid Liquidity State.............................................................................................................................21
P-07. Valid Pool State...................................................................................................................................22
Protocol Fee Library......................................................................................................................................23
P-01. Correct Fee Calculations.....................................................................................................................23
SqrtPrice Math...............................................................................................................................................24
P-01. Library mathematical properties..........................................................................................................24
TickBitMap Library.........................................................................................................................................29
P-01. Correctness of flipTick().......................................................................................................................29
Disclaimer..........................................................................................................................................................30
About Certora....................................................................................................................................................30
2

| Project |       | Summary |     |     |     |     |
| ------- | ----- | ------- | --- | --- | --- | --- |
| Project | Scope |         |     |     |     |     |
Latest Commit
| Project | Name | Repository | (link) |     | Platform |     |
| ------- | ---- | ---------- | ------ | --- | -------- | --- |
Hash
|                 |     | Uniswap | V4 core |         |              |     |
| --------------- | --- | ------- | ------- | ------- | ------------ | --- |
| Uniswap/v4-core |     |         |         | d5d4957 | EVM/Solidity | 0.8 |
repository
| Project | Overview |     |     |     |     |     |
| ------- | -------- | --- | --- | --- | --- | --- |
This document describes the specification and verification of the UniswapV4-core using the Certora Prover
and manual code review findings. The work was undertaken from May 28th to July 2nd.
| The following | contract | list is included | in our scope: |     |     |     |
| ------------- | -------- | ---------------- | ------------- | --- | --- | --- |
src/*
The Certora Prover demonstrated that the implementation of the Solidity contracts above is correct with
respect to the formal rules written by the Certora team. In addition, the team performed a manual audit of all
the Solidity contracts. During the verification process and the manual audit, the Certora team discovered bugs
| in the Solidity | contracts | code, as listed | below. |     |     |     |
| --------------- | --------- | --------------- | ------ | --- | --- | --- |
| Protocol        | Overview  |                 |        |     |     |     |
Uniswap V4 is the fourth iteration of the Uniswap AMM protocol. It uses the CLMM logic from Uniswap V3 and
creates novel features to be created on top of it through Hooks . Hooks allow flexible AMMs strategies and
protocols to be created on top of Uniswap infrastructure, diminishing the effort and cost that it takes to create
| and innovate | on AMM | strategies and | protocols. |     |     |     |
| ------------ | ------ | -------------- | ---------- | --- | --- | --- |
The actors interacting with this protocol could be labeled as LPs, Swappers, Donators and Hooks. These roles
are not mutually exclusive and the same actor could perform all of these actions.
3

| Findings | Summary |     |     |     |     |     |     |
| -------- | ------- | --- | --- | --- | --- | --- | --- |
The table below summarizes the findings of the review, including type and severity details.
| Severity      |        |        | Discovered |        | Confirmed |          | Fixed |
| ------------- | ------ | ------ | ---------- | ------ | --------- | -------- | ----- |
| Critical      |        |        | 0          |        | 0         |          | 0     |
| High          |        |        | 0          |        | 0         |          | 0     |
| Medium        |        |        | 2          |        | 2         |          | 1     |
| Low           |        |        | 3          |        | 3         |          | 2     |
| Informational |        |        | 3          |        | 3         |          | 3     |
| Total         |        |        | 8          |        | 8         |          | 6     |
| Severity      | Matrix |        |            |        |           |          |       |
|               | High   | Medium |            | High   |           | Critical |       |
| Impact        | Medium |        |            |        |           |          |       |
|               |        | Low    |            | Medium |           | High     |       |
|               | Low    | Low    |            | Low    |           | Medium   |       |
|               |        |        | Low        | Medium |           |          | High  |
Likelihood
4

| Detailed |               | Findings        |     |          |              |     |
| -------- | ------------- | --------------- | --- | -------- | ------------ | --- |
| ID       | Title         |                 |     | Severity | Status       |     |
| M-01     | Incorrect     | use of          |     | Medium   | Acknowledged | and |
|          | "memory-safe" | annotation      |     |          | Fixed        |     |
|          | potentially   | causing         |     |          |              |     |
|          | executable    | code corruption |     |          |              |     |
| M-02     | Tick may      | not correspond  | to  | Medium   | Acknowledged |     |
the sqrtPrice
| L-01 |              |        |       | Low | Acknowledged |     |
| ---- | ------------ | ------ | ----- | --- | ------------ | --- |
|      | Reachable    | state  |       |     |              |     |
|      | degeneration | due to | price |     |              |     |
change
| L-02 | Liquidity | addition DoS | by  | Low | Acknowledged | and |
| ---- | --------- | ------------ | --- | --- | ------------ | --- |
Fixed
|      | filling       | gross liquidity   | in   |               |              |     |
| ---- | ------------- | ----------------- | ---- | ------------- | ------------ | --- |
|      | initializable | ticks             |      |               |              |     |
| L-03 | Incorrect     | assumptions       |      | Low           | Acknowledged | and |
|      | about         | most significant  | bits |               | Fixed        |     |
|      | of narrow     | types             |      |               |              |     |
| I-01 |               |                   |      | Informational | Acknowledged | and |
|      | Flash         | accounting cannot | be   |               |              |     |
Fixed
|     | used for  | actions that | require |     |     |     |
| --- | --------- | ------------ | ------- | --- | --- | --- |
|     | untrusted | calls        |         |     |     |     |
I-02 Same currency can generate Informational Acknowledged and
|      | multiple | token ids |     |               | Fixed        |     |
| ---- | -------- | --------- | --- | ------------- | ------------ | --- |
| I-03 |          |           |     | Informational | Acknowledged | and |
Arrayexttload()andextsload()
|     | functionsmaycorruptresults |     |     |     | Fixed |     |
| --- | -------------------------- | --- | --- | --- | ----- | --- |
duetoimproperABIdecoding
5

| Medium | Severity | Issues |     |     |     |     |     |
| ------ | -------- | ------ | --- | --- | --- | --- | --- |
M-01 Incorrect use of "memory-safe" annotation potentially causing
| executable | code    | corruption |                  |     |     |             |        |
| ---------- | ------- | ---------- | ---------------- | --- | --- | ----------- | ------ |
| Severity:  | Medium  |            | Impact: Medium   |     |     | Likelihood: | Medium |
| Files:     | Several |            | Status: Reported |     |     | Violated    | Rule:  |
Description: In order for the optimizer to be able to perform some optimizations on bare
assembly code, it needs certain properties of the code to be guaranteed. Authors can use the
"memory-safe" dialect in order to guarantee that the assembly code fulfills certain
assumptions around respecting the memory safety model. In the codebase, these annotations
are used extensively. Unfortunately, some of them are used while the required assumptions are
not fulfilled, and given that these assumptions need to be strictly adhered to because of the
nature of optimizer's reasoning, it is likely to lead to incorrect and undefined behavior that
| cannot | be easily discovered |     | via testing. |     |     |     |     |
| ------ | -------------------- | --- | ------------ | --- | --- | --- | --- |
Moreover, even if bytecode is verified, any small change in the code, a minor Solidity version
update, or even a compiler configuration change can cause a new unexpected code corruption
issue.
Recommendations: Make sure that any memory layout range, or allocated memory is not being
corrupted in any assembly blocks. In particular, make sure to write any temporary data that
| may be              | longer than | 64 bytes     | at the | free memory | pointer. |     |     |
| ------------------- | ----------- | ------------ | ------ | ----------- | -------- | --- | --- |
| Customer’sresponse: |             | Acknowledged |        | and fixed.  |          |     |     |
FixReview: Fixed in commit https://github.com/Uniswap/v4-core/pull/759/files.
6

| M-02      | Tick may | not correspond | to the sqrtPrice |             |        |
| --------- | -------- | -------------- | ---------------- | ----------- | ------ |
| Severity: | Medium   | Impact:        | Medium           | Likelihood: | Medium |
| Files:    | Pool.sol | Status:        | Reported         | Violated    | Rule:  |
TickSqrtPriceStrongCorrelation
Description: At the end of the loop in the swap() function in Pool.sol, the tick information is
being updated – if the next price was reached and if the tick is initialized, it is crossed. Aside
from that, the new current tick is set to the value corresponding to the next price. Also, if
zeroForOne, the tick is decreased by one to account for next swaps – they will be happening
| in the tick | below. |     |     |     |     |
| ----------- | ------ | --- | --- | --- | --- |
But, an incorrect assumption is made that whenever the next price is achieved, the swap will
continue. Such a loop iteration may happen to be the last (significant) one (because the price
limit has been set to the next price, the amount specified has run out, or the remaining amount
specified is insufficient to move the price any further in the next iteration of the loop). In these
cases, the tick is decreased, despite the price exactly at the initializable tick at the next price
| corresponding | to  | the tick larger | by one. |     |     |
| ------------- | --- | --------------- | ------- | --- | --- |
Impact: Despite a crucial invariant being broken, ticks are crossed properly, so the only direct
impact is that the donate() function in PoolManager may donate to the wrong tick (and
hence a wrong set of positions) whenever the price is exactly at a price corresponding to an
initializable tick. Hooks or other actors could be using the donate() function as a core part of
their strategy to compensate LPs, therefore this error could heavily impact certain integrators.
Recommendations: Consider decrementing the tick only after the price has gone below the
| price at | a given tick | in zeroForOne | swaps. |     |     |
| -------- | ------------ | ------------- | ------ | --- | --- |
Customer’sresponse: Acknowledged. Won’t be fixed. Clarifying comments have been added to
| the code | in PR #851. |     |     |     |     |
| -------- | ----------- | --- | --- | --- | --- |
7

| Low Severity | Issues    |       |              |          |     |          |        |             |       |
| ------------ | --------- | ----- | ------------ | -------- | --- | -------- | ------ | ----------- | ----- |
| L-01         | Reachable | state | degeneration |          | due | to price | change |             |       |
| Severity:    | Low       |       | Impact:      | Low      |     |          |        | Likelihood: | Low   |
| Files:       | Pool.sol  |       | Status:      | Reported |     |          |        | Violated    | Rule: |
Description: The initialization can set the price to any value in the range [MIN_PRICE,
MAX_PRICE - 1]. MAX_PRICE is not achievable by design, since it belongs to a tick with price
range above the maximum considered price. But the pool can have the price at MIN_PRICE.
Despite that, due to a swap (which is the only way to change the price), the price may not go
back to MIN_PRICE. Hence, after the pool is initialized with any price other than MIN_PRICE,
| the price | will never | be able | to go | back. |     |     |     |     |     |
| --------- | ---------- | ------- | ----- | ----- | --- | --- | --- | --- | --- |
Impact: The liquidity in range [MIN_PRICE, MIN_PRICE + 1] can be utilized only once, at the
very first swap (that changes the price) in the pool, if the price was initialized at MIN_PRICE.
| Afterward, | this range | will | "contain" | only | currency1. |     |     |     |     |
| ---------- | ---------- | ---- | --------- | ---- | ---------- | --- | --- | --- | --- |
Recommendations: Change the boolean at line 325 to `<` instead of `<=` in order to allow the
| price limit         | to be | exactly       | at the minimum |     | price. |           |     |     |     |
| ------------------- | ----- | ------------- | -------------- | --- | ------ | --------- | --- | --- | --- |
| Customer’sresponse: |       | Acknowledged. |                |     | Won’t  | be fixed. |     |     |     |
8

L-02 Liquidity addition DoS by filling gross liquidity in initializable ticks
Severity: Low Impact: Low Likelihood: Low
Files: Pool.sol Status: Reported Violated Rule {Optional}:
Description: In order to make sure that the liquidity between any initializable ticks doesn't
overflow without evaluating it in every interval possible, bounds on liquidityGross are
introduced. This means that there is a constraint of about 2107 in liquidity starting and ending at
any tick (for tick spacing of 1, the limit grows approximately linearly with the tick spacing).
A very narrow position around price 1 (which could be the current price) that utilizes this
liquidity limit costs about 293 token wei. So, it may be affordable for an attacker to deposit a
position of this size to DoS a single liquidity addition operation of any other user.
The capital requirement of this attack shrinks as the position gets further from the current
price. A single tick wide position at an extreme price costs only about 5.20⋅108 (≈229) token
weis. So, an attacker can quite cheaply add positions that will DoS any full-range liquidity
additions in the future. This griefing can be easily bypassed by LPs choosing the ends of their
positions a number of ticks before the min or max tick ranges.
However, the attacker can add single-tick(-spacing) wide positions every second available tick
(spacing), from most extreme prices towards the current price. For a full pool DoS, and
assuming the price is close to 1, this will cost about 2106 of both tokens. But, if an attacker
decides to DoS only ticks 1000x above and below the current price, the capital requirement
also decreases about 1000x.
Attack capital requirements (except from the last one, which rises linearly) rise quadratically as
the tick spacing increases. This is because increasing it increases both the maximum gross
liquidity at any tick and the width of a minimal position.
9

Recommendations: Make sure that these properties (e.g. possible inability to add full-range
positions) is well-documented.
| Customer’sresponse: | Acknowledged | and fixed. |
| ------------------- | ------------ | ---------- |
FixReview: Fixed
10

L-03 Incorrect assumptions about most significant bits of narrow types
Severity: Low Impact: High Likelihood: VeryLow
Files: Several Status: Reported Violated Rule:
Description:
The Solidity language explicitly doesn't give any guarantees about bits that do not take part in a
Type's encoding. This means, for example, the 232 most significant bits of an int24 are neither
guaranteed to be zero nor consistent with the sign (for the number to be treated as a valid
int256). The potential impact could be very severe and lead to drainage of the protocol in
case an attacker managed to leverage the higher (dirty) bits as exemplified in finding I-02.
Despite not being able to identify an exploitable vector for this attack, we strongly recommend
preventative measures to be taken in order to make this attack vector unexploitable.
Recommendations: Clear most significant bits whenever necessary, or use signextend to
make sure a number can be interpreted as a higher-sized signed integer.
Customer’sresponse: Acknowledged and fixed.
FixReview: Fixed in commit https://github.com/Uniswap/v4-core/pull/780.
11

| Informational |     | Severity |     | Issues |     |     |
| ------------- | --- | -------- | --- | ------ | --- | --- |
I-01. Flash accounting cannot be used for actions that require untrusted calls
Description: While it is usually possible to swap without making untrusted calls when the
PoolManager is unlocked, this cannot be said for actions that, aside from swaps, require a flash
| loan to be | executed. |     |     |     |     |     |
| ---------- | --------- | --- | --- | --- | --- | --- |
The core reason is that anyone can accrue a nonzero currencyDelta that will cause the whole
| call to revert | on  | the unlock() |     | level. |     |     |
| -------------- | --- | ------------ | --- | ------ | --- | --- |
An example could be a liquidation scenario, where the lending protocol makes an untrusted call
to position's owner (and properly limits the gas consumed and doesn't revert on call failure).
Normally, such an action cannot affect the EVM contexts executing above (unless through
some reentrancy issues), but with the current design of flash accounting, the untrusted
contract can create a nonzero delta for itself and let it remain unsettled, until the whole
operation reverts on the unlock() level. In order to carry out a liquidation of such an account
correctly, one can't use Uniswap v4's flash logic as it currently is.
Recommendation: Consider introducing an option to block any contracts from modifying the
| currencyDeltas,     |     | until | the  | same actor | unblocks | this option.    |
| ------------------- | --- | ----- | ---- | ---------- | -------- | --------------- |
| Customer’sresponse: |     |       | "Not | a complete | fix, but | an improvement” |
FixReview: Partially fixed in commit https://github.com/Uniswap/v4-core/pull/786/files
| I-02. Same | currency |     | can | generate | multiple | token ids |
| ---------- | -------- | --- | --- | -------- | -------- | --------- |
Description: mint() and burn() functions accept an uint256 as a currency identifier, and
this value can have 96 most significant bits dirty. They are discarded when converting the value
to an address. It means that the same currency can have 296 native variants of itself.
This works similarly to subaccounts when considering only a single actor using them.
FixReview: Fixed in commit https://github.com/Uniswap/v4-core/pull/776/files
12

I-03. Array exttload() and extsload() functions may corrupt results due to
improper ABI decoding
Description: The ABI encoding of a single array encodes the pointer in calldata to the array, and
at that pointer, the length is stored. Right after the length, all array elements are encoded, one
by one.
The pointer doesn't have to point to the nearest available place in the calldata. It may point to
any place in the calldata, even if it's a part of the pointer itself, other data, or can be beyond the
next free place. But, the ABI decoding of an array written in assembly in exttload()
Exttload.sol and extsload()Extsload.sol assumes that the ABI encoding always puts the array
right after the pointer to it. If that's not the case, the code misunderstands the length and/or
the contents of the calldata array, and can return wrongly-sized output and/or corrupt its
contents. Although, Solidity's default ABI encoding will never produce calldata that can be
misinterpreted that way.
Impact: Integrators optimizing for gas, or using other languages that also produce valid
ABI-encoded data could end up producing this non-default calldata, leading to exttload()
and extsload() reading the wrong values.
Recommendations: Read the value of the array pointer in calldata and read values starting
from there. Alternatively, we recommend this behavior to be clearly outlined in the docs for
potential integrators.
Customer’sresponse: Acknowledged and fixed.
FixReview: Fixed in commit https://github.com/Uniswap/v4-core/pull/781
13

| Formal       |          |                   | Verification       |              |               |             |              |
| ------------ | -------- | ----------------- | ------------------ | ------------ | ------------- | ----------- | ------------ |
| Assumptions  |          | and               | Simplifications    |              |               |             |              |
| Project      | General  | Assumptions       |                    |              |               |             |              |
| A. We        | used     | Solidity Compiler | version 8.26       | to verify    | the protocol. |             |              |
| B. All       | assembly | blocks            | are memory-safe.   |              |               |             |              |
| C. We        | assume   | mulDiv behaves    | correctly          |              |               |             |              |
| Verification |          | Notations         |                    |              |               |             |              |
|              |          |                   | The rule           | is verified  | for every     | state       | of the       |
| Formally     | Verified |                   | contract(s),       | under        | the           | assumptions | of the       |
|              |          |                   | scope/requirements |              | in            | the rule.   |              |
|              |          |                   | The rule           | was violated | due           | to an       | issue in the |
Formally Verified After Fix code and was successfully verified after
|     |     |     | fixing the        | issue |        |      |              |
| --- | --- | --- | ----------------- | ----- | ------ | ---- | ------------ |
|     |     |     | A counter-example |       | exists | that | violates one |
Violated
|     |     |     | of the assertions |     | of the | rule. |     |
| --- | --- | --- | ----------------- | --- | ------ | ----- | --- |
14

| Formal | Verification | Properties |     |     |     |     |
| ------ | ------------ | ---------- | --- | --- | --- | --- |
Pool Manager
ModuleGeneralAssumptions
| -   | Thefollowingpropertiesareprovedforsrc/PoolManager.solcontract. |     |     |     |     |     |
| --- | -------------------------------------------------------------- | --- | --- | --- | --- | --- |
| -   | Weassumethatallloops(especiallyswaploop)iterateatmostonce.     |     |     |     |     |     |
| -   | Allextsloadaccessesaresafeandcorrect.                          |     |     |     |     |     |
| -   | CalculationsofstorageslotsthroughStateLibraryarecorrect.       |     |     |     |     |     |
ContractProperties
| P-01.           | Balancedeltasarezerowheneverthecontractislocked |          |                       |                 |            |                  |
| --------------- | ----------------------------------------------- | -------- | --------------------- | --------------- | ---------- | ---------------- |
| Status:Verified |                                                 |          | PropertyAssumptions:  |                 |            |                  |
| RuleName        |                                                 | Status   | Description           | RuleAssumptions |            | Linktorulereport |
|                 |                                                 |          | Afterasuccessfulcall  | Caller          | is not the |                  |
| must_terminate_ |                                                 | Verified |                       |                 |            |                  |
| with_zero_delta |                                                 |          | fortheunlockfunction, | contractitself  |            |                  |
alldeltasshouldbezero.
| nonZeroCorrect |     | Verified | Theamountofall        | The amount            | of all       |     |
| -------------- | --- | -------- | --------------------- | --------------------- | ------------ | --- |
|                |     |          | non-zerodeltasofall   | non-zero              | deltas ofall |     |
|                |     |          | usersandallcurrencies | usersandallcurrencies |              |     |
|                |     |          | equalsthevaluestored  | is less               | than max     |     |
|                |     |          | at                    | uint256.              |              |     |
NONZERO_DELTA_COU
NT_SLOT.
isLockedAndDelta Verified Whenthecontractis hold before andafter
Zero
|     |     |     | locked,alldeltasare | the outermost | call to |     |
| --- | --- | --- | ------------------- | ------------- | ------- | --- |
|     |     |     | zero.               | thecontract.  |         |     |
15

P-02. PoolInitializationisDoneCorrectly
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
Tickspacingisgreater
| InitializedPoolHasV | Verified |              |     |     |
| ------------------- | -------- | ------------ | --- | --- |
| alidTickSpacing     |          | than0always. |     |     |
Poolnotinitialized
| initializationSetsPri | Verified |                    |     |     |
| --------------------- | -------- | ------------------ | --- | --- |
| ceCorrectly           |          | beforethecallandis |     |     |
initializedafter.
Priceissetasexpected
andisvalid.
| initializeIsSafe | Verified | Initializinganewpool |     |     |
| ---------------- | -------- | -------------------- | --- | --- |
doesn'ta ectany
currencydeltas.
| pool_sqrt_price_ | Verified | ThesqrtPriceatany |     |     |
| ---------------- | -------- | ----------------- | --- | --- |
never_turns_zero
initializedpoolcan
neverturnzero.
16

P-03. Integrityofswap()
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
Netliquiditydoesn’t
| net_liquidity_imm | Verified |                     |     |     |
| ----------------- | -------- | ------------------- | --- | --- |
| utable_in_swap    |          | changeafteracallfor |     |     |
swap.
swapCantIncrease Verified swapcan’tincrease Caller is not the
| BothCurrencies |     | currencydeltasforthe | contractitself |     |
| -------------- | --- | -------------------- | -------------- | --- |
userinbothtokens
| ValidSwapFee | Verified | Theliquidityprovider |     |     |
| ------------ | -------- | -------------------- | --- | --- |
feeislessthanthe
MAX_LP_FEE.
Bothprotocolfeesare
lessthan
MAX_PROTOCOL_FEE.
| swap_integrity | Verified | swapsuntilspecified |     |     |
| -------------- | -------- | ------------------- | --- | --- |
amountisswappedor
limitpriceisreached.
UpdatePriceandTick
Dataintheright
direction.
17

P-04. ModifyLiquidityAccounting
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
Theonlyfunctionwhich
| only_modify_liqui | Verified |                      |     |     |
| ----------------- | -------- | -------------------- | --- | --- |
| dity_changes_pos  |          | canchangeaposition's |     |     |
ition_liquidity
liquidityis
modifyLiquidity.
| modify_liquidity_ | Verified | modifyLiquidity    |     |     |
| ----------------- | -------- | ------------------ | --- | --- |
| position_changes  |          | properlychangesthe |     |     |
_correctly
correctpositiononly,
basedonfunctioninput
andthemsg.sender.
| liquidity_changed | Verified | Onlythemsg.sender |     |     |
| ----------------- | -------- | ----------------- | --- | --- |
_by_owner_only
canchangetheirown
positionliquidity.
change_of_liquidit Verified Thecurrencydeltas The relevant pool is
y_preserves_fund
|     |     | resultingfromachange | initialized with | valid |
| --- | --- | -------------------- | ---------------- | ----- |
s
|     |     | ofposition'sliquidity | ticksandprice. |     |
| --- | --- | --------------------- | -------------- | --- |
matchthechangeof
position'svalue.
modify_liquidity_r Verified ThemodifyLiquidity The relevant pool is
eturns_position_f functionreturnsdeltas initialized with valid
unds
|     |     | thatmatchtheposition | ticks,tickspacingand |     |
| --- | --- | -------------------- | -------------------- | --- |
|     |     | fundsfunction.       | price.               |     |
Assumenohooksdelta
(AFTER_REMOVE_LIQUI
DITY_FLAGiso )
18

| active_liquidity_is | Verified | modifyLiquidity     |     |     |
| ------------------- | -------- | ------------------- | --- | --- |
| _updated_correct    |          | correctlyupdatesthe |     |     |
ly_modifyLiquidity
totalactiveliquidityif
thepositionisactiveor
not.
| funds_of_total_liq | Verified | Theunderlyingfundsof  |     |     |
| ------------------ | -------- | --------------------- | --- | --- |
| uidity_exceeds_s   |          | theentireliquidityina |     |     |
um_of_position_f
tickrangeexceedsthe
unds
sumoffundsforall
positionsinatick.
Byinduction,thisis
true,forasumofany
numberofarbitrary
positions.
modifyLiquidity_d Verified Modifyingliquidityfor linktorulereport
| oesnt_affect_othe |     | onepositiondoesn’t |     |     |
| ----------------- | --- | ------------------ | --- | --- |
rs
a ecttheliquidityfor
otherpositions.
P-05. SwapAccounting
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
positions_to_the_ Verified Whenswappingtothe The relevant pool is
left_dont_change
|     |     | right,inactivepositions | initialized with | valid |
| --- | --- | ----------------------- | ---------------- | ----- |
_value
|     |     | totheleftdon'tchange | ticksandprice.    |     |
| --- | --- | -------------------- | ----------------- | --- |
|     |     | theirvalue.          | params.zeroForOne | is  |
settofalse.
19

positions_to_the_ Verified Whenswappingtothe The relevant pool is
right_dont_chang left,inactivepositions initialized with valid
e_value
|     | totherightdon't   | ticksandprice.    |     |
| --- | ----------------- | ----------------- | --- |
|     | changetheirvalue. | params.zeroForOne | is  |
settotrue.
|     | Whenatickshiftstothe | The relevant | pool is |
| --- | -------------------- | ------------ | ------- |
position_funds_c Verified
| hange_upon_tick | left(zeroForOne= | initialized | with valid |
| --------------- | ---------------- | ----------- | ---------- |
_slip_max_upper
|     | true),positionsfunds | ticksandprice.        |     |
| --- | -------------------- | --------------------- | --- |
|     | withtickUpper=       | Therelevantpositionis |     |
|     | MAX_TICK()should     | active.               |     |
changebytheamount
deltasoftheprices
beforeandafterthe
shift.
position_funds_c Verified Whenatickshiftstothe The relevant pool is
| hange_upon_tick | right(zeroForOne= | initialized | with valid |
| --------------- | ----------------- | ----------- | ---------- |
_slip_min_lower
|     | false),positionsfunds | ticksandprice.        |     |
| --- | --------------------- | --------------------- | --- |
|     | withtickLower=        | Therelevantpositionis |     |
|     | MIN_TICK()should      | active.               |     |
changebytheamount
deltasoftheprices
beforeandafterthe
shift.
20

P-06. ValidLiquidityState
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
TheliquidityGrossof
| liquidityGrossCorrect | Verified |     |     |     |
| --------------------- | -------- | --- | --- | --- |
atickisthesumofall
liquiditesfrom
positionswhoselower
oruppertickisthattick.
| liquidityNetCorrect | Verified | TheliquidityNetofa |     |     |
| ------------------- | -------- | ------------------ | --- | --- |
tickisthedi erence
betweenthetotal
liquidityfromall
positionswhoselower
tickisthattickandthe
totalliquiditesfromall
positionswhoseupper
tickisthattick.
Atickhasgrossliquidity
| NoGrossLiquidityForUn | Verified |                 |     |     |
| --------------------- | -------- | --------------- | --- | --- |
| initializedTick       |          | ifandonlyifit’s |     |     |
initialized.
| OnlyAlignedTicksPositi | Verified | Onlypositionswithtick |     |     |
| ---------------------- | -------- | --------------------- | --- | --- |
| ons                    |          | boundariesthatare     |     |     |
alignedwiththetick
spacinghaveliquidity.
21

P-07. ValidPoolState
| Status:Violated   |          | PropertyAssumptions:    |                 |         |                  |
| ----------------- | -------- | ----------------------- | --------------- | ------- | ---------------- |
| RuleName          | Status   | Description             | RuleAssumptions |         | Linktorulereport |
|                   |          | Foreveryinitializedpool | The relevant    | pool is |                  |
| ValidTickAndPrice | Verified |                         |                 |         |                  |
|                   |          | thetickisvalid          | initialized.    |         |                  |
(MIN_TICK<=tick<=
MAX_TICK)andtheprice
isvalidaswell
(MIN_SQRT_PRICE<=
sqrtprice<=
MAX_SQRT_PRICE).
TickSqrtPriceStrongC tick(poolSqrtPrice)= The relevant pool is
Violated
| orrelation |     | pooltick | initialized. |     |     |
| ---------- | --- | -------- | ------------ | --- | --- |
TickSqrtPriceCorrelati Verified Thecurrentpooltick The relevant pool is
| on  |     | correspondstothe | initialized. |     |     |
| --- | --- | ---------------- | ------------ | --- | --- |
currentpriceofthepool
andviceversa,orthe
priceisexactlyatatick
andthetickisonetoo
low.
Weakversionof
TickSqrtPriceStrongC
orrelation
| ValidSwapFee | Verified | Theliquidityprovider |     |     |     |
| ------------ | -------- | -------------------- | --- | --- | --- |
feeislessthanthe
MAX_LP_FEE.
Bothprotocolfeesare
lessthan
MAX_PROTOCOL_FEE.
22

| Protocol Fee Library |     |     |     |     |
| -------------------- | --- | --- | --- | --- |
ModuleGeneralAssumptions
- Thefollowingpropertiesareprovedforsrc/libraries/LPFeeLibrary.solandsrc/libraries/ProtocolFeeLibrary.sol
contracts.
- Allextsloadaccessesaresafeandcorrect.
ContractProperties
P-01. CorrectFeeCalculations
| Status:Verified  |          | PropertyAssumptions: |                 |                  |
| ---------------- | -------- | -------------------- | --------------- | ---------------- |
| RuleName         | Status   | Description          | RuleAssumptions | Linktorulereport |
|                  |          | VerifyZeroForOnefee  |                 | linktorulereport |
| test_getZeroForO | Verified |                      |                 |                  |
| neFee            |          | calculationwith      |                 |                  |
Maximumprotocolfee.
| test_FV_getZeroF | Verified | Verifycorrect |     | linktorulereport |
| ---------------- | -------- | ------------- | --- | ---------------- |
| orOneFee         |          | Calculationof |     |                  |
ZeroForOneFeebased
oninputfee.
test_getOneForZer Verified VerifyOneForZeroFee linktorulereport
oFee
Calculationwith
MaximumProtocolFee.
| test_FV_getOneFo | Verified | VerifyCorrect |     | linktorulereport |
| ---------------- | -------- | ------------- | --- | ---------------- |
rZeroFee
Calculationof
OneForZeroFeeBased
onInputFee.
23

| test_FV_isValidPro | Verified | VerifyCorrect |     | linktorulereport |
| ------------------ | -------- | ------------- | --- | ---------------- |
| tocolFee_fee       |          | Calculationof |     |                  |
isValidProtocolFeeFee
BasedonInputFee.
| test_FV_calculate | Verified | VerifySwapFee   |     | linktorulereport |
| ----------------- | -------- | --------------- | --- | ---------------- |
| SwapFee           |          | Calculationwith |     |                  |
ProtocolandLPFees
SqrtPrice Math
ModuleGeneralAssumptions
- Thefollowingpropertiesareprovedforsrc/libraries/SqrtPriceMath.sol contract.
P-01. Librarymathematicalproperties
| Status:Verified |          | PropertyAssumptions: |                 |                  |
| --------------- | -------- | -------------------- | --------------- | ---------------- |
| RuleName        | Status   | Description          | RuleAssumptions | Linktorulereport |
| getAmount0Delta | Verified | Verifythatthe        |                 | linktorulereport |
_zero_diff
getAmount0Delta
functioncorrectly
returnszerowhenthe
squarerootsofthe
lowerandupperprice
boundsareequalor
whentheliquidityis
zero.
| getAmount0Delta | Verified | VerifySymmetryin |     | linktorulereport |
| --------------- | -------- | ---------------- | --- | ---------------- |
| _symmetric      |          | Amount0Delta     |     |                  |
Calculation.
24

| getAmount0Delta | Verified | Verifythatthe  |     | linktorulereport |
| --------------- | -------- | -------------- | --- | ---------------- |
| _rounding_diff  |          | di erenceinthe |     |                  |
getAmount0Delta
function'soutput,when
roundingupversus
roundingdown,iseither
zeroorone,ensuring
minimaldiscrepancy
duetorounding.
getAmount0Delta Verified VerifyMonotonicityof Pricesarevalid. linktorulereport
_liquidity_monoto
Amount0Deltawith
| nic |     | RespecttoLiquidity. |     |     |
| --- | --- | ------------------- | --- | --- |
getAmount0Delta Verified VerifyMonotonicityof At least one of the linktorulereport
| _sqrtPrice_monot |     | Amount0Deltawith | prices is | either |
| ---------------- | --- | ---------------- | --------- | ------ |
onic
|     |     | RespecttoSquareRoot | MIN_SQRT_RATIO  | or  |
| --- | --- | ------------------- | --------------- | --- |
|     |     | Prices.             | MAX_SQRT_RATIO. |     |
Pricesarevalid.
|                    |          | VerifyAdditivityof | At Least one | of the linktorulereport |
| ------------------ | -------- | ------------------ | ------------ | ----------------------- |
| getAmount0Delta    | Verified |                    |              |                         |
| _sqrtPrice_additiv |          | Amount0DeltaAcross | prices is    | either                  |
ity
|     |     | PriceIntervals(upto | MIN_SQRT_RATIO  | or  |
| --- | --- | ------------------- | --------------- | --- |
|     |     | roundingerrorof1).  | MAX_SQRT_RATIO. |     |
Pricesarevalid.
getAmount0Delta Verified VerifyAdditivityof At Least one of the linktorulereport
| _liquidity_additivi |     | Amount0Deltawith | prices is | either |
| ------------------- | --- | ---------------- | --------- | ------ |
ty
|                  |          | RespecttoCombined  | MIN_SQRT_RATIO  | or               |
| ---------------- | -------- | ------------------ | --------------- | ---------------- |
|                  |          | Liquidity(upto     | MAX_SQRT_RATIO. |                  |
|                  |          | roundingerrorof1). | Pricesarevalid. |                  |
| getAmount1Delta_ | Verified | Verifythatthe      |                 | linktorulereport |
| zero_diff        |          | getAmount1Delta    |                 |                  |
functioncorrectly
returnszerowhenthe
squarerootsofthe
lowerandupperprice
boundsareequalor
25

whentheliquidityis
zero.
| getAmount1Delta_ | Verified | VerifySymmetryin |     | linktorulereport |
| ---------------- | -------- | ---------------- | --- | ---------------- |
| symmetric        |          | Amount1Delta     |     |                  |
Calculation.
|                  |          | Verifythatthe  |     | linktorulereport |
| ---------------- | -------- | -------------- | --- | ---------------- |
| getAmount1Delta_ | Verified |                |     |                  |
| rounding_diff    |          | di erenceinthe |     |                  |
getAmount1Delta
function'soutput,when
roundingupversus
roundingdown,iseither
zeroorone,ensuring
minimaldiscrepancy
duetorounding.
getAmount1Delta_ Verified VerifyMonotonicityof Pricesarevalid. linktorulereport
| sqrtPrice_monoto |     | Amount1Deltawith |     |     |
| ---------------- | --- | ---------------- | --- | --- |
nic
RespecttoSquareRoot
Prices.
getAmount1Delta_l Verified VerifyMonotonicityof Pricesarevalid. linktorulereport
| iquidity_monotoni |     | Amount1Deltawith |     |     |
| ----------------- | --- | ---------------- | --- | --- |
c
RespecttoLiquidity.
getAmount1Delta_ Verified VerifyAdditivityof Pricesarevalid. linktorulereport
| sqrtPrice_additivit |     | Amount1DeltaAcross |     |     |
| ------------------- | --- | ------------------ | --- | --- |
y
PriceIntervals(upto
roundingerrorof1).
getAmount1Delta_l Verified VerifyAdditivityof Pricesarevalid. linktorulereport
iquidity_additivity
Amount1Deltawith
RespecttoCombined
Liquidity(upto
roundingerrorof1).
|                   |          | Verifythatthe         | Pricesarevalid. | linktorulereport |
| ----------------- | -------- | --------------------- | --------------- | ---------------- |
| amountDelta_getN  | Verified |                       |                 |                  |
| extSqrtPriceFromI |          | getNextSqrtPriceFromI |                 |                  |
26

nput_bound nputfunctionreturnsa
newsquarerootprice
withinthecorrect
boundsbasedonthe
inputamount,validating
thefunction'saccuracy
forbothzero-for-one
andone-for-zero
scenarios.
amountDelta_getN Verified Verifythatthe Pricesarevalid.
extSqrtPriceFrom getNextSqrtPriceFromO
Output_bound
utputfunctionreturnsa
newsquarerootprice
withinthecorrect
boundsbasedonthe
inputamount,validating
thefunction'saccuracy
forbothzero-for-one
andone-for-zero
scenarios.
getNextSqrtPriceFr Verified VerifyBoundofNext Pricesarevalid. linktorulereport
omInput_amountD SqrtPricefromInput
elta_bound
Amount,ensuringthe
functioncorrectly
handlesboth
zero-for-oneand
one-for-zeroscenarios.
getNextSqrtPriceFr Verified VerifyBoundofNext Pricesarevalid. linktorulereport
omOutput_amoun SqrtPricefromOutput
tDelta_bound
AmountandDelta,
ensuringthefunction
correctlyhandlesboth
zero-for-oneand
one-for-zeroscenarios.
checkAxiomC Verified Thistestensuresthat Pricesarevalid. linktorulereport
the
27

getNextSqrtPriceFromI
nputand
getNextSqrtPriceFromO
utputfunctions
correctlytransitionthe
squarerootprice
accordingtothe
expecteddirectionality
whengiveninputand
outputamountsfor
bothzero-for-oneand
one-for-zeroswaps.
getNextSqrtPriceFr Verified EnsureNon-Reversion linktorulereport
omInput_amountD ofAmountDeltafrom
elta_cannot_rever
InputPriceTransition
t
getNextSqrtPriceFr Verified EnsureNon-Reversion linktorulereport
omOutput_amoun ofAmountDeltafrom
tDelta_cannot_rev
OutputPriceTransition
ert
28

TickBitMap Library
ModuleGeneralAssumptions
- Thefollowingpropertiesareprovenforsrc/libraries/TickBitmap.solcontract.
ContractProperties
P-01. CorrectnessofflipTick()
| Status:Verified |        | PropertyAssumptions: |                 |                  |
| --------------- | ------ | -------------------- | --------------- | ---------------- |
| RuleName        | Status | Description          | RuleAssumptions | Linktorulereport |
flipTickEquivalence Verified EquivalenceofSolidity Ticksandtickspacing
|                       |          | andassemblyflipTick   | arevalid. |     |
| --------------------- | -------- | --------------------- | --------- | --- |
| flipTickIntegrityTest | Verified | Tickflippedafteracall |           |     |
forflipTick.
| flipTickAffectsOnlyTic | Verified | Flippingatickdoesn’t |     |     |
| ---------------------- | -------- | -------------------- | --- | --- |
| kTest                  |          | a ectotherticks.     |     |     |
29

Disclaimer
The Certora Prover takes a contract and a specification as input and formally proves that the
contract satisfies the specification in all scenarios. Notably, the guarantees of the Certora Prover
are scoped to the provided specification and the Certora Prover does not check any cases not
| covered | by the specification. |     |     |     |
| ------- | --------------------- | --- | --- | --- |
Even though we hope this information is helpful, we provide no warranty of any kind, explicit or
implied. The contents of this report should not be construed as a complete guarantee that the
contract is secure in all dimensions. In no event shall Certora or any of its employees be liable for
any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising
| from, out | of, or in connection | with the results | reported | here. |
| --------- | -------------------- | ---------------- | -------- | ----- |
| About     | Certora              |                  |          |       |
Certora is a Web3 security company that provides industry-leading formal verification tools and
smart contract audits. Certora’s flagship security product, Certora Prover, is a unique SaaS
product that automatically locates even the most rare & hard-to-find bugs on your smart
contracts or mathematically proves their absence. The Certora Prover plugs into your standard
deployment pipeline. It is helpful for smart contract developers and security researchers during
| auditing | and bug bounties. |     |     |     |
| -------- | ----------------- | --- | --- | --- |
Certora also provides services such as auditing, formal verification projects, and incident
response.
30