T
F
A
Uniswap v4-core Security Review
R
D
Auditors
Desmond Ho, Lead Security Researcher
Kurt Barry, Lead Security Researcher
Saw-Mon and Natalie, Lead Security Researcher
Jeiwan, Security Researcher
David Chaparro, Junior Security Researcher
Reportpreparedby: LucasGoiriz
September5,2024

Contents
1 AboutSpearbit 2
2 Introduction 2
3 Riskclassification 2
3.1 Impact . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
3.2 Likelihood . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
3.3 Actionrequiredforseveritylevels . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
T
4 ExecutiveSummary 3
5 Findings 4
5.1 MediumRisk . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4
5.1.1 Donationscanbestolenbyprovidingjust-in-timeliquidity . . . . . . . . . . . . . . . . . . . . 4
F
5.2 LowRisk . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5
5.2.1 tickSpacingToMaxLiquidityPerTick'scalculationisnotcompletelyaccurate . . . . . . . . 5
5.2.2 MixeduseofroundingdirectionandinaccurateconstantsingetSqrtPriceAtTick . . . . . . 5
5.2.3 TheusedconstantsrepresentingtheminandmaxoftheerrorsingetTickAtSqrtPriceare
notaccurate . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 9
5.2.4 PoolManager.updateDynAamicLPFee()doesn'temitanevent . . . . . . . . . . . . . . . . . . 14
5.2.5 bubbleUpAndRevertWithispronetoreturndatabombingandsomeotherminorissues . . . . 14
5.3 GasOptimization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
5.3.1 Asimpleupcastingoperationcanbeperformed . . . . . . . . . . . . . . . . . . . . . . . . . . 14
5.3.2 toIdperformsanunnecesarylengthcalculation . . . . . . . . . . . . . . . . . . . . . . . . . 15
5.3.3 state.sqrtPriceX96canbeusedinsteadofslot0Start.sqrtPriceX96()inPool.swap . . 15
5.3.4 UnneceRssaryoperationsintickSpacingToMaxLiquidityPerTickcanberemoved . . . . . . 17
5.3.5 DerivingliquidityGrossBeforecanbeoptimised . . . . . . . . . . . . . . . . . . . . . . . . 19
5.3.6 msg.sendercanbeinlinedin_burnFromtosavegas . . . . . . . . . . . . . . . . . . . . . . . 19
5.3.7 _fetchProtocolFeecanbeoptimisedbyusingthescratchspace . . . . . . . . . . . . . . . 20
5.3.8 Gasoptimizationinclear()function . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
5.3.9 Non-assemblyversionofstate.ticksetterpossiblymoregasefficient . . . . . . . . . . . . 22
5.3.10 mulDiv()isredundantforfeegrowthcalculation . . . . . . . . . . . . . . . . . . . . . . . . . 23
D
5.3.11 MoreefficientmaskderivationinTickBitmap . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
5.3.12 BitMath . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
5.4 Informational . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
5.4.1 Somecontractsdon'tfollowUniswap'sversionconvention . . . . . . . . . . . . . . . . . . . . 28
5.4.2 computeSwapStepcanbesimplifiedforexactInswapswhenamountInisgreaterthanamoun-
tRemainingLessFee . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
5.4.3 AddcommentsregardingthederivationofSQRT_PRICE_A_Bconstant . . . . . . . . . . . . . . 30
5.4.4 amountInisalways0inaninnerbranchofcomputeSwapStep . . . . . . . . . . . . . . . . . . 31
5.4.5 Unusedcodeshouldberemoved . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
5.4.6 Unnecessaryuncheckedblocks . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
5.4.7 ConfusingerrormessageinERC6909.transferFrom(). . . . . . . . . . . . . . . . . . . . . . 32
5.4.8 getSqrtPriceAtTickassumesthattheallowedtickrangeiscenteredat0. . . . . . . . . . . 33
5.4.9 Thecurrentornexttickisnotalwaysonthetickspacinggridorwithintheallowedrange . . . 33
5.4.10 uncheckedblocks . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
5.4.11 Dirtybitcleaning . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
5.4.12 Namedreturnareunusedinsettle()andsettleFor() . . . . . . . . . . . . . . . . . . . . 38
5.4.13 collectProtocolFeeslacksanowneventtotrackfeecollections. . . . . . . . . . . . . . . . 39
5.4.14 Bestpracticesforhandlingactionflows . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
5.4.15 PoolswithmaximumlpFeedonotsupportexactoutputswaps . . . . . . . . . . . . . . . . . 39
5.4.16 Currency.isZero()isequivalenttoCurrency.isNative() . . . . . . . . . . . . . . . . . . . 40
5.4.17 CommentImprovements . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
5.4.18 memory-safeannotation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
1

1 About Spearbit
Spearbitisadecentralizednetworkofexpertsecurityengineersofferingreviewsandothersecurityrelatedservices
toWeb3projectswiththegoalofcreatingastrongerecosystem. Ournetworkhasexperienceoneverypartofthe
blockchaintechnologystack,includingbutnotlimitedtoprotocoldesign,smartcontractsandtheSoliditycompiler.
Spearbit brings in untapped security talent by enabling expert freelance auditors seeking flexibility to work on
interestingprojectstogether.
Learnmoreaboutusatspearbit.com
T
2 Introduction
UniswapisanopensourcedecentralizedexchangethatfacilitatesautomatedtransactionsbetweenERC20token
tokensonvariousEVM-basedchainsthroughtheuseofliquiditypoolsandautomaticmarketmakers(AMM).
F
Disclaimer: Thissecurityreviewdoesnotguaranteeagainstahack. Itisasnapshotintimeofv4-coreaccording
tothespecificcommit. Anymodificationstothecodewillrequireanewsecurityreview.
3 Risk classification
A
Severitylevel Impact: High Impact: Medium Impact: Low
Likelihood: high Critical High Medium
Likelihood: medium High Medium Low
Likelihood: low Medium Low Low
R
3.1 Impact
• High-leadstoalossofasignificantportion(>10%)ofassetsintheprotocol,orsignificantharmtoamajority
ofusers.
• Medium-globallosses<10%orlossestoonlyasubsetofusers,butstillunacceptable.
D
• Low-losseswillbeannoyingbutbearable--appliestothingslikegriefingattacksthatcanbeeasilyrepaired
orevengasinefficiencies.
3.2 Likelihood
• High-almostcertaintohappen,easytoperform,ornoteasybuthighlyincentivized
• Medium-onlyconditionallypossibleorincentivized,butstillrelativelylikely
• Low-requiresstarstoalign,orlittle-to-noincentive
3.3 Action required for severity levels
• Critical-Mustfixassoonaspossible(ifalreadydeployed)
• High-Mustfix(beforedeploymentifnotalreadydeployed)
• Medium-Shouldfix
• Low-Couldfix
2

4 Executive Summary
Disclaimer: Thecurrentreportisadraft. Fixreviewisstillinprogressformanyissuesandnothinginthisreport
shouldbeconsideredfinalized.
Over the course of 10 days in total, Uniswap engaged with Spearbit to review the v4-core protocol. In this period
oftimeatotalof36issueswerefound.
T
Summary
| ProjectName | Uniswap |     |     |
| ----------- | ------- | --- | --- |
| Repository  | v4-core |     |     |
F
| Commit            | 7a7203...a2c037 |     |     |
| ----------------- | --------------- | --- | --- |
| TypeofProject     | DeFi,AMM        |     |     |
| AuditTimeline     | Jul15toAug26    |     |     |
| TwoweekfixperAiod | Aug26-Sep10     |     |     |
IssuesFound
| Severity | Count | Fixed | Acknowledged |
| -------- | ----- | ----- | ------------ |
R
| CriticalRisk | 0   | 0   | 0   |
| ------------ | --- | --- | --- |
| HighRisk     | 0   | 0   | 0   |
| MediumRisk   | 1   | 1   | 0   |
| LowRisk      | 5   | 2   | 1   |
D
| GasOptimizations | 12  | 9   | 2   |
| ---------------- | --- | --- | --- |
| Informational    | 18  | 12  | 1   |
| Total            | 36  | 24  | 4   |
3

5 Findings
5.1 Medium Risk
5.1.1 Donationscanbestolenbyprovidingjust-in-timeliquidity
Severity: MediumRisk
Context: PoolManager.sol#L252,Pool.sol#L463-L468
Description: The PoolManager.donate() function allows to donate tokens to liquidity providers. Donations are
T
countedasswapfeesandimmediatelyaddedtotheglobalswapfeestrackers(Pool.sol#L463-L468):
if (amount0 > 0) {
state.feeGrowthGlobal0X128 += FullMath.mulDiv(amount0, FixedPoint128.Q128, liquidity);
}
if (amount1 > 0) {
state.feeGrowthGlobal1X128 += FullMath.mulDiv(amoFunt1, FixedPoint128.Q128, liquidity);
}
Thisincreasestheearnedswapfeesofallliquiditypositionsthatincludethecurrentprice.
Sincedonationamountscanbearbitrary(specifically,theycanbesignificantlybiggerthanswapfees),thisopens
up an attack vector that allows anyone toAsteal a portion of donations by providing just-in-time liquidity. This can
beexploitedviaasandwichattackthatwrapsthedonatingtransactionintwotransactions:
1. Intheprecedingtransaction,someamountofliquidityisaddedaroundthecurrentprice.
2. ThedonatingtransactionrewardsLPs,includingthepositionaddedin1.
3. Inthefollowingtransaction,theliquidityaddedin1isremovedandaportionofthedonationiswithdrawn.
R
Inthisscenario,theattackerearnsaportionofthedonationwhilenotprovidingusefulliquiditytothepool.
Recommendation: Giventhatthecorecontractsstrivetoremainassimpleandbasicaspossible,werecommend
removing the PoolManager.donate() function and letting integrators implement their own donations solution via
thehooks. Alternatively,considerkeepingPoolManager.donate()andwarningusersthatitshouldonlybeusedfor
donatinginsignificantamounts(userswouldneedtodeterminetheirsizebythemselves,ensuringtheirdonations
are nDot profitable for MEV bots). For bigger amounts, however, integrators will still need to implement a more
robustsolutionusingthehooks. E.g. donationscanbevested(i.e. distributedovertime), orLPscanberequired
tokeeptheirliquidityforaminimumamountoftime.
Uniswap: CommentshavebeenaddedinPR851.
Spearbit: Verified.
4

5.2 Low Risk
5.2.1 tickSpacingToMaxLiquidityPerTick'scalculationisnotcompletelyaccurate
Severity: LowRisk
Context: Pool.sol#L574
Description: In the above context when minTick is calculated one compresses the MIN_TICK such that it would
roundtowards0andnotnegativeinfinity. Whereasoneneedstoapplythecompressiontowardsnegativeinfinity.
Andthustheresultcanbeoffby1inthedenominator.
T
Also see the related issue "Incorrect tick compression for negative ticks in countInitializedTicksLoaded" for
‘v4-periphery‘.
Recommendation: For better estimate make sure the tick compressions are preformed correctly so they would
roundtowardnegativeinfinity.
F
Uniswap: FixedinPR870.
Spearbit: Verified.
5.2.2 MixeduseofroundingdirectionandinaccurateconstantsingetSqrtPriceAtTick
A
Severity: LowRisk
Context: TickMath.sol#L54-L108
Description: Leti bethetickprovided,andbelowtobethebinaryrepresnetationof i :
j j
Ri =b b b b
19 2 1 0
j j (cid:1)(cid:1)(cid:1)
Notethat20binarydigitsisenoughsinceintheminandmaxrangeoftheticksweknowthat i <220 .
j j
Leth(b)be(whereb 0,1 ):
i
2f g
2128
Dh(b)=
i 2i b
&p1.0001 (cid:1) ’
2128
h (1)= =340265354078544963557816517032075149314=0xfffcb933bd6fad37aa2d162d1a594002
0
p1.0001
(cid:24) (cid:25)
Alsoweknowh(0)=2128 . Let'sdefinethe operatorasthemultiplicationinQ...x128type:
i
(cid:10)
a b
a b = (cid:1)
(cid:10) 2128
(cid:22) (cid:23)
Thenwehave:
h(0) a=a h(0)=a
i i
(cid:10) (cid:10)
anduptoTickMath.sol#L96thepricep calculatedbecomes(orderofapplyingthe operatormattersbelow):
(cid:10)
19
p =(h (b ) (h (b ) (h (b ) p )) )= h(b)
19 19 19 2 2 1 1 0 i i
(cid:10)(cid:1)(cid:1)(cid:1) (cid:10) (cid:10) (cid:1)(cid:1)(cid:1)
i=0
O
5

2256(cid:0)1
j p19 k , ifi >0
getSqrtPriceAtTick(i)= 232
8& ’
>< p19 , otherwise
232
1. Notethatwehave: >:(cid:6) (cid:7)
1 1 1 1
=
p1.0001j i j 1.0001219(cid:0)1 (cid:1) b19 (cid:2)(cid:1)(cid:1)(cid:1)(cid:2) 1.000121(cid:0)1 (cid:1) b1 (cid:2) 1.000120(cid:0)1 (cid:1) b0
T
and thus p should be the above multiplication in Q128x128 with 128 bits of precision and then at the end
19
loweredtoQ128x96.
2. Themultiplactions areroundeddownalthoughthe(most)oftheconstantsh(1)usedareroundedup.
i
(cid:10)
3. The inversion for the postive ticks i is rounded down although besides multiplications everything else is
F
(cid:10)
roundedup.
4. Theinversionforpositiveticksi >0isnotaccurateinQ128x128theinversionshouldhavebeen(alsorounded
upifpossible):
A2128 2256
2128 =
p (cid:1) p
19 19
Butsinceonecannotuse2256 thatisprobablywhytheconstantnot(0)2256 1isusedinstead.
(cid:0)
Let'sassesstheaccuraryoftheconstantsusedh(1):
i
R
formula wolframvalue valueusedinthecode used-actual
h (1) 0xfffcb933bd6fad37aa2d162d1a594002 0xfffcb933bd6fad37aa2d162d1a594001 1
0
(cid:0)
h (1) 0xfff97272373d413259a46990580e213a 0xfff97272373d413259a46990580e213a 0
1
h (1) 0xfff2e50f5f656932ef12357cf3c7fdcc 0xfff2e50f5f656932ef12357cf3c7fdcc 0
2
D
h (1) 0xffe5caca7e10e4e61c3624eaa0941cd0 0xffe5caca7e10e4e61c3624eaa0941cd0 0
3
h (1) 0xffcb9843d60f6159c9db58835c926644 0xffcb9843d60f6159c9db58835c926644 0
4
h (1) 0xff973b41fa98c081472e6896dfb254c0 0xff973b41fa98c081472e6896dfb254c0 0
5
h (1) 0xff2ea16466c96a3843ec78b326b52861 0xff2ea16466c96a3843ec78b326b52861 0
6
h (1) 0xfe5dee046a99a2a811c461f1969c3053 0xfe5dee046a99a2a811c461f1969c3053 0
7
h (1) 0xfcbe86c7900a88aedcffc83b479aa3a4 0xfcbe86c7900a88aedcffc83b479aa3a4 0
8
h (1) 0xf987a7253ac413176f2b074cf7815e54 0xf987a7253ac413176f2b074cf7815e54 0
9
h (1) 0xf3392b0822b70005940c7a398e4b70f3 0xf3392b0822b70005940c7a398e4b70f3 0
10
h (1) 0xe7159475a2c29b7443b29c7fa6e889d9 0xe7159475a2c29b7443b29c7fa6e889d9 0
11
h (1) 0xd097f3bdfd2022b8845ad8f792aa5826 0xd097f3bdfd2022b8845ad8f792aa5825 1
12
(cid:0)
h (1) 0xa9f746462d870fdf8a65dc1f90e061e5 0xa9f746462d870fdf8a65dc1f90e061e5 0
13
h (1) 0x70d869a156d2a1b890bb3df62baf32f7 0x70d869a156d2a1b890bb3df62baf32f7 0
14
h (1) 0x31be135f97d08fd981231505542fcfa6 0x31be135f97d08fd981231505542fcfa6 0
15
h (1) 0x9aa508b5b7a84e1c677de54f3e99bc9 0x9aa508b5b7a84e1c677de54f3e99bc9 0
16
h (1) 0x5d6af8dedb81196699c329225ee605 0x5d6af8dedb81196699c329225ee604 1
17
(cid:0)
6

formula wolframvalue valueusedinthecode used-actual
h (1) 0x2216e584f5fa1ea926041bedfe97(inaccurate) 0x2216e584f5fa1ea926041bedfe98 1
18
h (1) 0x48a170391f7dc42444e8fa2(inaccurate) 0x48a170391f7dc42444e8fa2 0
19
formula Sympyvalue valueusedinthecode used-actual
h (1) 0xfffcb933bd6fad37aa2d162d1a594002 0xfffcb933bd6fad37aa2d162d1a594001 1
0
(cid:0)
h (1) 0xfff97272373d413259a46990580e213a 0xfff97272373d413259a46990580e213a 0
1
h (1) 0xfff2e50f5f656932ef12357cf3c7fdcc 0xfff2e50f5f656932ef12357cf3c7fdcc 0
2
h (1) 0xffe5caca7e10e4e61c3624eaa0941cd0 0xffe5caca7e10e4e61c3624eaa0941cd0 0
3
h (1) 0xffcb9843d60f6159c9db58835c926644 0xffcb9843d60f6159c9db58835c926644 0
4
h (1) 0xff973b41fa98c081472e6896dfb254c0 0xff973b41fa98c081472e6896dfb254c0 0
5
h (1) 0xff2ea16466c96a3843ec78b326b52861 0xff2ea16466c96a3843ec78b326b52861 0
6
h (1) 0xfe5dee046a99a2a811c461f1969c3053 0xfe5dee046a99a2a811c461f1969c3053 0
7
h (1) 0xfcbe86c7900a88aedcffc83b479aa3a4 0xfcbe86c7900a88aedcffc83b479aa3a4 0
8
h (1) 0xf987a7253ac413176f2b074cf7815e54 0xf987a7253ac413176f2b074cf7815e54 0
9
T
h (1) 0xf3392b0822b70005940c7a398e4b70f3 0xf3392b0822b70005940c7a398e4b70f3 0
10 F
h (1) 0xe7159475a2c29b7443b29c7fa6e889dA9 0xe7159475a2c29b7443b29c7fa6e889d9 0
11
R
h (1) 0xd097f3bdfd2022b8845ad8f792aa5826 0xd097f3bdfd2022b8845ad8f792aa5825 1
12 D (cid:0)
h (1) 0xa9f746462d870fdf8a65dc1f90e061e5 0xa9f746462d870fdf8a65dc1f90e061e5 0
13
h (1) 0x70d869a156d2a1b890bb3df62baf32f7 0x70d869a156d2a1b890bb3df62baf32f7 0
14
h (1) 0x31be135f97d08fd981231505542fcfa6 0x31be135f97d08fd981231505542fcfa6 0
15
h (1) 0x9aa508b5b7a84e1c677de54f3e99bc9 0x9aa508b5b7a84e1c677de54f3e99bc9 0
16
h (1) 0x5d6af8dedb81196699c329225ee605 0x5d6af8dedb81196699c329225ee604 1
17
(cid:0)
h (1) 0x2216e584f5fa1ea926041bedfe98 0x2216e584f5fa1ea926041bedfe98 0
18
h (1) 0x48a170391f7dc42444e8fa3 0x48a170391f7dc42444e8fa2 1
19
(cid:0)
• Seebelowthesympycodetocalculatetheconstants:
import sympy
from math import ceil
# values from the codebase
u = [
0xfffcb933bd6fad37aa2d162d1a594001,
0xfff97272373d413259a46990580e213a,
0xfff2e50f5f656932ef12357cf3c7fdcc,
0xffe5caca7e10e4e61c3624eaa0941cd0,
0xffcb9843d60f6159c9db58835c926644,
0xff973b41fa98c081472e6896dfb254c0,
0xff2ea16466c96a3843ec78b326b52861,
0xfe5dee046a99a2a811c461f1969c3053,
0xfcbe86c7900a88aedcffc83b479aa3a4,
0xf987a7253ac413176f2b074cf7815e54,
7

0xf3392b0822b70005940c7a398e4b70f3,
0xe7159475a2c29b7443b29c7fa6e889d9,
0xd097f3bdfd2022b8845ad8f792aa5825,
0xa9f746462d870fdf8a65dc1f90e061e5,
0x70d869a156d2a1b890bb3df62baf32f7,
0x31be135f97d08fd981231505542fcfa6,
0x9aa508b5b7a84e1c677de54f3e99bc9,
0x5d6af8dedb81196699c329225ee604,
0x2216e584f5fa1ea926041bedfe98,
0x48a170391f7dc42444e8fa2,
| ]    |                      |                                         |         |              | T            |
| ---- | -------------------- | --------------------------------------- | ------- | ------------ | ------------ |
| x    | = sympy.symbols("x") |                                         |         |              |              |
| g    | = (                  |                                         |         |              |              |
|      |                      | ’                                       |         |              | ’            |
|      | sympy.S(             | 340282366920938463463374607431768211456 |         |              | ) # 2 ** 128 |
|      |                      | ’                                       | ’       |              |              |
|      | / (sympy.S(          | 10001/10000                             | ) ** (2 | ** (x - 1))) |              |
| )    |                      |                                         |         | F            |              |
| a    | = [0 for _           | in range(21)]                           |         |              |              |
| PREC | = 1000               |                                         |         |              |              |
’ ’
| a[0] | = g.evalf(PREC, | subs={x: | Asympy.S( | 0.0 )}) |     |
| ---- | --------------- | -------- | --------- | ------- | --- |
’ ’
| a[1] | = g.evalf(PREC, | subs={x: | sympy.S( | 1.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[2] | = g.evalf(PREC, | subs={x: | sympy.S( | 2.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[3] | = g.evalf(PREC, | subs={x: | sympy.S( | 3.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[4] | = g.evalf(PREC, | subs={x: | sympy.S( | 4.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[5] | = g.evalf(PREC, | subs={x: | sympy.S( | 5.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[6] | = g.evalf(PREC, | subs={x: | sympy.S( | 6.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
|      |                 | R’       |          | ’       |     |
| a[7] | = g.evalf(PREC, | subs={x: | sympy.S( | 7.0 )}) |     |
’ ’
| a[8] | = g.evalf(PREC, | subs={x: | sympy.S( | 8.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[9] | = g.evalf(PREC, | subs={x: | sympy.S( | 9.0 )}) |     |
| ---- | --------------- | -------- | -------- | ------- | --- |
’ ’
| a[10] | = g.evalf(PREC, | subs={x: | sympy.S( | 10.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[11] | = g.evalf(PREC, | subs={x: | sympy.S( | 11.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[12] | = g.evalf(PREC, | subs={x: | sympy.S( | 12.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[13]  | = g.evalf(PREC, | subs={x: | sympy.S( | 13.0 )}) |     |
| ------ | --------------- | -------- | -------- | -------- | --- |
| Da[14] |                 |          |          | ’ ’      |     |
|        | = g.evalf(PREC, | subs={x: | sympy.S( | 14.0 )}) |     |
’ ’
| a[15] | = g.evalf(PREC, | subs={x: | sympy.S( | 15.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[16] | = g.evalf(PREC, | subs={x: | sympy.S( | 16.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[17] | = g.evalf(PREC, | subs={x: | sympy.S( | 17.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[18] | = g.evalf(PREC, | subs={x: | sympy.S( | 18.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[19] | = g.evalf(PREC, | subs={x: | sympy.S( | 19.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
’ ’
| a[20] | = g.evalf(PREC, | subs={x: | sympy.S( | 20.0 )}) |     |
| ----- | --------------- | -------- | -------- | -------- | --- |
| for   | i in range(20): |          |          |          |     |
b = int(ceil(a[i]))
|     |          |                | ‘         | ‘ ‘       | ‘                   |
| --- | -------- | -------------- | --------- | --------- | ------------------- |
|     | print("| | $h_{{{3}}}(1)$ | | 0x{0:x} | | 0x{1:x} | | ${2:d}$|".format( |
b,
u[i],
|     | u[i] | - b, |     |     |     |
| --- | ---- | ---- | --- | --- | --- |
i
))
| 5. andsothevaluesh |     | 0 (1),h 12 (1),h | 17 (1),h 19 | (1)areoffby1. |     |
| ------------------ | --- | ---------------- | ----------- | ------------- | --- |
Recommendations:
1. Fix or document why a mixed use of rounding down and up is used in this function. This could have been
duetogassavingsinceonecouldjustuserightshiftsformultiplication.
2. Adjust the constants used for h (1),h (1),h (1),h (1). Note that with the adjusted constants (from the
|     |     |     | 0 12 | 17 19 |     |
| --- | --- | --- | ---- | ----- | --- |
8

Sympytable)thetestsuitestillpasses.
3. AddcodecommentslikeAperture-Finance/uni-v3-lib
4. Providedetails/proofaswhythefinalvaluefitsinuint160(Q64x96).
Warning: If2. isappliedtheinvariantsshouldbecheckedagain. MainlythatgetSqrtPriceAtTickis
sticktlyincreasingandalsoclosetotheactualvalue. Andalsoitsrelatedinvariantsinrelashionshipto
getTickAtSqrtPriceisalsopreserved.
Uniswap: Regarding2. Somecommentshavebeenaddedtoexplaintheroundingdirectionforh(1)tothenearest
i
integervalueinPR867.
T
Spearbit: Partiallyfixedandverified.
5.2.3 The used constants representing the min and max of the errors in getTickAtSqrtPrice are not
accurate
F
Severity: LowRisk
Context: TickMath.sol#L259-L262,LogarithmApproximationPrecisionbyABDK
Description: Intheabovecontextwehave:
int256 log_sqrt10001 = log_2 * 2557389A58999603826347141; // 128.128 number
int24 tickLow = int24((log_sqrt10001 - 3402992956809132418596140100660247210) >> 128);
int24 tickHi = int24((log_sqrt10001 + 291339464771989622907027621153398088495) >> 128);
Let:
R
255738958999603826347141
  =
264
1
20
|     |     |             |         | =1.08830 | 10 (cid:0)            |     |     |
| --- | --- | ----------- | ------- | -------- | --------------------- | --- | --- |
|     |     | (cid:0) log | p1.0001 |          | (cid:1)(cid:1)(cid:1) |     |     |
2
D
Let'scalculatetherounded-downmaximumerror:
1
| 2128      | max((cid:15)) | = 2128     | 64   |                      | +log 1.0000005 |     |     |
| --------- | ------------- | ---------- | ---- | -------------------- | -------------- | --- | --- |
|           | i             |            |      |                      | p1.0001        |     |     |
| b (cid:1) | c             | $ (cid:1)  |      | (cid:0) log p1.0001! |                | !%  |     |
2
2128
|     | max((cid:15)) | i =3402992956809132418596140100660247209 |     |     |     |     |     |
| --- | ------------- | ---------------------------------------- | --- | --- | --- | --- | --- |
| b   | (cid:1)       | c                                        |     |     |     |     |     |
The above is derived by wolframalpha. The value used in the code-
3402992956809132418596140100660247209
baseis 2128 max((cid:15)) whichdiffersbythecorrectvalueonlyby1:
d (cid:1) i e
2128
|     | max((cid:15)) | =3402992956809132418596140100660247210 |     |     |     |     |     |
| --- | ------------- | -------------------------------------- | --- | --- | --- | --- | --- |
| d   | (cid:1)       | i e                                    |     |     |     |     |     |
Let'scalculatetherounded-downminimiumerror:
|     |     | 1   |     | 1 3 | 1   | 1   |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
2128 min((cid:15)) = 2128 96   +  (cid:0) + 2 log 1 +log 0.9999995
b (cid:1) i c (cid:1) (cid:0) (cid:0) p1.0001! 2i 2 (cid:0) 2i 1 2 (cid:0) 2127 p1.0001
| $   |     | log |     |                   | (cid:0)           |                  | !%  |
| --- | --- | --- | --- | ----------------- | ----------------- | ---------------- | --- |
|     |     | 2   |     | (cid:18) (cid:18) | (cid:19) (cid:18) | (cid:19)(cid:19) |     |
Weareinterestedin 2128 min((cid:15) ) sinceonly14approximatedtermsareused:
14
| b   | (cid:1) | c   |     |     |     |     |     |
| --- | ------- | --- | --- | --- | --- | --- | --- |
9

|     |     | 2128 | min((cid:15) | ) = | 291339464771989623025533689748046440464 |     |     |     |     |     |
| --- | --- | ---- | ------------ | --- | --------------------------------------- | --- | --- | --- | --- | --- |
14
|     |     | b   | (cid:1) | c (cid:0) |     |     |     |     |     |     |
| --- | --- | --- | ------- | --------- | --- | --- | --- | --- | --- | --- |
The above -291339464771989623025533689748046440464 is derived by wolframalpha. The value used in the
codebaseisinsteadthefollowing:
|     |     |     | 1   |     | 1   | 3   | 1   |     | 1   |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
2128
|     | 64   |     |     | +   | (cid:0) + | 2   |     | log 1 |     | +log 0.9999995 |
| --- | ---- | --- | --- | --- | --------- | --- | --- | ----- | --- | -------------- |
(cid:1) (cid:0) (cid:0) log p1.0001! 2i 2 (cid:0) 2i 1 2 (cid:0) 2127 p1.0001
$   2 (cid:18) (cid:18) (cid:0) (cid:19) (cid:18) (cid:19)(cid:19) !%
whichequalsto-291339464771989622907027621153398088495. Thedifferenceis,oneshouldhaveused:
|     |     |     |     |     | 2128 (          | 96(  | )+                           | )                     |     |     |
| --- | --- | --- | --- | --- | --------------- | ---- | ---------------------------- | --------------------- | --- | --- |
|     |     |     |     |     | (cid:1) (cid:0) |      | (cid:0)(cid:1)(cid:1)(cid:1) | (cid:1)(cid:1)(cid:1) |     |     |
|     |     |     |     |     | (cid:4)         |      |                              | (cid:5)               |     |     |
butinsteadthefollowingiscalculated:
2128
|     |     |     |     |     | (               | 64(  | )+                           | )                     |     |     |
| --- | --- | --- | --- | --- | --------------- | ---- | ---------------------------- | --------------------- | --- | --- |
|     |     |     |     |     | (cid:1) (cid:0) |      | (cid:0)(cid:1)(cid:1)(cid:1) | (cid:1)(cid:1)(cid:1) |     |     |
This is error in using 64 instead of 96 comes (cid:4) from the Logarithm Approximation (cid:5) Precision by ABDK where in the
calculations it is assumed that x [2 64,264), ie it is of type Q64x64. Note that x in that document correponds to
2 (cid:0)
| price(P       | )whichis:               |     |     |     |        |     |     |     |     |     |
| ------------- | ----------------------- | --- | --- | --- | ------ | --- | --- | --- | --- | --- |
| uint256 price | = uint256(sqrtPriceX96) |     |     |     | << 32; |     |     |     |     |     |
T
F
WeknowthatsqrtPriceX96isofthetypeQ64x96andthuspriceisofthetypeQ64x128butsinceitismerelybeen
| multiplidedby232 | itsrangeremainsas[2 |     |     |     | 96,264). | Andthisiswhy64needstobeusedintheformulaformax((cid:15)) A |     |     |     |     |
| ---------------- | ------------------- | --- | --- | --- | -------- | --------------------------------------------------------- | --- | --- | --- | --- |
(cid:0) i
R
and 96formin((cid:15)).
| (cid:0) | i   |     |     |     | D   |     |     |     |     |     |
| ------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
uncheckedblocksafety:
Nooverflowshoudoccurincalculationoflog_sqrt10001sincelog_2attheveryendwouldbesmallerthan65 264
(cid:1)
and:
|     |     |     | 65 264          | 255738958999603826347141=65 |     |     |     | 2128    |         | <2148 |
| --- | --- | --- | --------------- | --------------------------- | --- | --- | --- | ------- | ------- | ----- |
|     |     |     | (cid:1) (cid:1) |                             |     |     |     | (cid:1) | (cid:1) |       |
andnounderflowsholdoccursincelog_2:
|     |     |         | 96 264 255738958999603826347141= |     |     |     |     | 96              | 2128    | > 2149  |
| --- | --- | ------- | -------------------------------- | --- | --- | --- | --- | --------------- | ------- | ------- |
|     |     | (cid:0) | (cid:1) (cid:1)                  |     |     |     |     | (cid:0) (cid:1) | (cid:1) | (cid:0) |
NooverfloworunsafecastingshouldoccurfortickHisince(withtheoldornewconstant):
2148+291339464771989622907027621153398088495
<221
2128
NounderfloworunsafecastingshouldoccurfortickLowsince(withtheoldornewconstant):
2149
3402992956809132418596140100660247210
|                 |     | (cid:0)                 | (cid:0) |     |     |      |     |     |     | > 222   |
| --------------- | --- | ----------------------- | ------- | --- | --- | ---- | --- | --- | --- | ------- |
|                 |     |                         |         |     |     | 2128 |     |     |     | (cid:0) |
| Recommendation: |     | Applythefollowingpatch: |         |     |     |      |     |     |     |         |
10

| diff --git               | a/src/libraries/TickMath.sol |        | b/src/libraries/TickMath.sol |
| ------------------------ | ---------------------------- | ------ | ---------------------------- |
| index 6e5f8417..7a1f58ca |                              | 100644 |                              |
--- a/src/libraries/TickMath.sol
+++ b/src/libraries/TickMath.sol
| @@ -107,11 | +107,11 | @@ library TickMath | {   |
| ---------- | ------- | ------------------- | --- |
}
}
- /// @notice Calculates the greatest tick value such that getPriceAtTick(tick) <= price
- /// @dev Throws in case sqrtPriceX96 < MIN_SQRT_PRICE, as MIN_SQRT_PRICE is the lowest value
| ,! getPriceAtTick |     | may |     |
| ----------------- | --- | --- | --- |
+ /// @notice Calculates the greatest tick value such that getSqrtPriceAtTick(tick) <= sqrtPriceX96
+ /// @dev Throws in case sqrtPriceX96 < MIN_SQRT_PRICE, as MIN_SQRT_PRICE is the lowest value
| ,! getSqrtPriceAtTick |              | may |     |
| --------------------- | ------------ | --- | --- |
| ///                   | ever return. |     |     |
/// @param sqrtPriceX96 The sqrt price for which to compute the tick as a Q64.96
- /// @return tick The greatest tick for which the price is less than or equal to the input price
+ /// @return tick The greatest tick for which the getSqrtPriceAtTick(tick) is less than or equal to
| ,! the | input sqrtPriceX96 |     |     |
| ------ | ------------------ | --- | --- |
function getTickAtSqrtPrice(uint160 sqrtPriceX96) internal pure returns (int24 tick) {
unchecked {
// Equivalent: if (sqrtPriceX96 < MIN_SQRT_PRICE || sqrtPriceX96 >= MAX_SQRT_PRICE) revert
,! InvalidSqrtPrice();
| @@ -256,10 | +256,10 | @@ library TickMath | {           |
| ---------- | ------- | ------------------- | ----------- |
|            | log_2   | := or(log_2,        | shl(50, f)) |
}
T
F
- int256 log_sqrt10001 = log_2 * 255738958999603826347141; // 128.128 number
+ int256 log_sqrt10001 = log_2 * 255738958999603826347141; A // Q22.128 number
R
int24((log_sqrDt10001
- int24 tickLow = - 3402992956809132418596140100660247210) >> 128);
- int24 tickHi = int24((log_sqrt10001 + 291339464771989622907027621153398088495) >> 128);
+ int24 tickLow = int24((log_sqrt10001 - 3402992956809132418596140100660247209) >> 128);
+ int24 tickHi = int24((log_sqrt10001 + 291339464771989623025533689748046440464) >> 128);
tick = tickLow == tickHi ? tickLow : getSqrtPriceAtTick(tickHi) <= sqrtPriceX96 ? tickHi :
,! tickLow;
}
Warning: The intervals provided by both the old and the new constant overlap almost entirely and
measure around 0.8661 in length. But on low side the old internal hangs out as much as 1 and
2128
(cid:1)(cid:1)(cid:1)
thenewinternalonthehighsidehangsoutasmuchas 3.482 andthustheresultisthatinsomeedge
1019(cid:1)(cid:1)(cid:1)
cases the current and the new implementation using the new constant might be off by one tick. Note
thatthecurrenttestsallpasswiththenewconstantssotheseedgecasesarenottestedthroughly.
Note: Moreover,onecanusetheborrowedmsbcalculationfromSoladytoreplacethecurrentcalcution
tosavesomegas:
| assembly | ("memory-safe") | {                                          |     |
| -------- | --------------- | ------------------------------------------ | --- |
| let      | f := shl(7,     | gt(r, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)) |     |
| msb      | := or(msb,      | f)                                         |     |
| r :=     | shr(f, r)       |                                            |     |
}
| assembly | ("memory-safe") | {                          |     |
| -------- | --------------- | -------------------------- | --- |
| let      | f := shl(6,     | gt(r, 0xFFFFFFFFFFFFFFFF)) |     |
| msb      | := or(msb,      | f)                         |     |
| r :=     | shr(f, r)       |                            |     |
}
| assembly | ("memory-safe") | {                  |     |
| -------- | --------------- | ------------------ | --- |
| let      | f := shl(5,     | gt(r, 0xFFFFFFFF)) |     |
11

| msb  | := or(msb, | f)  |     |     |     |     |     |
| ---- | ---------- | --- | --- | --- | --- | --- | --- |
| r := | shr(f,     | r)  |     |     |     |     |     |
}
| assembly | ("memory-safe") | {     |          |     |     |     |     |
| -------- | --------------- | ----- | -------- | --- | --- | --- | --- |
| let      | f := shl(4,     | gt(r, | 0xFFFF)) |     |     |     |     |
| msb      | := or(msb,      | f)    |          |     |     |     |     |
| r :=     | shr(f,          | r)    |          |     |     |     |     |
}
| assembly | ("memory-safe") | {     |        |     |     |     |     |
| -------- | --------------- | ----- | ------ | --- | --- | --- | --- |
| let      | f := shl(3,     | gt(r, | 0xFF)) |     |     |     |     |
| msb      | := or(msb,      | f)    |        |     |     | T   |     |
| r :=     | shr(f,          | r)    |        |     |     |     |     |
}
| assembly | ("memory-safe") | {     |       |     |     |     |     |
| -------- | --------------- | ----- | ----- | --- | --- | --- | --- |
| let      | f := shl(2,     | gt(r, | 0xF)) |     |     |     |     |
| msb      | := or(msb,      | f)    |       |     |     |     |     |
| r :=     | shr(f,          | r)    |       |     | F   |     |     |
}
| assembly | ("memory-safe") | {     |       |     |     |     |     |
| -------- | --------------- | ----- | ----- | --- | --- | --- | --- |
| let      | f := shl(1,     | gt(r, | 0x3)) |     |     |     |     |
| msb      | := or(msb,      | f)    |       |     |     |     |     |
| r :=     | shr(f,          | r)    |       |     |     |     |     |
| }        |                 |       | A     |     |     |     |     |
| assembly | ("memory-safe") | {     |       |     |     |     |     |
| let      | f := gt(r,      | 0x1)  |       |     |     |     |     |
| msb      | := or(msb,      | f)    |       |     |     |     |     |
}
Appendix: getTickAtSqrtPriceworksasfollowingnotethatpp isasymbolicvaluerepresentingsqrtPriceX96
R
whichisofthetypeQ64x96:
| 1. Checkpp |     | [pp min ,pp | max ). |     |     |     |     |
| ---------- | --- | ----------- | ------ | --- | --- | --- | --- |
2
2. ThenP =pp 232 andthusitisofthetypeQ64x128andintherange[2 96,264).
(cid:0)
(cid:1)
| 3. FindthemostsignificantbitofP |     |     | andlet'snameitn= |     | log P . |     |     |
| ------------------------------- | --- | --- | ---------------- | --- | ------- | --- | --- |
|                                 |     |     |                  |     | b 2 c   |     |     |
4.Dr istakentobe:
P
|     |     |     | r =r = |     | 2127 | 2127,2128 |     |
| --- | --- | --- | ------ | --- | ---- | --------- | --- |
0 2 log2P
|     |     |     |     | b        | c (cid:1) 2 |     |         |
| --- | --- | --- | --- | -------- | ----------- | --- | ------- |
|     |     |     |     | (cid:22) | (cid:23)    |     |         |
|     |     |     |     |          | (cid:2)     |     | (cid:1) |
and that is why multiplying r by itselft does not overflow (this also applies to the other iterations). We then
have:
r2
0 2127,2129
2127 2
(cid:22) (cid:23)
|     |     |     |     |     | (cid:2) | (cid:1) |     |
| --- | --- | --- | --- | --- | ------- | ------- | --- |
I'vemarkedtheassemblyblockbelowsothatwecanfollowthevariablenamingwithsubscripts:
|     | assembly | ("memory-safe") | {   |     |     |     |     |
| --- | -------- | --------------- | --- | --- | --- | --- | --- |
r := shr(127, mul(r, r)) // r_{i-1} = r before the multiplication
|     | let | f := shr(128, | r)  | // f_i | = f |     |     |
| --- | --- | ------------- | --- | ------ | --- | --- | --- |
log_2 := or(log_2, shl(64 - i, f)) // L_i(P) = L_{i-1}(P) | f_i * 2^{64-i}
|     | r := | shr(f, r) |     | // r_i | = the | assginment | value |
| --- | ---- | --------- | --- | ------ | ----- | ---------- | ----- |
}
andthus:
12

r2
0
2127
|     |     |     | f =f | =   | log        |     | =   | log | g(P) | 0,1 |     |
| --- | --- | --- | ---- | --- | ---------- | --- | --- | --- | ---- | --- | --- |
|     |     |     |      | 1   | 20j2127k17 |     |     | 2   |      |     |     |
|     |     |     |      | 6   |            |     |     | b   | c2f  | g   |     |
|     |     |     |      | 6   |            |     | 7   |     |      |     |     |
|     |     |     |      | 6   |            |     | 7   |     |      |     |     |
|     |     |     |      | 4   | @          |     | A5  |     |      |     |     |
Intheabovethefunctiong(x)isdefinedas:
2
|     |     |     |     |     |     | x   | 2127 |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | --- | --- | --- | --- |
2blog2xc
|     |     |     |     | g(x)= |       |      | (cid:1) | 2127    | 2 127     |     |     |
| --- | --- | --- | --- | ----- | ----- | ---- | ------- | ------- | --------- | --- | --- |
|     |     |     |     |       | 6 60j | 2127 |         | k1      | 7 (cid:0) |     |     |
|     |     |     |     |       |       |      |         | (cid:1) | T 7       |     |     |
|     |     |     |     |       | 6     |      |         |         | 7         |     |     |
|     |     |     |     |       | 6 4@  |      |         | A       | 7         |     |     |
5
| andsor iscalculatedas: |     |     |     |     |     |     |     |     |     |     |     |
| ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
1
g(P)
|          |              |     |     |     |            |     | 2127    | 2127,2128 |         |     |     |
| -------- | ------------ | --- | --- | --- | ---------- | --- | ------- | --------- | ------- | --- | --- |
|          |              |     |     | r 1 | =          |     | F       |           |         |     |     |
|          |              |     |     |     | 2 log2g(P) |     | (cid:1) | 2         |         |     |     |
|          |              |     |     |     | (cid:22) b | c   |         | (cid:23)  |         |     |     |
|          |              |     |     |     |            |     |         | (cid:2)   | (cid:1) |     |     |
| andthusf | endsupbeing: |     |     |     |            |     |         |           |         |     |     |
2
r2
1
|     |     |     |     | Alog |            | 2127 |       |         |     |     |     |
| --- | --- | --- | --- | ---- | ---------- | ---- | ----- | ------- | --- | --- | --- |
|     |     |     | f 2 | =    |            |      | = log | g(g(P)) |     | 0,1 |     |
|     |     |     |     | 6    | 20j2127k17 |      | b     | 2       | c2f | g   |     |
|     |     |     |     | 6    |            |      | 7     |         |     |     |     |
|     |     |     |     | 6    |            |      | 7     |         |     |     |     |
|     |     |     |     | 4    | @          | A5   |       |         |     |     |     |
andsotheithapproximationoflog_2usingtheL(P)notationwith64binaryprecisionendsupbeing:
i
|                  |        |          |                   |          | i   |         |         |          |              |     | i         |
| ---------------- | ------ | -------- | ----------------- | -------- | --- | ------- | ------- | -------- | ------------ | --- | --------- |
|                  |        |          | P                 |          |     |         |         |          | P            |     |           |
|                  | LR(P)= | log      |                   | 264+     |     | f 264   | k =     | log      | 264          |     | f 264 k   |
|                  | i      |          | 2                 |          |     | k       | (cid:0) | 2        |              |     | k (cid:0) |
|                  |        |          | 2128              | (cid:1)  |     | (cid:1) |         |          | 2128 (cid:1) | _   | (cid:1) ! |
|                  |        | (cid:22) |                   | (cid:23) | k=1 |         |         | (cid:22) | (cid:23)     | k=1 |           |
|                  |        |          |                   |          | X   |         |         |          |              | _   |           |
| Aboveonecando+or |        |          | (bitwiseor)sincef |          |     | 0,1     | .       |          |              |     |           |
|                  |        | _        |                   |          | k   | 2f      | g       |          |              |     |           |
NotethattheapproximationprovidedbytheABDKdocumentmatcheswiththeaboveformulanottakinginto
theconsiderationtheprecisionfactor264:
D
i
|     |     |     |           |     |          | P        |     | 1    |                       |        |     |
| --- | --- | --- | --------- | --- | -------- | -------- | --- | ---- | --------------------- | ------ | --- |
|     |     |     | LABDK(P)= |     | log      |          | +   | log  | g(g(                  | g(P))) |     |
|     |     |     | i         |     | 2        |          |     |      | 2                     |        |     |
|     |     |     |           |     |          | 2128     |     | 2k b | (cid:1)(cid:1)(cid:1) |        | c   |
|     |     |     |           |     | (cid:22) | (cid:23) | k=1 |      |                       |        |     |
X
| whereintheabovesummationtheg |     |     |     | functioniscomposedk |     |     |     | times. |     |     |     |
| ---------------------------- | --- | --- | --- | ------------------- | --- | --- | --- | ------ | --- | --- | --- |
For getTickAtSqrtPrice, i = 14 and so L 14 (P) is calculated. Also all approximations in this case L(P) are
i
| ofthetypeQ8x64. | Andso: |     |     |     |                |     |     |       |     |     |     |
| --------------- | ------ | --- | --- | --- | -------------- | --- | --- | ----- | --- | --- | --- |
|                 |        |     |     |     | logSqrt10001=L |     |     | (P)   | 264 |     |     |
14
|     |     |     |     |     |     |     |     | (cid:1) | (cid:1) |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ------- | ------- | --- | --- |
  264 isofthetypeQ14x64,thustheabovelogSqrt10001isofthetypeQ22x128
(cid:1)
13

5.2.4 PoolManager.updateDynamicLPFee()doesn'temitanevent
Severity: LowRisk
Context: PoolManager.sol#L324
Description: The PoolManager.updateDynamicLPFee() function allows the hook contract to update the LP fee
whenit'sdynamic. Thefeeisrecordedinthecontractstorage,however,there'snoevenemittedtoallowmonitoring
applicationstodetectthechange.
Recommendation: Consider emitting an event in PoolManager.updateDynamicLPFee() to allow off-chain appli-
cationstotrackLPfeechanges. T
Uniswap: Decided against emitting an event when the dynamic fee is updated. This is because the override
possibilityforindividualswapswouldmakeithardtotrackallofthemoffchain
Spearbit: Acknowledged.
F
5.2.5 bubbleUpAndRevertWithispronetoreturndatabombingandsomeotherminorissues
Severity: LowRisk
Context: CustomRevert.sol#L88,CustomRevert.sol#L91
Description/Recommendation: A
(cid:3) CustomRevert.sol#L88: copyingthereturndatatomemoryispronetoreturndatabombingandcanrevert
withoutofgashere. Itwouldbebesttofirstestimatetoseeifsuchanoperationcanhappenwiththecurrent
leftovergasandifsoperformthecopyorotherwisethrowwithadifferentgenericerror. Forreference,please
lookatthisimplementationfromSeaport.
(cid:3) CustomRevert.soRl#L91: useshrandshlinsteadofdivandmulsincetherighthandsideoperandsare32.
Thesolccompilermightatsomestepintheoptimisationdothereplacementbutitwouldbebesttoenforce
itinthecode.
(cid:3) CustomRevert.sol#L91: allocating more than copied memory in the revert statement might use portion of
the memory space which has already been filled by other data. If the size is being aligned to multiples of
32. If this operation is necessary it would be best to also make sure the extra allocated memory space is
Dcleaned.
5.3 Gas Optimization
5.3.1 Asimpleupcastingoperationcanbeperformed
Severity: GasOptimization
Context: SqrtPriceMath.sol#L241-L245
Description: ThecontractusesinlineassemblytoperformabitwiseANDoperationtorestricttheliquidityvalue
to 128 bits. However, this approach is unnecessarily complex and less readable compared to a simple upcasting
operation.
uint256 _liquidity;
assembly ("memory-safe") {
// avoid implicit upcasting
_liquidity := and(liquidity, 0xffffffffffffffffffffffffffffffff)
}
Recommendation: Replace the assembly code with a simple upcasting operation in order to simplifies the code
andprovideasmallgasoptimization.
uint256 _liquidity = uint256(liquidity);
14

| Uniswap:  | FixedinPR857. |     |     |     |     |
| --------- | ------------- | --- | --- | --- | --- |
| Spearbit: | Fixed.        |     |     |     |     |
5.3.2 toIdperformsanunnecesarylengthcalculation
| Severity: | GasOptimization           |     |     |     |     |
| --------- | ------------------------- | --- | --- | --- | --- |
| Context:  | PoolIdLibrary.sol#L12-L16 |     |     |     |     |
Description: toId function currently calculates the size of the poolKey struct in memory using the expression
mul(32, 5). While this is correct, it performs an unnecessary multiplication operation every time the function is
called. Replacingthiswithahardcodedvaluecansavegasandmaketheintentionclearer.
Recommendation: Replace the calculation mul(32, 5) with the hardcoded hexadecimal value 0xa0, which is
equivalentto160bytes(5 32). Additionally,addacommentexplainingthememorylayoutofPoolKeystructure.
(cid:2)
| Uniswap:  | FixedinPR857. |     |     |     |     |
| --------- | ------------- | --- | --- | --- | --- |
| Spearbit: | Verified.     |     |     |     |     |
5.3.3 state.sqrtPriceX96canbeusedinsteadofslot0Start.sqrtPriceX96()inPool.swap
| Severity: | GasOptimization    |     |     |     |     |
| --------- | ------------------ | --- | --- | --- | --- |
| Context:  | Pool.sol#L319-L328 |     |     |     |     |
Description: In this context when the params.sqrtPriceLimitX96 bounds are checked against
slot0Start.sqrtPriceX96(), the storage slots are rerTead again. Although they also have been cached in
| memoryinstate.sqrtPriceX96. |     |                                                          |     | F   |     |
| --------------------------- | --- | -------------------------------------------------------- | --- | --- | --- |
| Recommendation:             |     | Reusestate.sqrtPriceX96insteadofreadingfromstorageagain: |     | A   |     |
R
b/src/lDibraries/Pool.sol
| diff --git               | a/src/libraries/Pool.sol |        |     |     |     |
| ------------------------ | ------------------------ | ------ | --- | --- | --- |
| index 1a376354..7625e1f5 |                          | 100644 |     |     |     |
--- a/src/libraries/Pool.sol
+++ b/src/libraries/Pool.sol
| @@ -316,15 | +316,15 | @@ library Pool | {   |     |     |
| ---------- | ------- | --------------- | --- | --- | --- |
if (params.amountSpecified == 0) return (BalanceDeltaLibrary.ZERO_DELTA, 0, swapFee, state);
|     | if (zeroForOne) | {   |     |     |     |
| --- | --------------- | --- | --- | --- | --- |
- if (params.sqrtPriceLimitX96 >= slot0Start.sqrtPriceX96()) {
- PriceLimitAlreadyExceeded.selector.revertWith(slot0Start.sqrtPriceX96(),
params.sqrtPriceLimitX96);
,!
| +   | if (params.sqrtPriceLimitX96 |     | >=  | state.sqrtPriceX96) | {   |
| --- | ---------------------------- | --- | --- | ------------------- | --- |
+ PriceLimitAlreadyExceeded.selector.revertWith(state.sqrtPriceX96,
,! params.sqrtPriceLimitX96);
}
|     | if (params.sqrtPriceLimitX96 |     | <   | TickMath.MIN_SQRT_PRICE) | {   |
| --- | ---------------------------- | --- | --- | ------------------------ | --- |
PriceLimitOutOfBounds.selector.revertWith(params.sqrtPriceLimitX96);
}
} else {
- if (params.sqrtPriceLimitX96 <= slot0Start.sqrtPriceX96()) {
- PriceLimitAlreadyExceeded.selector.revertWith(slot0Start.sqrtPriceX96(),
,! params.sqrtPriceLimitX96);
| +   | if (params.sqrtPriceLimitX96 |     | <=  | state.sqrtPriceX96) | {   |
| --- | ---------------------------- | --- | --- | ------------------- | --- |
+ PriceLimitAlreadyExceeded.selector.revertWith(state.sqrtPriceX96,
,! params.sqrtPriceLimitX96);
}
|     | if (params.sqrtPriceLimitX96 |     | >=  | TickMath.MAX_SQRT_PRICE) | {   |
| --- | ---------------------------- | --- | --- | ------------------------ | --- |
PriceLimitOutOfBounds.selector.revertWith(params.sqrtPriceLimitX96);
| forge s | --diff |     |     |     |     |
| ------- | ------ | --- | --- | --- | --- |
15

| test_swap_beforeSwapNoOpsSwap_exactInput()  |     | (gas: | -2    | (-0.000%))    |
| ------------------------------------------- | --- | ----- | ----- | ------------- |
| test_swap_beforeSwapNoOpsSwap_exactOutput() |     |       | (gas: | -2 (-0.000%)) |
test_addLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: 4 (0.000%))
test_removeLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: 4 (0.001%))
| test_swap_succeedsWithCorrectSelectors()          |              | (gas: | 21           | (0.001%))          |
| ------------------------------------------------- | ------------ | ----- | ------------ | ------------------ |
| test_swap_failsWithIncorrectSelectors()           |              | (gas: | 21 (0.001%)) |                    |
| test_swap_withHooks_gas() (gas:                   | 42 (0.001%)) |       |              |                    |
| test_swap_afterSwapFeeOnUnspecified_exactInput()  |              |       | (gas:        | 21 (0.002%))       |
| test_swap_afterSwapFeeOnUnspecified_exactOutput() |              |       |              | (gas: 21 (0.002%)) |
test_shouldSwapEqual(uint24,int24,int24,int24,int256,int256,int128,bool) (gas: 115 (0.002%))
| test_swap_succeedsWithHooksIfInitialized() |              | (gas: | 21  | (0.002%)) |
| ------------------------------------------ | ------------ | ----- | --- | --------- |
| test_getFeeGrowthInside() (gas:            | 21 (0.003%)) |       |     |           |
test_fuzz_getTickLiquidity((int24,int24,int256,bytes32)) (gas: 9 (0.003%))
| test_fuzz_getTickBitmap((int24,int24,int256,bytes32)) |     |           |     | (gas: 9 (0.004%)) |
| ----------------------------------------------------- | --- | --------- | --- | ----------------- |
| test_getTickInfo() (gas: 21 (0.004%))                 |     |           |     |                   |
| test_getTickFeeGrowthOutside() (gas:                  | 21  | (0.004%)) |     |                   |
test_getSlot0() (gas: 21 (0.004%))
| test_getPositionInfo() (gas: 21                      | (0.005%))    |           |              |                    |
| ---------------------------------------------------- | ------------ | --------- | ------------ | ------------------ |
| test_swap_withDynamicFee_gas() (gas:                 | 21           | (0.005%)) |              |                    |
| test_dynamicReturnSwapFee_notStored()                |              | (gas:     | 21 (0.005%)) |                    |
| test_dynamicReturnSwapFee_notUsedIfPoolIsStaticFee() |              |           |              | (gas: 21 (0.005%)) |
| test_getFeeGrowthGlobals0() (gas:                    | 21 (0.005%)) |           |              |                    |
| test_fuzz_nonZeroDeltaCount(uint256)                 | (gas:        | 12        | (0.006%))    |                    |
| test_getFeeGrowthGlobals1() (gas:                    | 21 (0.006%)) |           |              |                    |
| test_swap_succeedsWithHook() (gas:                   | 21           | (0.009%)) |              |                    |
test_nestedSwap() (gas: 21 (0.010%))
T
| test_collectProtocolFees_ERC20_accumulateFees_gas() |     |     |     | (gas: 21 (0.011%)) |
| --------------------------------------------------- | --- | --- | --- | ------------------ |
F
| test_swap_99PercentFee_AmountOut_WithProtocol() |     |     | (gas: | 21 (0.011%)) |
| ----------------------------------------------- | --- | --- | ----- | ------------ |
test_collectProtocolFees_nativeToken_accumulateFees_gas() A (gas: 21 (0.011%))
R
test_collectProtocolFees_ERC20_accumulateFees_exactOutput() (gas: 21 (0.011%))
test_collectProtocolFees_nativeToken_returnDsAllFeesIf0IsProvidedAsParameter()
(gas: 21 (0.011%))
test_collectProtocolFees_ERC20_returnsAllFeesIf0IsProvidedAsParameter() (gas: 21 (0.011%))
| test_afterDonate_skipIfCalledByHook()               |       | (gas: | 3000 (0.012%)) |                    |
| --------------------------------------------------- | ----- | ----- | -------------- | ------------------ |
| test_beforeDonate_skipIfCalledByHook()              |       | (gas: | 3000           | (0.012%))          |
| test_swap_100PercentFee_AmountIn_WithProtocol()     |       |       | (gas:          | 21 (0.012%))       |
| test_afterRemoveLiquidity_skipIfCalledByHook()      |       |       | (gas:          | 3000 (0.012%))     |
| test_afterAddLiquidity_skipIfCalledByHook()         |       |       | (gas:          | 3000 (0.012%))     |
| test_beforeAddLiquidity_skipIfCalledByHook()        |       |       | (gas:          | 3000 (0.012%))     |
| test_beforeRemoveLiquidity_skipIfCalledByHook()     |       |       | (gas:          | 3000 (0.012%))     |
| test_gas_beforeSwap_skipIfCalledByHook()            |       | (gas: | 3042           | (0.012%))          |
| test_afterInitialize_skipIfCalledByHook()           |       | (gas: | 3000           | (0.012%))          |
| test_beforeInitialize_skipIfCalledByHook()          |       | (gas: | 3000           | (0.012%))          |
| test_emitsSwapFee() (gas: 21 (0.012%))              |       |       |                |                    |
| test_afterSwap_skipIfCalledByHook()                 | (gas: | 3084  | (0.012%))      |                    |
| test_beforeSwap_skipIfCalledByHook()                | (gas: | 3084  | (0.012%))      |                    |
| test_swap_mint6909IfOutputNotTaken_gas()            |       | (gas: | 21             | (0.012%))          |
| test_updateDynamicLPFee_beforeSwap_succeeds_gas()   |       |       |                | (gas: 21 (0.013%)) |
| test_returnDynamicSwapFee_beforeSwap_succeeds_gas() |       |       |                | (gas: 21 (0.013%)) |
| test_swap_50PercentLPFee_AmountIn_NoProtocol()      |       |       | (gas:          | 21 (0.013%))       |
test_fuzz_getPositionInfo((int24,int24,int256,bytes32),uint256,bool) (gas: -79 (-0.013%))
| test_swap_succeedsIfInitialized()                    | (gas: | 21 (0.013%)) |              |                    |
| ---------------------------------------------------- | ----- | ------------ | ------------ | ------------------ |
| test_swap_50PercentLPFee_AmountOut_NoProtocol()      |       |              | (gas:        | 21 (0.013%))       |
| test_settle_withStartingBalance()                    | (gas: | 21 (0.014%)) |              |                    |
| test_swap_100PercentLPFee_AmountIn_NoProtocol()      |       |              | (gas:        | 21 (0.014%))       |
| test_swap_succeedsWithNativeTokensIfInitialized()    |       |              |              | (gas: 21 (0.014%)) |
| test_swap_helper_zeroForOne_exactInput()             |       | (gas:        | 21           | (0.014%))          |
| test_swap_helper_zeroForOne_exactOutput()            |       | (gas:        | 21           | (0.014%))          |
| test_fuzz_dynamicReturnSwapFee(uint24)               |       | (gas:        | 21 (0.014%)) |                    |
| test_swap_mint6909IfNativeOutputNotTaken_gas()       |       |              | (gas:        | 21 (0.014%))       |
| test_swapNativeInput_helper_zeroForOne_exactOutput() |       |              |              | (gas: 21 (0.015%)) |
| test_swap_helper_oneForZero_exactOutput()            |       | (gas:        | 21           | (0.015%))          |
16

| test_swap_helper_oneForZero_exactInput()             |     |     | (gas: 21 | (0.015%))          |
| ---------------------------------------------------- | --- | --- | -------- | ------------------ |
| test_fuzz_getLiquidity((int24,int24,int256,bytes32)) |     |     |          | (gas: 38 (0.015%)) |
test_ffi_fuzz_addLiquidity_defaultPool_ReturnsCorrectLiquidityDelta((int24,int24,int256,bytes32)) (gas:
,! 40 (0.015%))
| test_swap_helper_native_zeroForOne_exactInput()      |       |                    | (gas:              | 21 (0.015%))       |
| ---------------------------------------------------- | ----- | ------------------ | ------------------ | ------------------ |
| test_swapNativeInput_helper_zeroForOne_exactInput()  |       |                    |                    | (gas: 21 (0.015%)) |
| test_swap_succeeds()                                 | (gas: | 21 (0.015%))       |                    |                    |
| test_take_failsWithNoLiquidity()                     |       | (gas:              | 3000 (0.015%))     |                    |
| test_swap_burn6909AsInput_gas()                      |       | (gas:              | 42 (0.016%))       |                    |
| test_swapNativeInput_helper_oneForZero_exactOutput() |       |                    |                    | (gas: 21 (0.016%)) |
| test_swapNativeInput_helper_oneForZero_exactInput()  |       |                    |                    | (gas: 21 (0.016%)) |
| test_swap_helper_native_oneForZero_exactOutput()     |       |                    | (gas:              | 21 (0.016%))       |
| test_swap_helper_native_oneForZero_exactInput()      |       |                    | (gas:              | 21 (0.016%))       |
| test_swap_gas()                                      | (gas: | 21 (0.016%))       |                    |                    |
| test_afterSwap_invalidReturn()                       |       | (gas: 21           | (0.017%))          |                    |
| test_swap_withNative_succeeds()                      |       | (gas:              | 21 (0.017%))       |                    |
| test_swap_burnNative6909AsInput_gas()                |       |                    | (gas: 42 (0.017%)) |                    |
| test_swap_withNative_gas()                           |       | (gas: 21 (0.018%)) |                    |                    |
| test_swap_againstLiqWithNative_gas()                 |       | (gas:              | 42 (0.021%))       |                    |
| test_swap_againstLiquidity_gas()                     |       | (gas:              | 42 (0.021%))       |                    |
test_fuzz_getFeeGrowthInside((int24,int24,int256,bytes32),bool) (gas: 405 (0.067%))
test_fuzz_ProtocolAndLPFee(uint24,uint16,uint16,int256) (gas: 162 (0.081%))
test_fuzz_swap(uint160,uint24,uint16,uint16,(int24,bool,int256,uint160,uint24)) (gas: 26 (0.159%))
test_fuzz_getTickLiquidity_two_positions((int24,int24,int256,bytes32),(int24,int24,int256,bytes32))
| ,! (gas: | -763 (-0.182%)) |     |     |     |
| -------- | --------------- | --- | --- | --- |
test_fuzz_consecutiveExtsload(uint256,uint256,uint256) (gas: 2014 (0.221%))
test_fuzz_getPositionLiquidity((int24,int24,int256,bytes32),(int24,int24,int256,bytes32)) (gas: -1104
T
,! (-0.253%))
F
test_shouldSwapEqualMultipleLP(uint24,int24,(int24,int24,int256)[],int256,int128,bool) (gas: -39552
A
,! (-0.460%))
R
| test_fuzz_extsload(uint256,uint256,bytes) |     |     | (gas: 14346 | (1.126%)) |
| ----------------------------------------- | --- | --- | ----------- | --------- |
test_swap_accruesProtocolFees(uint16,uint16D,int256)
(gas: -11043 (-1.553%))
test_fuzz_collectProtocolFees(address,uint256,uint256) (gas: -9403 (-10.907%))
| Overall   | gas change: -7252 | (-0.002%)                 |     |     |
| --------- | ----------------- | ------------------------- | --- | --- |
| Uniswap:  | Acknowledged.     | Recommendationnotapplied. |     |     |
| Spearbit: | Acknowledged.     |                           |     |     |
5.3.4 UnnecessaryoperationsintickSpacingToMaxLiquidityPerTickcanberemoved
| Severity: | GasOptimization    |     |     |     |
| --------- | ------------------ | --- | --- | --- |
| Context:  | Pool.sol#L574-L577 |     |     |     |
Description/Recommendation: The calculation in this context can be simplified by removing the unnecessary
multiplicationandthendivisionbytickSpacing:
| let minTick  | := sdiv(MIN_TICK,                       | tickSpacing) |     |           |
| ------------ | --------------------------------------- | ------------ | --- | --------- |
| let maxTick  | := sdiv(MAX_TICK,                       | tickSpacing) |     |           |
| let numTicks | := add(sub(maxTick,                     | minTick),    | 1)  |           |
| result :=    | div(0xffffffffffffffffffffffffffffffff, |              |     | numTicks) |
forge s --diff
| test_swap_withHooks_gas()                          |     | (gas: -21 (-0.001%)) |           |                      |
| -------------------------------------------------- | --- | -------------------- | --------- | -------------------- |
| test_swap_succeedsWithCorrectSelectors()           |     |                      | (gas: -21 | (-0.001%))           |
| test_donate_succeedsWithCorrectSelectors()         |     |                      | (gas: -21 | (-0.001%))           |
| test_donate_failsWithIncorrectSelectors()          |     |                      | (gas: -21 | (-0.001%))           |
| test_swap_failsWithIncorrectSelectors()            |     |                      | (gas: -21 | (-0.001%))           |
| test_removeLiquidity_failsWithIncorrectSelectors() |     |                      |           | (gas: -21 (-0.001%)) |
| test_addLiquidity_succeedsWithCorrectSelectors()   |     |                      | (gas:     | -21 (-0.001%))       |
17

| test_addLiquidity_withHooks_gas()               | (gas: | -21 | (-0.001%)) |       |                |
| ----------------------------------------------- | ----- | --- | ---------- | ----- | -------------- |
| test_addLiquidity_failsWithIncorrectSelectors() |       |     |            | (gas: | -21 (-0.001%)) |
test_removeLiquidity_succeedsWithCorrectSelectors() (gas: -21 (-0.001%))
| test_removeLiquidity_withHooks_gas()              |     | (gas: | -21   | (-0.001%))     |                |
| ------------------------------------------------- | --- | ----- | ----- | -------------- | -------------- |
| test_swap_afterSwapFeeOnUnspecified_exactInput()  |     |       |       | (gas:          | -21 (-0.002%)) |
| test_swap_afterSwapFeeOnUnspecified_exactOutput() |     |       |       | (gas:          | -21 (-0.002%)) |
| test_removeLiquidity_withFeeTakingHook()          |     |       | (gas: | -21 (-0.002%)) |                |
test_fuzz_swap_beforeSwap_returnsDeltaSpecified(int128,int256,bool) (gas: -21 (-0.002%))
| test_swap_beforeSwapNoOpsSwap_exactInput()  |     |     | (gas: | -21 | (-0.002%)) |
| ------------------------------------------- | --- | --- | ----- | --- | ---------- |
| test_swap_beforeSwapNoOpsSwap_exactOutput() |     |     | (gas: | -21 | (-0.002%)) |
test_shouldSwapEqual(uint24,int24,int24,int24,int256,int256,int128,bool) (gas: -113 (-0.002%))
| test_swap_succeedsWithHooksIfInitialized() |     |     | (gas: | -21 | (-0.002%)) |
| ------------------------------------------ | --- | --- | ----- | --- | ---------- |
test_addLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: -18 (-0.002%))
test_removeLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: -18 (-0.002%))
test_modifyLiquidity_sameSalt_differentLiquidityRouters_doNotEditSamePosition() (gas: -42 (-0.002%))
test_take_failsWithInvalidTokensThatDoNotReturnTrueOnTransfer() (gas: -21 (-0.002%))
| test_addLiquidity_withFeeTakingHook()          |     | (gas: | -42   | (-0.003%)) |                  |
| ---------------------------------------------- | --- | ----- | ----- | ---------- | ---------------- |
| test_afterInitialize_skipIfCalledByHook()      |     |       | (gas: | -1013      | (-0.004%))       |
| test_beforeInitialize_skipIfCalledByHook()     |     |       | (gas: | -1013      | (-0.004%))       |
| test_afterSwap_skipIfCalledByHook()            |     | (gas: | -1034 | (-0.004%)) |                  |
| test_beforeSwap_skipIfCalledByHook()           |     | (gas: | -1034 | (-0.004%)) |                  |
| test_afterDonate_skipIfCalledByHook()          |     | (gas: | -1034 | (-0.004%)) |                  |
| test_beforeDonate_skipIfCalledByHook()         |     | (gas: | -1034 | (-0.004%)) |                  |
| test_gas_beforeSwap_skipIfCalledByHook()       |     |       | (gas: | -1034      | (-0.004%))       |
| test_afterRemoveLiquidity_skipIfCalledByHook() |     |       |       | (gas:      | -1097 (-0.004%)) |
| test_afterAddLiquidity_skipIfCalledByHook()    |     |       | (gas: | -1097      | (-0.004%))       |
| test_beforeAddLiquidity_skipIfCalledByHook()   |     |       | (gas: | -1097      | (-0.004%))       |
T
| test_beforeRemoveLiquidity_skipIfCalledByHook() |     |     |     | (gas: | -1097 (-0.004%)) |
| ----------------------------------------------- | --- | --- | --- | ----- | ---------------- |
F
| test_getPositionInfo() (gas: | -21 (-0.005%)) |     |     |     |     |
| ---------------------------- | -------------- | --- | --- | --- | --- |
A
| test_swap_withDynamicFee_gas() | (gas: | -21 | (-0.005%)) |     |     |
| ------------------------------ | ----- | --- | ---------- | --- | --- |
R
test_beforeAfterRemoveLiquidity_calledWithZeroLiquidityDelta() (gas: -21 (-0.005%))
test_fuzz_getLiquidity((int24,int24,int256,Dbytes32))
|                                       |       |       |            |            | (gas: -13 (-0.005%)) |
| ------------------------------------- | ----- | ----- | ---------- | ---------- | -------------------- |
| test_take_failsWithNoLiquidity()      | (gas: | -1011 | (-0.005%)) |            |                      |
| test_dynamicReturnSwapFee_notStored() |       | (gas: | -21        | (-0.005%)) |                      |
test_dynamicReturnSwapFee_notUsedIfPoolIsStaticFee() (gas: -21 (-0.005%))
| test_getFeeGrowthGlobals0() (gas: | -21 | (-0.005%)) |     |     |     |
| --------------------------------- | --- | ---------- | --- | --- | --- |
| test_getFeeGrowthGlobals1() (gas: | -21 | (-0.006%)) |     |     |     |
test_beforeAfterAddLiquidity_beforeAfterRemoveLiquidity_succeedsWithHook() (gas: -21 (-0.006%))
test_ffi_addLiqudity_weirdPool_0_returnsCorrectLiquidityDelta() (gas: -21 (-0.006%))
test_beforeAfterRemoveLiquidity_calledWithPositiveLiquidityDelta() (gas: -21 (-0.007%))
| test_settle_withNoStartingBalance()    |                | (gas:      | -21 (-0.007%)) |            |     |
| -------------------------------------- | -------------- | ---------- | -------------- | ---------- | --- |
| test_getFeeGrowthInside() (gas:        | -42            | (-0.007%)) |                |            |     |
| test_getTickLiquidity() (gas:          | -21 (-0.007%)) |            |                |            |     |
| test_getTickBitmap() (gas: -21         | (-0.007%))     |            |                |            |     |
| test_getPositionLiquidity() (gas:      | -21            | (-0.007%)) |                |            |     |
| test_gas_modifyLiquidity_newPosition() |                | (gas:      | -21            | (-0.007%)) |     |
| test_getTickInfo() (gas: -42           | (-0.008%))     |            |                |            |     |
| test_getTickFeeGrowthOutside()         | (gas:          | -42        | (-0.008%))     |            |     |
test_beforeAfterAddLiquidity_calledWithPositiveLiquidityDelta() (gas: -21 (-0.008%))
| test_getSlot0() (gas: -42 (-0.008%)) |       |                |     |     |     |
| ------------------------------------ | ----- | -------------- | --- | --- | --- |
| test_addLiquidity_6909() (gas:       | -21   | (-0.008%))     |     |     |     |
| test_nestedRemoveLiquidity()         | (gas: | -21 (-0.008%)) |     |     |     |
| test_removeLiquidity_6909() (gas:    | -21   | (-0.008%))     |     |     |     |
test_ffi_addLiqudity_weirdPool_1_returnsCorrectLiquidityDelta() (gas: -21 (-0.008%))
| test_afterRemoveLiquidity_invalidReturn()       |            |            | (gas: | -21 (-0.009%)) |                |
| ----------------------------------------------- | ---------- | ---------- | ----- | -------------- | -------------- |
| test_nestedAddLiquidity() (gas:                 | -21        | (-0.009%)) |       |                |                |
| test_beforeRemoveLiquidity_invalidReturn()      |            |            | (gas: | -21            | (-0.009%))     |
| test_getLiquidity() (gas: -42                   | (-0.010%)) |            |       |                |                |
| test_removeLiquidity_someLiquidityRemains_gas() |            |            |       | (gas:          | -21 (-0.011%)) |
test_modifyLiquidity_samePosition_withSalt_isUpdated() (gas: -42 (-0.012%))
test_modifyLiquidity_samePosition_zeroSalt_isUpdated() (gas: -42 (-0.012%))
| test_removeLiquidity_gas() (gas: | -17 | (-0.012%)) |     |     |     |
| -------------------------------- | --- | ---------- | --- | --- | --- |
18

test_gas_modifyLiquidity_updateSamePosition_withSalt() (gas: -42 (-0.012%))
test_ffi_fuzz_addLiquidity_defaultPool_ReturnsCorrectLiquidityDelta((int24,int24,int256,bytes32)) (gas:
-33 (-0.013%))
,!
test_fuzz_getTickLiquidity((int24,int24,int256,bytes32)) (gas: -33 (-0.013%))
test_modifyLiquidity_sameTicks_withDifferentSalt_isNotUpdated() (gas: -60 (-0.013%))
test_fuzz_getTickBitmap((int24,int24,int256,bytes32)) (gas: -33 (-0.013%))
| test_addLiquidity_gas() |     | (gas: -21 (-0.013%)) |     |
| ----------------------- | --- | -------------------- | --- |
test_addLiquidity_succeedsIfInitialized(uint160) (gas: -21 (-0.014%))
test_addLiquidity_succeedsForNativeTokensIfInitialized(uint160) (gas: -21 (-0.014%))
| test_addLiquidity_withNative_gas()     |     |       | (gas: -21 (-0.014%)) |
| -------------------------------------- | --- | ----- | -------------------- |
| test_afterAddLiquidity_invalidReturn() |     |       | (gas: -21 (-0.014%)) |
| test_addLiquidity_succeeds()           |     | (gas: | -21 (-0.015%))       |
test_shouldSwapEqualMultipleLP(uint24,int24,(int24,int24,int256)[],int256,int128,bool) (gas: 1767
(0.021%))
,!
test_addLiquidity_secondAdditionSameRange_gas() (gas: -42 (-0.022%))
test_fuzz_getTickLiquidity_two_positions((int24,int24,int256,bytes32),(int24,int24,int256,bytes32))
| ,! (gas: | -135 (-0.032%)) |     |     |
| -------- | --------------- | --- | --- |
test_fuzz_ProtocolAndLPFee(uint24,uint16,uint16,int256) (gas: 141 (0.070%))
test_fuzz_getFeeGrowthInside((int24,int24,int256,bytes32),bool) (gas: -462 (-0.076%))
test_fuzz_getPositionLiquidity((int24,int24,int256,bytes32),(int24,int24,int256,bytes32)) (gas: -364
,! (-0.083%))
testTick_tickSpacingToParametersInvariants_fuzz(int24) (gas: -24 (-0.224%))
test_fuzz_tickSpacingToMaxLiquidityPerTick(int24) (gas: -21 (-0.240%))
test_fuzz_initialize((address,address,uint24,int24,address),uint160) (gas: 45 (0.275%))
test_fuzz_getPositionInfo((int24,int24,int256,bytes32),uint256,bool) (gas: 2642 (0.443%))
test_swap_accruesProtocolFees(uint16,uint16,int256) (gas: -11106 (-1.562%))
| Overall | gas change: -21941 | (-0.005%) |     |
| ------- | ------------------ | --------- | --- |
T
F
| Uniswap: | FixedinPR823. |     |     |
| -------- | ------------- | --- | --- |
A
| Spearbit: | Verified. |     | R   |
| --------- | --------- | --- | --- |
D
5.3.5 DerivingliquidityGrossBeforecanbeoptimised
| Severity: | GasOptimization |     |     |
| --------- | --------------- | --- | --- |
| Context:  | Pool.sol#L523   |     |     |
Description/Recommendation: Itischeapertomaskavaluebyusingandthanshiftingleftthenright:
uint256 internal constant LIQUIDITY_GROSS_MASK = 0xffffffffffffffffffffffffffffffff;
// ...
| liquidityGrossBefore | :=                                               | and(liquidity, | LIQUIDITY_GROSS_MASK) |
| -------------------- | ------------------------------------------------ | -------------- | --------------------- |
| Uniswap:             | UsageoftheassemblyblockhasbeenremovedinPR827.    |                |                       |
| Spearbit:            | Verifiedsincetheoptimisationdoesnotapplyanymore. |                |                       |
5.3.6 msg.sendercanbeinlinedin_burnFromtosavegas
| Severity: | GasOptimization           |     |     |
| --------- | ------------------------- | --- | --- |
| Context:  | ERC6909Claims.sol#L14-L19 |     |     |
Description/Recommendation: msg.sender can be inlined in _burnFrom to save gas to avoid using the sender
stackvariable:
19

| function | _burnFrom(address               | from, uint256                      | id, uint256 | amount)         | internal  | {   |
| -------- | ------------------------------- | ---------------------------------- | ----------- | --------------- | --------- | --- |
|          | if (from != msg.sender          | && !isOperator[from][msg.sender])  |             |                 | {         |     |
|          | uint256 senderAllowance         | = allowance[from][msg.sender][id]; |             |                 |           |     |
|          | if (senderAllowance             | != type(uint256).max)              |             | {               |           |     |
|          | allowance[from][msg.sender][id] |                                    | =           | senderAllowance | - amount; |     |
}
}
|     | _burn(from, id, amount); |     |     |     |     |     |
| --- | ------------------------ | --- | --- | --- | --- | --- |
}
| forge | snapshot --diff |     |     |     |     |     |
| ----- | --------------- | --- | --- | --- | --- | --- |
test_addLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: 5 (0.001%))
test_removeLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: 5 (0.001%))
test_fuzz_getTickLiquidity((int24,int24,int256,bytes32)) (gas: 9 (0.003%))
| test_fuzz_getTickBitmap((int24,int24,int256,bytes32)) |     |     |     | (gas: | 9 (0.004%)) |     |
| ----------------------------------------------------- | --- | --- | --- | ----- | ----------- | --- |
test_ffi_fuzz_addLiquidity_defaultPool_ReturnsCorrectLiquidityDelta((int24,int24,int256,bytes32)) (gas:
,! 10 (0.004%))
test_fuzz_getPositionLiquidity((int24,int24,int256,bytes32),(int24,int24,int256,bytes32)) (gas: 17
(0.004%))
,!
test_shouldSwapEqual(uint24,int24,int24,int24,int256,int256,int128,bool) (gas: 287 (0.005%))
| test_fuzz_getLiquidity((int24,int24,int256,bytes32)) |     |     |     | (gas: | 29 (0.012%)) |     |
| ---------------------------------------------------- | --- | --- | --- | ----- | ------------ | --- |
test_fuzz_getTickLiquidity_two_positions((int24,int24,int256,bytes32),(int24,int24,int256,bytes32))
| ,!  | (gas: -79 (-0.019%)) |     |     |     |     |     |
| --- | -------------------- | --- | --- | --- | --- | --- |
test_fuzz_getFeeGrowthInside((int24,int24,int256,bytes32),bool) (gas: 232 (0.038%))
test_shouldSwapEqualMultipleLP(uint24,int24,(int24,inTt24,int256)[],int256,int128,bool) (gas: -4712
| ,!  | (-0.055%)) |     |     | F   |     |     |
| --- | ---------- | --- | --- | --- | --- | --- |
test_fuzz_nextInitializedTickWithinOneWord(int24A,bool) (gas: -75 (-0.108%))
| test_fuzz_extsload(uint256,uint256,bytes) |     |     | (gas: | 7173 (0.563%)) |     |     |
| ----------------------------------------- | --- | --- | ----- | -------------- | --- | --- |
R
test_fuzz_getPositionInfo((int24,int24,int256,bytes32),uint256,bool) (gas: 7118 (1.194%))
D
test_swap_accruesProtocolFees(uint16,uint16,int256) (gas: -11064 (-1.556%))
| Overall   | gas change: -1036                             | (-0.000%) |     |     |     |     |
| --------- | --------------------------------------------- | --------- | --- | --- | --- | --- |
| Uniswap:  | Wedon'tthinkthisapproachwouldimprovegascosts. |           |     |     |     |     |
| Spearbit: | Acknowledged.                                 |           |     |     |     |     |
5.3.7 _fetchProtocolFeecanbeoptimisedbyusingthescratchspace
| Severity: | GasOptimization          |     |     |     |     |     |
| --------- | ------------------------ | --- | --- | --- | --- | --- |
| Context:  | ProtocolFees.sol#L88-L93 |     |     |     |     |     |
Description: If success is true then we know that the returndatasize() should be 32 so we can copy the
returnedvaluetothefirstmemoryslotinthescratchspacetosaveongascost.
Recommendation: Avoid using the free memory point and instead use the scratch space to copy and use the
returnedvalue:
| if success | {                      |        |     |     |     |     |
| ---------- | ---------------------- | ------ | --- | --- | --- | --- |
|            | returndatacopy(0,      | 0, 32) |     |     |     |     |
|            | returnData := mload(0) |        |     |     |     |     |
}
| forge                                      | snapshot --diff |                      |       |                |     |     |
| ------------------------------------------ | --------------- | -------------------- | ----- | -------------- | --- | --- |
| test_swap_withHooks_gas()                  |                 | (gas: -11 (-0.000%)) |       |                |     |     |
| test_swap_succeedsWithCorrectSelectors()   |                 |                      | (gas: | -11 (-0.000%)) |     |     |
| test_donate_succeedsWithCorrectSelectors() |                 |                      | (gas: | -11 (-0.000%)) |     |     |
| test_donate_failsWithIncorrectSelectors()  |                 |                      | (gas: | -11 (-0.000%)) |     |     |
| test_swap_failsWithIncorrectSelectors()    |                 |                      | (gas: | -11 (-0.000%)) |     |     |
20

| test_removeLiquidity_failsWithIncorrectSelectors() |       |     |            | (gas: | -11 (-0.000%)) |
| -------------------------------------------------- | ----- | --- | ---------- | ----- | -------------- |
| test_addLiquidity_succeedsWithCorrectSelectors()   |       |     |            | (gas: | -11 (-0.000%)) |
| test_addLiquidity_withHooks_gas()                  | (gas: | -11 | (-0.000%)) |       |                |
| test_addLiquidity_failsWithIncorrectSelectors()    |       |     |            | (gas: | -11 (-0.000%)) |
test_removeLiquidity_succeedsWithCorrectSelectors() (gas: -11 (-0.000%))
| test_removeLiquidity_withHooks_gas()              |     | (gas: | -11 (-0.000%)) |            |                |
| ------------------------------------------------- | --- | ----- | -------------- | ---------- | -------------- |
| test_initialize_failsWithIncorrectSelectors()     |     |       | (gas:          | -11        | (-0.000%))     |
| test_initialize_succeedsWithCorrectSelectors()    |     |       | (gas:          | -11        | (-0.000%))     |
| test_initialize_succeedsWithEmptyHooks(uint160)   |     |       |                | (gas:      | -11 (-0.000%)) |
| test_swap_afterSwapFeeOnUnspecified_exactInput()  |     |       |                | (gas:      | -11 (-0.001%)) |
| test_swap_afterSwapFeeOnUnspecified_exactOutput() |     |       |                | (gas:      | -11 (-0.001%)) |
| test_addLiquidity_withFeeTakingHook()             |     | (gas: | -11            | (-0.001%)) |                |
| test_removeLiquidity_withFeeTakingHook()          |     |       | (gas: -11      | (-0.001%)) |                |
test_fuzz_swap_beforeSwap_returnsDeltaSpecified(int128,int256,bool) (gas: -11 (-0.001%))
| test_swap_beforeSwapNoOpsSwap_exactInput()  |     |     | (gas: | -11 (-0.001%)) |            |
| ------------------------------------------- | --- | --- | ----- | -------------- | ---------- |
| test_swap_beforeSwapNoOpsSwap_exactOutput() |     |     | (gas: | -11            | (-0.001%)) |
| test_swap_succeedsWithHooksIfInitialized()  |     |     | (gas: | -11 (-0.001%)) |            |
test_take_failsWithInvalidTokensThatDoNotReturnTrueOnTransfer() (gas: -11 (-0.001%))
test_addLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: -11 (-0.001%))
test_removeLiquidity_succeedsWithHooksIfInitialized(uint160) (gas: -11 (-0.001%))
| test_initialize_succeedsWithHooks(uint160) |       |       | (gas:      | -11 (-0.002%)) |     |
| ------------------------------------------ | ----- | ----- | ---------- | -------------- | --- |
| test_swap_withDynamicFee_gas()             | (gas: | -11   | (-0.003%)) |                |     |
| test_dynamicReturnSwapFee_notStored()      |       | (gas: | -11        | (-0.003%))     |     |
test_dynamicReturnSwapFee_notUsedIfPoolIsStaticFee() (gas: -11 (-0.003%))
| test_afterSwap_skipIfCalledByHook()   |     | (gas: | -824 (-0.003%)) |            |     |
| ------------------------------------- | --- | ----- | --------------- | ---------- | --- |
| test_beforeSwap_skipIfCalledByHook()  |     | (gas: | -824            | (-0.003%)) |     |
| test_afterDonate_skipIfCalledByHook() |     | (gas: | -824            | (-0.003%)) |     |
T
| test_beforeDonate_skipIfCalledByHook() |     | (gas: | -824 | (-0.003%)) |     |
| -------------------------------------- | --- | ----- | ---- | ---------- | --- |
F
| test_afterRemoveLiquidity_skipIfCalledByHook() |     |     | (gas: | -824 | (-0.003%)) |
| ---------------------------------------------- | --- | --- | ----- | ---- | ---------- |
A
| test_afterAddLiquidity_skipIfCalledByHook() |     |     | (gas: | -824 | (-0.003%)) |
| ------------------------------------------- | --- | --- | ----- | ---- | ---------- |
R
| test_beforeAddLiquidity_skipIfCalledByHook() |     |     | (gas: | -824 | (-0.003%)) |
| -------------------------------------------- | --- | --- | ----- | ---- | ---------- |
test_beforeRemoveLiquidity_skipIfCalledByHoDok()
|                                          |     |     |            | (gas:      | -824 (-0.003%)) |
| ---------------------------------------- | --- | --- | ---------- | ---------- | --------------- |
| test_gas_beforeSwap_skipIfCalledByHook() |     |     | (gas: -824 | (-0.003%)) |                 |
test_ffi_addLiqudity_weirdPool_0_returnsCorrectLiquidityDelta() (gas: -11 (-0.003%))
| test_afterInitialize_skipIfCalledByHook()  |     |     | (gas: | -835 (-0.003%)) |            |
| ------------------------------------------ | --- | --- | ----- | --------------- | ---------- |
| test_beforeInitialize_skipIfCalledByHook() |     |     | (gas: | -835            | (-0.003%)) |
test_fuzz_getTickLiquidity((int24,int24,int256,bytes32)) (gas: 9 (0.003%))
| test_settle_withNoStartingBalance()                   |       | (gas: | -11 (-0.003%)) |     |                   |
| ----------------------------------------------------- | ----- | ----- | -------------- | --- | ----------------- |
| test_fuzz_getTickBitmap((int24,int24,int256,bytes32)) |       |       |                |     | (gas: 9 (0.004%)) |
| test_take_failsWithNoLiquidity()                      | (gas: | -811  | (-0.004%))     |     |                   |
test_ffi_addLiqudity_weirdPool_1_returnsCorrectLiquidityDelta() (gas: -11 (-0.004%))
test_shouldSwapEqual(uint24,int24,int24,int24,int256,int256,int128,bool) (gas: 305 (0.006%))
| test_fetchProtocolFee_outOfBounds() |     | (gas: | -11 (-0.006%)) |     |     |
| ----------------------------------- | --- | ----- | -------------- | --- | --- |
| test_fetchProtocolFee_overflowFee() |     | (gas: | -11 (-0.007%)) |     |     |
| test_initialize_succeedsWithHook()  |     | (gas: | -11 (-0.008%)) |     |     |
test_callHook_revertsWithInternalErrorFailedHookCall() (gas: -11 (-0.008%))
| test_nestedInitialize() (gas:                        | -11 (-0.009%)) |       |                |            |              |
| ---------------------------------------------------- | -------------- | ----- | -------------- | ---------- | ------------ |
| test_initialize_forNativeTokens(uint160)             |                |       | (gas: -6       | (-0.010%)) |              |
| test_donate_failsIfNoLiquidity(uint160)              |                | (gas: | -11            | (-0.011%)) |              |
| test_callHook_revertsWithBubbleUp()                  |                | (gas: | -11 (-0.012%)) |            |              |
| test_afterInitialize_invalidReturn()                 |                | (gas: | -11 (-0.013%)) |            |              |
| test_fuzz_getLiquidity((int24,int24,int256,bytes32)) |                |       |                | (gas:      | 33 (0.013%)) |
| test_initialize_fetchFeeWhenController(uint24)       |                |       | (gas:          | -11        | (-0.013%))   |
test_ffi_fuzz_addLiquidity_defaultPool_ReturnsCorrectLiquidityDelta((int24,int24,int256,bytes32)) (gas:
,! 40 (0.015%))
test_updateDynamicLPFee_afterInitialize_initializesFee() (gas: -11 (-0.015%))
test_initialize_succeedsWithOverflowFeeController(uint160) (gas: -11 (-0.016%))
test_initialize_succeedsWithOutOfBoundsFeeController(uint160) (gas: -11 (-0.016%))
| test_initialize_initializesFeeTo0() |     | (gas: | -11 (-0.016%)) |     |     |
| ----------------------------------- | --- | ----- | -------------- | --- | --- |
test_updateDynamicLPFee_revertsIfPoolHasStaticFee() (gas: -11 (-0.016%))
test_updateDynamicLPFee_afterInitialize_failsWithTooLargeFee() (gas: -11 (-0.016%))
test_initialize_succeedsWithMaxTickSpacing(uint160) (gas: -11 (-0.017%))
21

| test_dynamicReturnSwapFee_initializeZeroSwapFee() |     |     |       |     |            |                | (gas: -11 (-0.019%)) |
| ------------------------------------------------- | --- | --- | ----- | --- | ---------- | -------------- | -------------------- |
| test_initialize_gas()                             |     |     | (gas: | -11 | (-0.019%)) |                |                      |
| test_fetchProtocolFee_succeeds()                  |     |     |       |     | (gas:      | -11 (-0.022%)) |                      |
test_fuzz_getPositionInfo((int24,int24,int256,bytes32),uint256,bool) (gas: 151 (0.025%))
test_initialize_revertsWhenPoolAlreadyInitialized(uint160) (gas: -25 (-0.041%))
test_fuzz_getPositionLiquidity((int24,int24,int256,bytes32),(int24,int24,int256,bytes32)) (gas: 285
,! (0.065%))
test_fuzz_ProtocolAndLPFee(uint24,uint16,uint16,int256) (gas: 141 (0.070%))
test_fuzz_getFeeGrowthInside((int24,int24,int256,bytes32),bool) (gas: 476 (0.079%))
test_fuzz_nextInitializedTickWithinOneWord(int24,bool) (gas: -75 (-0.108%))
test_fuzz_swap(uint160,uint24,uint16,uint16,(int24,bool,int256,uintT160,uint24)) (gas: 26 (0.159%))
test_shouldSwapEqualMultipleLP(uint24,int24,(int24,int24,int256)[],int256,int128,bool) (gas: -19223
,! (-0.224%))
| test_fuzz_extsload(uint256,uint256,bytes) |     |     |     |     |     | (gas: 7173 | (0.563%)) |
| ----------------------------------------- | --- | --- | --- | --- | --- | ---------- | --------- |
test_swap_accruesProtocolFees(uint16,uint16,int256) (gas: -11497 (-1.617%))
test_fuzz_getTickLiquidity_two_positions((int24,int24,int256,bytes32),(int24,int24,int256,bytes32))
| ,!  | (gas: | 16970 | (4.059%)) |     |     |     | F   |
| --- | ----- | ----- | --------- | --- | --- | --- | --- |
test_fuzz_collectProtocolFees(address,uint256,uint256) (gas: -11601 (-13.457%))
| Overall  | gas | change:                              | -27267 | (-0.007%) |     |     |     |
| -------- | --- | ------------------------------------ | ------ | --------- | --- | --- | --- |
| Uniswap: |     | DifferentoptimisationappliedinPR825. |        |           |     |     |     |
Spearbit: ThenewapproachalsolooksAcheaper,onestillneedstomeasurebyhowmuch.
5.3.8 Gasoptimizationinclear()function
| Severity: |                      | GasOptimization |     |     |     |     |     |
| --------- | -------------------- | --------------- | --- | --- | --- | --- | --- |
| Context:  | PoolManager.sol#L303 |                 |     |     |     |     |     |
R
Description: Becausetheamountargumenttoclear()isnon-negative,theamountDeltavalueobtainedbysafe-
castingamounttoint128isalsonon-negative,andthusthenegationofamountDeltacannotoverflow. Therefore,
an unchecked block could be used here to reduce gas usage and bytecode size, consistent with what is done in
otherfunctionsliketakeandmint.
Recommendation: Putthelinecontainingthenegationwithinanuncheckedblock:
D
| + unchecked |                         | {   |     |     |                 |              |     |
| ----------- | ----------------------- | --- | --- | --- | --------------- | ------------ | --- |
|             | _accountDelta(currency, |     |     |     | -(amountDelta), | msg.sender); |     |
+ }
| Uniswap:  |     | FixedinPR826. |     |     |     |     |     |
| --------- | --- | ------------- | --- | --- | --- | --- | --- |
| Spearbit: |     | Fixverified.  |     |     |     |     |     |
5.3.9 Non-assemblyversionofstate.ticksetterpossiblymoregasefficient
| Severity: |                    | GasOptimization |     |     |     |     |     |
| --------- | ------------------ | --------------- | --- | --- | --- | --- | --- |
| Context:  | Pool.sol#L415-L422 |                 |     |     |     |     |     |
Description: Thenon-assemblyversionofthesettingofstate.tickseemstobemoreefficientthanthecurrent
implementation.
| unchecked  |             | {               |              |     |                |             |     |
| ---------- | ----------- | --------------- | ------------ | --- | -------------- | ----------- | --- |
| int24      | _zeroForOne |                 | = zeroForOne |     | ? int24(1)     | : int24(0); |     |
| state.tick |             | = step.tickNext |              |     | - _zeroForOne; |             |     |
}
Recommendation: Inadditiontoadoptingtheaboverecommendation,revisitassemblyblocksandre-testtosee
iftheirnon-assemblycounterpartscouldbemoreefficient. Thiscouldpossiblybeduetothenumberofoptimizer
runswiththeIRoptimizer.
22

| Uniswap:  | FixedinPR827. |     |     |
| --------- | ------------- | --- | --- |
| Spearbit: | Fixed.        |     |     |
5.3.10 mulDiv()isredundantforfeegrowthcalculation
| Severity:                                      | GasOptimization |     |     |
| ---------------------------------------------- | --------------- | --- | --- |
| Context: Pool.sol#L391-L393,Pool.sol#L463-L468 |                 |     |     |
Description: In donate(), amount0 and amount1 are safely casted to int128. As such, Full-
T
Math.mulDiv() isn't required because amount * Q128 <= type(int128).max) * Q128 =
0x7fffffffffffffffffffffffffffffff00000000000000000000000000000000 < type(uint256).max,
ie. theintermediatevaluewillnotoverflowuint256.
Thereforethecalculationcouldusenativeoperands,orasimplifiedversionofmulDiv:
function simpleMulDiv(uint256 a, uint256 b, uint256 dFenominator) internal pure returns (uint256 result)
,! {
| assembly | ("memory-safe") | {                |     |
| -------- | --------------- | ---------------- | --- |
| result   | := div(mul(a,   | b), denominator) |     |
}
}
A
Under the assumption that supported tokens can have a maximum supply of type(uint128).max, the same can
beappliedinswap()whenincrementingfeegrowthglobal.
Recommendation: Replace FullMath.mulDiv() with a simplified and more gas efficient version for the refer-
encedlines.
| Uniswap:  | FixedinPRR844. |     |     |
| --------- | -------------- | --- | --- |
| Spearbit: | Fixed.         |     |     |
5.3.11 MoreefficientmaskderivationinTickBitmap
| Severity: | GasOptimization |     |     |
| --------- | --------------- | --- | --- |
D
| Context: TickBitmap.sol#L96-L97 |     |     |     |
| ------------------------------- | --- | --- | --- |
Description: ThemaskderivationhasbeenmodifiedfromUniswapV3tobeslightlymoreefficient:
// UniV3
| - uint256 | mask = (1 <<    | bitPos) - 1 + | (1 << bitPos); |
| --------- | --------------- | ------------- | -------------- |
| // = 2    | * (1 << bitPos) | - 1           |                |
| // = (1   | << bitPos +     | 1) - 1        |                |
// = UniV4
| + uint256 | mask = (1 << | (uint256(bitPos) | + 1)) - 1; |
| --------- | ------------ | ---------------- | ---------- |
Thiscanbefurtheroptimisedtouint256 mask = type(uint256).max >> (uint256(type(uint8).max) - bit-
Pos);,whichis1operandless. Essentially,it'sdoingSHRofthefullmaskby255 - bitPosbits.
Recommendation:
| - uint256 | mask = (1 << | (uint256(bitPos) | + 1)) - 1; |
| --------- | ------------ | ---------------- | ---------- |
+ uint256 mask = type(uint256).max >> (uint256(type(uint8).max) - bitPos);
| Uniswap:  | FixedinPR828. |     |     |
| --------- | ------------- | --- | --- |
| Spearbit: | Fixed.        |     |     |
23

5.3.12 BitMath
| Severity: GasOptimization                |     |     |     |     |
| ---------------------------------------- | --- | --- | --- | --- |
| Context: BitMath.sol#L16,BitMath.sol#L23 |     |     |     |     |
Description:
1. mostSignificantBitcanbeslightlyoptimisedsincewerequirethatx 0andsoshl(8, iszero(x))would
>
justbe0.
2. The constant 0x0706060506020504060203020504030106050205030304010505030400000000 which is used
asalookupbitmapisslightlydifferentfromhowonewouldconstructit. Theassumesthatthefollowingcan
includevalues7and14whichisnottrue:
A = 0x8421084210842108cc6318c6db6d54be
| B = and(0x1f, | shr(shr(r, | x), A)) |     |     |
| ------------- | ---------- | ------- | --- | --- |
Intheabovesnippetshr(r, x)wouldhaveatmost8bitsandthusshifting0x8421084210842108cc6318c6db6d54be
to the right by the shr(r, x) amount and then masking by 0x1f which picks the least 5 bits of the shifted value
givesusthefollowingtable:
mostsignificantbitofshr(r, x) possiblevaluesofBinbinary binaryportionofAwhichisrelevantincalculatingBsomeportionsofthebinaryfromrowsabovewillbeusedwhencalculatingB
| 0b 111 |     | 00000 |     | 00..00 |
| ------ | --- | ----- | --- | ------ |
0b 110 00001, 00010, 00100, 01000, 10000 1000010000100001000010000100001000010000100001000010000100001000
0b 101 00110, 00011, 10001, T 11000, 01100, 10011, 11001 11001100011000110001100011000110
F
| 0b 100 |     | 01101, 10110, | A11011 | 1101101101101101 |
| ------ | --- | ------------- | ------ | ---------------- |
01010R,
| 0b 011 |     | 10100, | 10101, 11010 | 01010100 |
| ------ | --- | ------ | ------------ | -------- |
D
| 0b 010 |     | 01011, 00101, | 10010, 01001 | 1011 |
| ------ | --- | ------------- | ------------ | ---- |
| 0b 001 |     | 01111, 10111  |              | 11   |
| 0b 000 |     | 11111         |              | 1    |
| 0b .   |     | 11110         |              | 0    |
Note: In the above table the symbol 0b . represents the case/state that the code never ends up at
butitisincludedforthesakeofcompleteness. Thisiswhenshr(r, x) == 0akawhenx == 0butwe
neverendupatthiscasesincewehavetherequire(x > 0)statement.
And so the set of possible values of B does not include 7 (00111) or 14 (01110). And so the 7th or 14th byte of
0x0706060506020504060203020504030106050205030304010505030400000000isneverqueried:
C = 0x0706060506020504060203020504030106050205030304010505030400000000
| byte(B, C) |     |     |     |     |
| ---------- | --- | --- | --- | --- |
Andthatiswhythe7thand14thbytesofCcanbeanyvalueanditwouldbebesttojustsetthemas00.
24

"""
| suggested | value |     |     |     |     |     |     |
| --------- | ----- | --- | --- | --- | --- | --- | --- |
0x07060605060205_00_060203020504_00_0106050205030304010505030400000000
00000111 00000110 00000110 00000101 00000110 00000010 00000101 [00000000]
00000110 00000010 00000011 00000010 00000101 00000100 [00000000] 00000001
00000110 00000101 00000010 00000101 00000011 00000011 00000100 00000001
00000101 00000101 00000011 00000100 00000000 00000000 00000000 00000000
current value
0x07060605060205_04_060203020504_03_0106050205030304010505030400000000
00000111 00000110 00000110 00000101 00000110 00000010 00000101 [00000100]
00000110 00000010 00000011 00000010 00000101 00000100 [00000011] 00000001
00000110 00000101 00000010 00000101 00000011 00000011 00000100 00000001
00000101 00000101 00000011 00000100 00000000 00000000 00000000 00000000
"""
Proofofconcept: SeethefollowingPythoncodetoverifyandconstructdifferentconstants:
import re
| MAX_RANGE | =   | 1 << 256 |     |     |     |     |     |
| --------- | --- | -------- | --- | --- | --- | --- | --- |
### LSB
| print("\n--- |     | LSB ---\n") |     |     |     |     |     |
| ------------ | --- | ----------- | --- | --- | --- | --- | --- |
m = 0xb6db6db6ddddddddd34d34d349249249210842108c6318c639ce739cffffffff
T
F
"""
| 1000 | 0000 | 0100 | 0000 | 0100 0000 | 0101 | 0101 A |     |
| ---- | ---- | ---- | ---- | --------- | ---- | ------ | --- |
R
| 0100 | 0011 | 0000 | 0000 | 0101 0010 | 0110 | 0110 |     |
| ---- | ---- | ---- | ---- | --------- | ---- | ---- | --- |
0000D
| 0100 | 0100 | 0011 | 0010 | 0000 0000 | 0000 |      |     |
| ---- | ---- | ---- | ---- | --------- | ---- | ---- | --- |
| 0101 | 0000 | 0010 | 0000 | 0110 0001 | 0000 | 0110 |     |
| 0111 | 0100 | 0000 | 0101 | 0011 0000 | 0010 | 0110 |     |
| 0000 | 0010 | 0000 | 0000 | 0000 0000 | 0001 | 0000 |     |
| 0111 | 0101 | 0000 | 0110 | 0010 0000 | 0000 | 0001 |     |
| 0111 | 0110 | 0001 | 0001 | 0111 0000 | 0111 | 0111 |     |
"""
L = 0x8040405543005266443200005020610674053026020000107506200176117077
| patterns | = [set()       |         | for _ | in range(8)] |     |     |     |
| -------- | -------------- | ------- | ----- | ------------ | --- | --- | --- |
| for i    | in range(256): |         |       |              |     |     |     |
| block    | =              | i // 32 |       |              |     |     |     |
| pattern  |                | = ((m   | << i) | % MAX_RANGE) | >>  | 250 |     |
patterns[block].add(pattern)
| for i | in range(8): |         |     |     |            |         |                        |
| ----- | ------------ | ------- | --- | --- | ---------- | ------- | ---------------------- |
|       | ’            |         |     | ’   | ’ ’        | ’ ’     |                        |
| s     | = f block    | {i:03b} |     | : + | , .join([f | {p:06b} | for p in patterns[i]]) |
print(s)
| for i | in range(8): |           |     |     |     |     |     |
| ----- | ------------ | --------- | --- | --- | --- | --- | --- |
| for   | j in         | range(8): |     |     |     |     |     |
|       | if i         | == j:     |     |     |     |     |     |
continue
|       | intersection         |         | = patterns[i].intersection(patterns[j]) |     |             |                |     |
| ----- | -------------------- | ------- | --------------------------------------- | --- | ----------- | -------------- | --- |
|       | if len(intersection) |         |                                         | !=  | 0:          |                |     |
|       |                      |         | ’                                       |     |             |                | ’   |
|       |                      | print(f | collision                               |     | ({i}, {j}): | {intersection} | )   |
| for i | in range(8):         |         |                                         |     |             |                |     |
25

|           | for p in       | patterns[i]:  |           |                  |                 |           |
| --------- | -------------- | ------------- | --------- | ---------------- | --------------- | --------- |
|           | b =            | ((L <<        | (p <<     | 2)) % MAX_RANGE) | >> 252          |           |
|           | if             | b != i:       |           |                  |                 |           |
|           |                | print(f"error |           | on block         | {i} and pattern | {p:06b}") |
| # make    | sure           | L is          | computed  | correctly.       |                 |           |
| h =       | 1 << 255       |               |           |                  |                 |           |
| for       | i in range(8): |               |           |                  |                 |           |
|           | for p in       | patterns[i]:  |           |                  |                 |           |
|           | if             | p == 0:       |           |                  |                 |           |
|           |                |               | ’         |                  | ’               |           |
|           |                | print(        | 0 pattern | detected         | )               |           |
|           | h |=           | i <<          | ((256     | - 4) - (p        | << 2))          |           |
| print(f"h | ==             | L: {h         | == L}")   |                  |                 |           |
# 11010111011001000101001111100000
m2 = 0xd76453e0
| pattern2 | =   | []  |     |     |     |     |
| -------- | --- | --- | --- | --- | --- | --- |
L2 = 0x001f0d1e100c1d070f090b19131c1706010e11080a1a141802121b1503160405
h2 = 0
| # make | sure          | L2 is | computed | correctly. |     |     |
| ------ | ------------- | ----- | -------- | ---------- | --- | --- |
| for    | i in range(0, |       | 32):     |            |     |     |
|        | p = (m2       | >> i) | & 31     |            |     |     |
pattern2.append(p)
|     | h2 |= i | << ((256 | -   | 8) - (p << | 3)) |     |
| --- | ------- | -------- | --- | ---------- | --- | --- |
T
print(pattern2)
F
| print(f"h2 |     | == L2: | {h2 == | L2}") |     |     |
| ---------- | --- | ------ | ------ | ----- | --- | --- |
A
R
### MSB
D
| print("\n--- |     | MSB | ---\n") |     |     |     |
| ------------ | --- | --- | ------- | --- | --- | --- |
"""
| 7 - | 00..00 | - 00000 |     |     |     |     |
| --- | ------ | ------- | --- | --- | --- | --- |
6 - 1000010000100001000010000100001000010000100001000010000100001000 - 00001, 00010, 00100, 01000, 10000
5 - 11001100011000110001100011000110 - 00110, 00011, 10001, 11000, 01100, 10011, 11001
| 4 - | 1101101101101101 |          | -      | 01101, 10110, | 11011, |     |
| --- | ---------------- | -------- | ------ | ------------- | ------ | --- |
| 3 - | 01010100         | - 10100, | 01010, | 10101,        | 11010  |     |
| 2 - | 1011 -           | 01011,   | 00101, | 10010, 01001  |        |     |
| 1 - | 11 - 01111,      | 10111    |        |               |        |     |
0 - 1 - 11111
. - 0 - 11110
"""
m3 = 0x8421084210842108cc6318c6db6d54be
"""
7 - 0 /
| 6 - | 1, 2,   | 4,      | 8, 16 | /        |         |     |
| --- | ------- | ------- | ----- | -------- | ------- | --- |
| 5 - | 3, 6,   | 12, 17, | 19,   | 24, 25 / |         |     |
| 4 - | 7, 13,  | 22, 27  |       |          | ?? ( 7) |     |
| 3 - | 10, 14, | 20, 21, | 26    |          | ?? (14) |     |
| 2 - | 5, 9,   | 11, 18  | /     |          |         |     |
| 1 - | 15, 23  | /       |       |          |         |     |
| 0 - | 28, 29, | 30, 31  |       |          |         |     |
. - ??
"""
L3 = 0x0706060506020504060203020504030106050205030304010505030400000000
| ranges3 | = [[0]] |     |     |     |     |     |
| ------- | ------- | --- | --- | --- | --- | --- |
ranges3.extend([[i + (1 << j) for i in range(1 << j)] for j in range(8)])
26

| patterns3 | =                                                    | [set()      | for _ in | range(len(ranges3))] |     |     |             |
| --------- | ---------------------------------------------------- | ----------- | -------- | -------------------- | --- | --- | ----------- |
| for       | i in range(len(ranges3)):                            |             |          |                      |     |     |             |
|           | for j in                                             | ranges3[i]: |          |                      |     |     |             |
|           | patterns3[i].add((0x8421084210842108cc6318c6db6d54be |             |          |                      |     |     | >> j) & 31) |
print(patterns3)
| for | i in range(8): |         |                 |           |                 |               |      |
| --- | -------------- | ------- | --------------- | --------- | --------------- | ------------- | ---- |
|     | for pattern    | in      | patterns3[i+1]: |           |                 |               |      |
|     | j =            | 0b11111 | & (L3           | >> ((256  | - 8) - (pattern | <<            | 3))) |
|     | if i           | != j:   |                 |           |                 |               |      |
|     |                |         | ’               |           |                 |               | ’    |
|     |                | print(f | (i, j,          | pattern): | {i}, {j},       | {pattern:05b} | )    |
h3 = 0
| for        | i in range(8): |         |                   |           |                 |               |      |
| ---------- | -------------- | ------- | ----------------- | --------- | --------------- | ------------- | ---- |
|            | for pattern    | in      | patterns3[i+1]:   |           |                 |               |      |
|            | h3 |=          | i <<    | ((256 -           | 8) -      | (pattern << 3)) |               |      |
| for        | i in range(8): |         |                   |           |                 |               |      |
|            | for pattern    | in      | patterns3[i+1]:   |           |                 |               |      |
|            | j =            | 0b11111 | & (h3             | >> ((256  | - 8) - (pattern | <<            | 3))) |
|            | if i           | != j:   |                   |           |                 |               |      |
|            |                |         | ’                 |           |                 |               | ’    |
|            |                | print(f | (i, j,            | pattern): | {i}, {j},       | {pattern:05b} | )    |
|            |                | ’       | ’                 |           | ’ ’ ’           | T’            |      |
| print("h3: | "              | +       | .join(re.findall( |           | .{8} , f        | {h3:0256b}    | )))  |
|            |                | ’       | ’                 |           | ’ ’ ’           | F’            |      |
| print("L3: | "              | +       | .join(re.findall( |           | .{8} , f        | {L3:0256b}    | )))  |
A
| print("h3: | "   | + hex(h3)) |     |     |     |     |     |
| ---------- | --- | ---------- | --- | --- | --- | --- | --- |
R
D
| print(f"h3 | ==  | L3: | {h3 == L3}") |     |     |     |     |
| ---------- | --- | --- | ------------ | --- | --- | --- | --- |
"""
| suggested | value |     |     |     |     |     |     |
| --------- | ----- | --- | --- | --- | --- | --- | --- |
0x706060506020500060203020504000106050205030304010505030400000000
00000111 00000110 00000110 00000101 00000110 00000010 00000101 [00000000]
00000110 00000010 00000011 00000010 00000101 00000100 [00000000] 00000001
00000110 00000101 00000010 00000101 00000011 00000011 00000100 00000001
00000101 00000101 00000011 00000100 00000000 00000000 00000000 00000000
current value
0x0706060506020504060203020504030106050205030304010505030400000000
00000111 00000110 00000110 00000101 00000110 00000010 00000101 [00000100]
00000110 00000010 00000011 00000010 00000101 00000100 [00000011] 00000001
00000110 00000101 00000010 00000101 00000011 00000011 00000100 00000001
00000101 00000101 00000011 00000100 00000000 00000000 00000000 00000000
"""
| Recommendation: |     |     | Applythefollowingchanges: |     |     |     |     |
| --------------- | --- | --- | ------------------------- | --- | --- | --- | --- |
27

| diff --git               | a/src/libraries/BitMath.sol |        | b/src/libraries/BitMath.sol |     |
| ------------------------ | --------------------------- | ------ | --------------------------- | --- |
| index 500d6f7e..6e4e8c7a |                             | 100644 |                             |     |
--- a/src/libraries/BitMath.sol
+++ b/src/libraries/BitMath.sol
| @@ -13,14 | +13,14 @@                | library BitMath | {   |     |
| --------- | ------------------------ | --------------- | --- | --- |
|           | require(x >              | 0);             |     |     |
|           | assembly ("memory-safe") | {               |     |     |
- r := or(shl(8, iszero(x)), shl(7, lt(0xffffffffffffffffffffffffffffffff, x)))
| +   | r := shl(7,  | lt(0xffffffffffffffffffffffffffffffff, |              | x))T         |
| --- | ------------ | -------------------------------------- | ------------ | ------------ |
|     | r := or(r,   | shl(6, lt(0xffffffffffffffff,          |              | shr(r, x)))) |
|     | r := or(r,   | shl(5, lt(0xffffffff,                  | shr(r,       | x))))        |
|     | r := or(r,   | shl(4, lt(0xffff,                      | shr(r, x)))) |              |
|     | r := or(r,   | shl(3, lt(0xff,                        | shr(r, x)))) |              |
|     | // forgefmt: | disable-next-item                      |              |              |
r := or(r, byte(and(0x1f, shr(shr(r, x),F0x8421084210842108cc6318c6db6d54be)),
- 0x0706060506020504060203020504030106050205030304010505030400000000))
+ 0x0706060506020500060203020504000106050205030304010505030400000000))
}
}
| Uniswap:  | FixedinPR822. |     | A   |     |
| --------- | ------------- | --- | --- | --- |
| Spearbit: | Verified.     |     |     |     |
5.4 Informational
5.4.1 SomecontractRsdon'tfollowUniswap'sversionconvention
| Severity: | Informational                                |     |     |     |
| --------- | -------------------------------------------- | --- | --- | --- |
| Context:  | CurrencyReserves.sol#L2,IProtocolFees.sol#L2 |     |     |     |
Description: TheSoliditypragmastatementsinvariouscontractswithinthev4-peripheryrepositorydonotadhere
toUniswap'sstatedrulesforversionspecification:
D
Uniswap'sstatedrules:
1. Contractstobedeployedshouldhaveafixedcompilerversionforsafety(0.8.26).
2. Open-sourcelibrarieswithouttransientstorageshoulduse(cid:2)0.8.0.
3. Open-sourcelibrarieswithtransientstorageshoulduse(cid:2)0.8.24.
Currentpragmastatementsthatdon'tfollowthis:
| • (cid:2)0.8.20: | CurrencyReserves. |     |     |     |
| ---------------- | ----------------- | --- | --- | --- |
| • (cid:2)0.8.19: | IProtocolFees.    |     |     |     |
Recommendation: Standardize the version in order to align the codebase with Uniswap's stated best practices,
lockingthepragmaversionwhereposibleorsettingthecorrectrangewhereneeded.
| Uniswap: | FixedinPR858. |     |     |     |
| -------- | ------------- | --- | --- | --- |
28

5.4.2 computeSwapStepcanbesimplifiedforexactInswapswhenamountInisgreaterthanamountRemain-
ingLessFee
| Severity: | Informational        |     |     |
| --------- | -------------------- | --- | --- |
| Context:  | SwapMath.sol#L74-L81 |     |     |
Description: In the above context we are in the case of exactIn swaps when amountIn is greater than amoun-
tRemainingLessFee:
| sqrtPriceNextX96 | = SqrtPriceMath.getNextSqrtPriceFromInput( |     |     |
| ---------------- | ------------------------------------------ | --- | --- |
sqrtPriceCurrentX96, liquidity, amountRemainingLessFee, zeroForTOne
);
| amountIn | = zeroForOne |     |     |
| -------- | ------------ | --- | --- |
? SqrtPriceMath.getAmount0Delta(sqrtPriceNextX96, sqrtPriceCurrentX96, liquidity, true)
: SqrtPriceMath.getAmount1Delta(sqrtPriceCurrentX96, sqrtPriceNextX96, liquidity, true);
’
// we didn t reach the target, so take the remainder of the maximum input as fee
| feeAmount | = uint256(-amountRemaining) | - amountIn; | F   |
| --------- | --------------------------- | ----------- | --- |
Notations:
parameter description
A
pp sqrtPriceCurrentX96
c
pp t sqrtPriceTargetX96
pp sqrtPriceNextX96
n
a amountIn
i
R
a amountOut
o
a amountRemainingLessFee
w
a r amountRemaining
a feeAmount
f
DL
liquidity
f feePips
| 1. Case0 | 1swaps |     |     |
| -------- | ------ | --- | --- |
!
L
|     |     | pp n | =   |
| --- | --- | ---- | --- |
L a
w
+
pp 296
c
L L
a =296
i
pp (cid:0) pp
n c
=a
w
| 2. Case1 | 0swaps |     |     |
| -------- | ------ | --- | --- |
!
296a
|     |     | pp =pp | + w |
| --- | --- | ------ | --- |
|     |     | n      | c   |
L
|     |     | pp  | pp L |
| --- | --- | --- | ---- |
n c
|     |     | a i = | (cid:0) =a w |
| --- | --- | ----- | ------------ |
296
|     |     | (cid:0) | (cid:1) |
| --- | --- | ------- | ------- |
29

so in both directions in this inner else block one could have just set amountIn as amountRemainingLessFee and
thefeeAmountendsupbeing:
f a r
|     |     |     |     | a = | (cid:1) |     |
| --- | --- | --- | --- | --- | ------- | --- |
f 106
or in other words amountIn gets capped by amountRemainingLessFee. Doing so, make the code more unified
whencomparedtotheimplementationintheouterelseblockbelowwhereexactIn == false.
| Recommendation: |     | Thefollowingmodificationcanbeapplied: |     |     |     |     |
| --------------- | --- | ------------------------------------- | --- | --- | --- | --- |
T
| diff --git               | a/src/libraries/SwapMath.sol |     |        | b/src/libraries/SwapMath.sol |     |     |
| ------------------------ | ---------------------------- | --- | ------ | ---------------------------- | --- | --- |
| index e0f4b264..59232535 |                              |     | 100644 |                              |     |     |
--- a/src/libraries/SwapMath.sol
+++ b/src/libraries/SwapMath.sol
| @@ -71,12 | +71,10 | @@ library | SwapMath | {   |     |     |
| --------- | ------ | ---------- | -------- | --- | --- | --- |
F
? amountIn
: FullMath.mulDivRoundingUp(amountIn, _feePips, MAX_FEE_PIPS - _feePips);
|     |     | } else           | {                         |                                            |                         |            |
| --- | --- | ---------------- | ------------------------- | ------------------------------------------ | ----------------------- | ---------- |
| +   |     | amountIn         | = amountRemainingLessFee; |                                            |                         |            |
|     |     | sqrtPriceNextX96 |                           | = SqrtPriceMath.getNextSqrtPriceFromInput( |                         |            |
|     |     |                  | sqrtPriceCurrentX96,      | liquidity,                                 | amountRemainingLessFee, | zeroForOne |
A
);
| -   |     | amountIn | = zeroForOne |     |     |     |
| --- | --- | -------- | ------------ | --- | --- | --- |
- ? SqrtPriceMath.getAmount0Delta(sqrtPriceNextX96, sqrtPriceCurrentX96,
| ,! liquidity, | true) |     |     |     |     |     |
| ------------- | ----- | --- | --- | --- | --- | --- |
- : SqrtPriceMath.getAmount1Delta(sqrtPriceCurrentX96, sqrtPriceNextX96,
| ,! liquidity, | true); |     |     |     |     |     |
| ------------- | ------ | --- | --- | --- | --- | --- |
’
// we didn t reach the target, so take the remainder of the maximum input as fee
R
|     |     | feeAmount | = uint256(-amountRemaining) |     | - amountIn; |     |
| --- | --- | --------- | --------------------------- | --- | ----------- | --- |
}
| Uniswap:  | FixedinPR718. |     |     |     |     |     |
| --------- | ------------- | --- | --- | --- | --- | --- |
| Spearbit: | Verified.     |     |     |     |     |     |
D
5.4.3 AddcommentsregardingthederivationofSQRT_PRICE_A_Bconstant
| Severity: | Informational        |     |     |     |     |     |
| --------- | -------------------- | --- | --- | --- | --- | --- |
| Context:  | Constants.sol#L5-L10 |     |     |     |     |     |
Description: TheconstantsSQRT_PRICE_A_Binthiscontextarecalculatedas:
A
296
|     |     |     |     | 6sB(cid:1) | 7   |     |
| --- | --- | --- | --- | ---------- | --- | --- |
|     |     |     |     | 6          | 7   |     |
|     |     |     |     | 6          | 7   |     |
|     |     |     |     | 4          | 5   |     |
WhereAandB arereserveamountsinthepairofcurrenciesinvolvedinthepool.
Recommendation: Add comments regarding the derivation of SQRT_PRICE_A_B constant. And make sure the
named constant are imported from this utility/library instead of declaring them within each test file such as Tick-
MathTestTest.
| Uniswap:  | FixedinPR859. |     |     |     |     |     |
| --------- | ------------- | --- | --- | --- | --- | --- |
| Spearbit: | Verified.     |     |     |     |     |     |
30

5.4.4 amountInisalways0inaninnerbranchofcomputeSwapStep
| Severity:    | Informational                  |     |     |     |     |
| ------------ | ------------------------------ | --- | --- | --- | --- |
| Context:     | SwapMath.sol#L71               |     |     |     |     |
| Description: | Intheabovecontextwehave:       |     |     |     |     |
| if (exactIn) | {                              |     |     |     |     |
|              | uint256 amountRemainingLessFee |     | =   |     |     |
FullMath.mulDiv(uint256(-amountRemaining), MAX_FEE_PIPS - _feePips, MAX_FEE_PIPS);
|     | amountIn = zeroForOne |     |     |     |     |
| --- | --------------------- | --- | --- | --- | --- |
T
? SqrtPriceMath.getAmount0Delta(sqrtPriceTargetX96, sqrtPriceCurrentX96, liquidity, true)
: SqrtPriceMath.getAmount1Delta(sqrtPriceCurrentX96, sqrtPriceTargetX96, liquidity, true);
|     | if (amountRemainingLessFee |            | >= amountIn)    | {   |     |
| --- | -------------------------- | ---------- | --------------- | --- | --- |
|     | // ...                     |            |                 |     |     |
|     | feeAmount                  | = _feePips | == MAX_FEE_PIPS |     |     |
|     | ? amountIn                 | // <<<     |                 |     | F   |
// ...
If _feePips == MAX_FEE_PIPS then amountRemainingLessFee == 0 which in the above second if branch forces
amountIntobe0:
| 0 =             | amountRemainingLessFee |                    | >= amountIn A |     |     |
| --------------- | ---------------------- | ------------------ | ------------- | --- | --- |
| Recommendation: |                        | Ifwerewritethisas: |               |     |     |
| feeAmount       | = _feePips             | == MAX_FEE_PIPS    |               |     |     |
? 0
: FullMath.mulDivRoundingUp(amountIn, _feePips, MAX_FEE_PIPS - _feePips);
R
accordingtotheforgetestcaseitwouldcostmoregas:
| forge | snapshot --diff |     |     |     |     |
| ----- | --------------- | --- | --- | --- | --- |
test_shouldSwapEqual(uint24,int24,int24,int24,int256,int256,int128,bool) (gas: -20 (-0.000%))
| test_swap_100PercentFee_AmountIn_WithProtocol()  |     |     |     | (gas: | -1 (-0.001%)) |
| ------------------------------------------------ | --- | --- | --- | ----- | ------------- |
| test_Dswap_100PercentLPFee_AmountIn_NoProtocol() |     |     |     | (gas: | -1 (-0.001%)) |
test_ffi_fuzz_addLiquidity_defaultPool_ReturnsCorrectLiquidityDelta((int24,int24,int256,bytes32)) (gas:
,! -2 (-0.001%))
test_fuzz_getTickLiquidity((int24,int24,int256,bytes32)) (gas: -2 (-0.001%))
test_fuzz_getTickBitmap((int24,int24,int256,bytes32)) (gas: -2 (-0.001%))
test_fuzz_getPositionLiquidity((int24,int24,int256,bytes32),(int24,int24,int256,bytes32)) (gas: -16
(-0.004%))
,!
test_fuzz_getPositionInfo((int24,int24,int256,bytes32),uint256,bool) (gas: 27 (0.005%))
test_fuzz_getFeeGrowthInside((int24,int24,int256,bytes32),bool) (gas: 40 (0.007%))
test_fuzz_getTickLiquidity_two_positions((int24,int24,int256,bytes32),(int24,int24,int256,bytes32))
| ,!  | (gas: -29 (-0.007%)) |     |     |     |     |
| --- | -------------------- | --- | --- | --- | --- |
test_fuzz_nextInitializedTickWithinOneWord(int24,bool) (gas: -75 (-0.108%))
test_fuzz_swap(uint160,uint24,uint16,uint16,(int24,bool,int256,uint160,uint24)) (gas: 26 (0.159%))
| test_fuzz_extsload(uint256,uint256,bytes) |             |               |     | (gas: 7173 | (0.563%)) |
| ----------------------------------------- | ----------- | ------------- | --- | ---------- | --------- |
| Overall                                   | gas change: | 7118 (0.002%) |     |            |           |
It might still be useful to leave a comment that at this specific edge case amountIn and thus feeAmount would be
0. Andiftherearenotestcasespresentforthisedgecasetoalsoaddsometestsforit.
| Uniswap:  | CommentsaddedinPR857. |     |     |     |     |
| --------- | --------------------- | --- | --- | --- | --- |
| Spearbit: | Verified.             |     |     |     |     |
31

5.4.5 Unusedcodeshouldberemoved
Severity: Informational
Context: StateLibrary.sol#L15-L16
Description: Unused code should be removed, this would help decreasing cognitive load and make easier the
read,additionallyreducingalittlethecontractcodesize. Someinstances:
• FEE_GROWTH_GLOBAL1_OFFSET is not used neither at v4-core, v4-periphery, or universal router codebases.
However,itprovidesusefulinformationaboutthestoragelayout.
T
Recommendation: Considercommentingthestoragelayoutandremovingunusedvariables
Uniswap: ThelinecorrespondingtotheaboveconstanthasbeencommentedoutinthelibraryinPR857.
Spearbit: Verified.
F
5.4.6 Unnecessaryuncheckedblocks
Severity: Informational
Context: UnsafeMath.sol#L13-L19
Description: divRoundingUp in UnsafeMath is wrapped in an unchecked block. However, this block is unneces-
A
sary because the function uses inline assembly for its calculations. The unchecked keyword in Solidity is used to
disable overflow and underflow checks for arithmetic operations, but it has no effect on assembly code, which is
inherentlyunchecked.
Recommendation: Remove the unchecked block as it serves no purpose in this context. The function can be
simplifiedto:
R
function divRoundingUp(uint256 x, uint256 y) internal pure returns (uint256 z) {
assembly ("memory-safe") {
z := add(div(x, y), gt(mod(x, y), 0))
}
}
Uniswap: FixedinPR857.
D
Spearbit: Verified.
5.4.7 ConfusingerrormessageinERC6909.transferFrom()
Severity: Informational
Context: ERC6909.sol#L38
Description: When the allowance is lower than the transferred amount, ERC6909.transferFrom() returns a low
level"arithmeticunderfloworoverflow"error:
uint256 allowed = allowance[sender][msg.sender][id];
if (allowed != type(uint256).max) allowance[sender][msg.sender][id] = allowed - amount;
Theerrorcanbeconfusingforusersbecauseitdoesn'texplicitlysaysthattheallowanceistoolow.
Recommendation: Considerreturningameaningfulerror. Forexample,seethisERC6909implementationorthe
OpenZeppelin'sERC20implementation.
Uniswap: Added a custom revert for InsufficientAllowance and InsufficientBalance in PR 833. Currently,
it'scausingustoexceedcontractbytecodesizelimits. Wemayelecttonotdocustomreverts.
32

5.4.8 getSqrtPriceAtTickassumesthattheallowedtickrangeiscenteredat0
Severity: Informational
Context: TickMath.sol#L67
Description: getSqrtPriceAtTickassumesthattheallowedtickrangeiscenteredat0,ieMAX_TICK == -MIN_-
TICKduetothefollowingboundcheck:
if (absTick > uint256(int256(MAX_TICK))) InvalidTick.selector.revertWith(tick);
Recommendation: Perhaps this needs to be documented/highlightedTin case the codebase is changed in the
futurewheretheinvariantMAX_TICK == -MIN_TICKisnotsatisfiedanymore.
Uniswap: CommentshavebeenaddedinPR851.
Spearbit: Verified.
F
5.4.9 Thecurrentornexttickisnotalwaysonthetickspacinggridorwithintheallowedrange
Severity: Informational
Context: Pool.sol#L343-L349,Pool.sol#L421,Pool.sol#L425
Description/Recommendation: A
(cid:3) Pool.sol#L343-L349: clipping step.tickNext to the TickMath.MIN_TICK and TickMath.MAX_TICK range
breakstheassumptionsthatstep.tickNextisalwaysonthetickSpacinggrid.
Thefollowingisnotalwaystruewhenclipped:
R
(cid:1)i i
next
j
Fortheseoutofboundstep.tickNext,step.initializedshouldbe(is)false.
(cid:3) Pool.sol#L421: Doingthefollowingcanpushthestate.tickoutoftheminimumboundTickMath.MIN_TICK
when_zeroForOneis1:
Dstate.tick = step.tickNext - _zeroForOne
(cid:3) Pool.sol#L421,Pool.sol#L425: inthiscontextwhenthetickisdecrementedorrecalculatedfromtheprice:
state.tick = step.tickNext - _zeroForOne;
state.tick = TickMath.getTickAtSqrtPrice(state.sqrtPriceX96);
andlaterwhenoneupdatesthestoragetheself.slot0.tick()willnotnecessarilybeonthetickSpacing
gridorjustoffby1fromit.
Uniswap: AddressedinPR852.
33

5.4.10 uncheckedblocks
Severity: Informational
Context: Pool.sol#L369-L372,Pool.sol#L381-L382,Pool.sol#L384,Pool.sol#L408
Description/Recommendation:
(cid:3) Pool.sol#L369-L372: It is true that it is safe. But had to double check for this branch in
SwapMath.computeSwapStepduetodifferentroundingdirectionfortheinequalities:
| if (exactIn) | {   |     |     |     |     |
| ------------ | --- | --- | --- | --- | --- |
T
| uint256 | amountRemainingLessFee |     | =   |     |     |
| ------- | ---------------------- | --- | --- | --- | --- |
FullMath.mulDiv(uint256(-amountRemaining), MAX_FEE_PIPS - _feePips, MAX_FEE_PIPS);
| amountIn | = zeroForOne |     |     |     |     |
| -------- | ------------ | --- | --- | --- | --- |
? SqrtPriceMath.getAmount0Delta(sqrtPriceTargetX96, sqrtPriceCurrentX96, liquidity, true)
: SqrtPriceMath.getAmount1Delta(sqrtPriceCurrentX96, sqrtPriceTargetX96, liquidity,
,! true);
F
| if (amountRemainingLessFee |            |            | >= amountIn)        | {     |     |
| -------------------------- | ---------- | ---------- | ------------------- | ----- | --- |
|                            | ‘          | ‘          |                     |       |     |
| //                         | amountIn   | is capped  | by the target       | price |     |
| sqrtPriceNextX96           |            | =          | sqrtPriceTargetX96; |       |     |
| feeAmount                  |            | = _feePips | == MAX_FEE_PIPS     |       |     |
|                            | ? amountIn |            |                     |       |     |
: FullMath.mulDivRoundingUp(amountIn, _feePips, MAX_FEE_PIPS - _feePips);
A
| forthenotationsseethisdiscussionandf |     |     |     | =f(feePips): |     |
| ------------------------------------ | --- | --- | --- | ------------ | --- |
swap
| inthesecondifbranchweknowamountRemainingLessFee |     |     |     | >=        | amountIn: |
| ----------------------------------------------- | --- | --- | --- | --------- | --------- |
|                                                 |     |     | (   | a ) 106 f |           |
r swap
|     | Ra  |     | =   | (cid:0) (cid:0)      | a   |
| --- | --- | --- | --- | -------------------- | --- |
|     |     |     | w   | 106 (cid:1)%(cid:21) | i   |
|     |     |     | $   | (cid:0)              |     |
wherea is:
f
a f
i swap
|     |     |     | a   | f = (cid:1) |     |
| --- | --- | --- | --- | ----------- | --- |
| D   |     |     |     | 106 f       |     |
& (cid:0) swap’
andsoweneedtomakesurethefollowinginequalityisguaranteed:
|     |     |     |                  | a 106            |       |
| --- | --- | --- | ---------------- | ---------------- | ----- |
|     |     |     | a                | a +a = i (cid:1) |       |
|     |     |     | r                | i f              |       |
|     |     |     | (cid:0) (cid:21) | & 106 f          | swap’ |
(cid:0)
| Butingeneralwehavefora,b |     |     | Zandk R+: |     |     |
| ------------------------ | --- | --- | --------- | --- | --- |
|                          |     | 2   | 2         |     |     |
b
|     |     |     | k         | a b a                   |     |
| --- | --- | --- | --------- | ----------------------- | --- |
|     |     |     | b (cid:1) | c(cid:21) ) (cid:21)& k | ’   |
Thecommentcanbemoreaccuratethoughsincethestate.amountSpecifiedRemainingisnegatedinthe
inequality.
(cid:3)
Pool.sol#L381-L382:
| – Case. exactInput |     | == true |     |     |     |
| ------------------ | --- | ------- | --- | --- | --- |
WehaveinPool.sol#L370-L372:
| unchecked | {   |     |     |     |     |
| --------- | --- | --- | --- | --- | --- |
state.amountSpecifiedRemaining += (step.amountIn + step.feeAmount).toInt256();
}
34

and based on this discussion, we know that state.amountSpecifiedRemaining always stays non-
| positive.                             |                         | Soattheveryendofthisfunctionwherewehave |     |     |                                              |                       |     |     |     |
| ------------------------------------- | ----------------------- | --------------------------------------- | --- | --- | -------------------------------------------- | --------------------- | --- | --- | --- |
|                                       | (params.amountSpecified |                                         |     |     | - state.amountSpecifiedRemaining).toInt128() |                       |     |     |     |
| forthefirstorsecondcomponentofresult. |                         |                                         |     |     |                                              | Thus,wecandeducethat: |     |     |     |
(aj +aj)
|     |     |     |     |     | a            | a      | =       |      | 2127            |
| --- | --- | --- | --- | --- | ------------ | ------ | ------- | ---- | --------------- |
|     |     |     |     |     | spec (cid:0) | remain | (cid:0) | in f | (cid:21)(cid:0) |
X j
T
andthusforeachiterationoftheloopwewouldhave:
|     |     |     |     |     |     | aj  | +aj | 2127 |     |
| --- | --- | --- | --- | --- | --- | --- | --- | ---- | --- |
in f (cid:20)
soevenifmultipliedby103
itwouldstillnotoveFrflowintheuint256range.
| – Case. | exactInput |     | == false |     |     |     |     |     |     |
| ------- | ---------- | --- | -------- | --- | --- | --- | --- | --- | --- |
WehaveinPool.sol#L367:
|     | state.amountCalculated |     |     | -=  | (step.amountIn |     | + step.feeAmount).toInt256(); |     |     |
| --- | ---------------------- | --- | --- | --- | -------------- | --- | ----------------------------- | --- | --- |
A
Notethatthisisacheckedblockandthetypeofstate.amountCalculatedisint256. Sothenegative
summationofthesevalueforalltheiterationscannotunderflow. Wealsohaveattheveryend:
state.amountCalculated.toInt128()
foreitherthefirstorsecondcomponentofresult. Andthuslikethepreviouscasewewouldhave:
R
|     |     |     |     |     |     | (aj | +aj) | 2127 |     |
| --- | --- | --- | --- | --- | --- | --- | ---- | ---- | --- |
in f
|     |     |     |     |     |     | (cid:0) |     | (cid:21)(cid:0) |     |
| --- | --- | --- | --- | --- | --- | ------- | --- | --------------- | --- |
j
X
(cid:3) Pool.sol#L384: Toprovethatthiscontextdoesn'tunderflow,weneedtoshow:
D
|     |     |     |     |     |     | (a        | +a )    | f     |     |
| --- | --- | --- | --- | --- | --- | --------- | ------- | ----- | --- |
|     |     |     |     |     |     |           | i f     | proto |     |
|     |     |     |     |     | a   | f         | (cid:1) |       |     |
|     |     |     |     |     |     | (cid:21)$ | 106     |       |     |
%
| Letf                       | =f ,f | =f      | 0,103   | andf    | =f     | 0,106   | . Then       |           |     |
| -------------------------- | ----- | ------- | ------- | ------- | ------ | ------- | ------------ | --------- | --- |
| s                          | swap  | p proto |         |         | L LP   |         |              |           |     |
|                            |       |         | 2       |         |        | 2       |              |           |     |
|                            |       |         | (cid:2) | (cid:3) |        | (cid:2) | (cid:3)      |           |     |
|                            |       |         |         |         |        |         | f f          |           |     |
|                            |       |         |         |         |        |         | p            | L         |     |
|                            |       |         |         |         | f s =f | p +f L  | (cid:1)      | f p       |     |
|                            |       |         |         |         |        |         | (cid:0)& 106 | ’(cid:21) |     |
| Theaboveistruesinceforallx |       |         |         | N       | 0 andk |         | [0,1]wehave: |           |     |
|                            |       |         |         | 2       | [f g   | 2       |              |           |     |
kx x
d e(cid:20)
=106
| – Case1. | f   |     |     |     |     |     |     |     |     |
| -------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
s 6
Toshowtheoriginalinequalityinthefirstcommentweneedtoprove:
a
|     |     |     |     |     |     | i 106 |     |     |     |
| --- | --- | --- | --- | --- | --- | ----- | --- | --- | --- |
f p
|     |     |     |     |     | 106 | f (cid:1) |     |               | a           |
| --- | --- | --- | --- | --- | --- | --------- | --- | ------------- | ----------- |
|     |     |     |     |     | 6 & | (cid:0) s | ’ 7 |               | i           |
|     |     |     |     |     | 6   |           | 7   |               | f           |
|     |     |     |     |     | 6   | 1 0 6     | 7   | (cid:20)& 106 | f (cid:1) s |
|     |     |     |     |     | 6   |           | 7   |               | s ’         |
(cid:0)
|     |     |     |     |     | 6   |     | 7   |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|     |     |     |     |     | 6   |     | 7   |     |     |
|     |     |     |     |     | 6   |     | 7   |     |     |
|     |     |     |     |     | 4   |     | 5   |     |     |
35

| orevenastrongerinequalitysinceweknowf |     |     |     |     | f :        |     |     |     |
| ------------------------------------- | --- | --- | --- | --- | ---------- | --- | --- | --- |
|                                       |     |     |     | p   | (cid:20) s |     |     |     |
a i
|     |     |     |     | 106       | f   |               |         |           |
| --- | --- | --- | --- | --------- | --- | ------------- | ------- | --------- |
|     |     |     | 106 | f         | p   |               |         |           |
|     |     | 6   | &   | s (cid:1) | ’ 7 |               | a       |           |
|     |     |     |     | (cid:0)   |     |               | i       | f         |
|     |     | 6   |     |           | 7   |               |         | p         |
|     |     | 6   |     | 1 0 6     | 7   | (cid:20)& 106 | f s     | (cid:1) ’ |
|     |     | 6   |     |           | 7   |               | (cid:0) |           |
|     |     | 6   |     |           | 7   |               |         |           |
|     |     | 6   |     |           | 7   |               |         |           |
|     |     | 6   |     |           | 7   |               |         |           |
|     |     | 4   |     |           | 5   |               |         |           |
a
i Q 0
| Letx = | (cid:21) andy | =f p | ,thenweneedtoshow: |     |     |     | T   |     |
| ------ | ------------- | ---- | ------------------ | --- | --- | --- | --- | --- |
| 106 f  | 2             |      |                    |     |     |     |     |     |
(cid:0) s
|     |     |     |     | x 106    | y          |         |     |     |
| --- | --- | --- | --- | -------- | ---------- | ------- | --- | --- |
|     |     |     |     | (cid:1)  |            | x       | y   |     |
|     |     |     |     | 106      | %(cid:20)d | (cid:1) | e   |     |
|     |     |     |     | $(cid:6) | (cid:7)    |         |     |     |
F
b+(cid:15)
Letx = a+ wherea 0,1,2, ,b 0,1, ,106 1 and(cid:15) [0,1). Thenweneedtoshow
106
|     | 2   | f   | (cid:1)(cid:1)(cid:1)g | 2 f | (cid:1)(cid:1)(cid:1) | (cid:0) | g   | 2   |
| --- | --- | --- | ---------------------- | --- | --------------------- | ------- | --- | --- |
that:
y
|     |     |     | 106a+b+(cid:15) |     |     |     | x y |     |
| --- | --- | --- | --------------- | --- | --- | --- | --- | --- |
A
|     |     |     | $              |     | (cid:1)        | 106 %(cid:20)d | (cid:1) | e   |
| --- | --- | --- | -------------- | --- | -------------- | -------------- | ------- | --- |
|     |     |     | (cid:6)(cid:0) |     | (cid:1)(cid:7) |                |         |     |
or
|                         |     |                     |              |                | y          |                   |             | y           |
| ----------------------- | --- | ------------------- | ------------ | -------------- | ---------- | ----------------- | ----------- | ----------- |
|                         |     | 106a+b+(cid:15)     |              |                |            | (106a+b+(cid:15)) |             |             |
|                         |     |                     |              | (cid:1) 106    | %(cid:20)& |                   |             | (cid:1) 106 |
| R$                      |     |                     |              |                |            |                   |             | ’           |
|                         |     | (cid:6)(cid:0)      |              | (cid:1)(cid:7) |            |                   |             |             |
| Notethatwecansubtractay |     | frombothsidestoget: |              |                |            |                   |             |             |
|                         |     |                     |              |                | y          |                   | y           |             |
|                         |     |                     | (b+(cid:15)) |                |            | (b+(cid:15))      |             |             |
|                         |     |                     | $d           | e(cid:1) 106   | %(cid:20)& |                   | (cid:1) 106 |             |
’
D
andwecaneventrytoprovestrongerinequality:
|     |     |     |     |         | y              |             | y   |     |
| --- | --- | --- | --- | ------- | -------------- | ----------- | --- | --- |
|     |     |     |     | (b+1)   |                | b           |     |     |
|     |     |     | $   | (cid:1) | 106 %(cid:20)& | (cid:1) 106 | ’   |     |
y
| letk = [0,10 | 3],thenweneedtoshow: |     |     |     |     |     |     |     |
| ------------ | -------------------- | --- | --- | --- | --- | --- | --- | --- |
(cid:0)
| 106 2 |     |     |     |        |            |     |     |     |
| ----- | --- | --- | --- | ------ | ---------- | --- | --- | --- |
|       |     |     |     | (b+1)k |            | bk  |     |     |
|       |     |     |     | b      | c(cid:20)d | e   |     |     |
or
|     |     |     | bk  | + bk | +k         | bk + | bk    |     |
| --- | --- | --- | --- | ---- | ---------- | ---- | ----- | --- |
|     |     |     | b c | bf g | c(cid:20)b | c    | df ge |     |
or
|     |     |     |     | bk   | +k          | bk  |     |     |
| --- | --- | --- | --- | ---- | ----------- | --- | --- | --- |
|     |     |     |     | bf g | c(cid:20)df | ge  |     |     |
3
Butfromtherangeofk weknowthat bk +k 0,1+10 (cid:0) andsobothsidesoftheinequalityabove
|     |     |     | f   | g   | 2   |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
caneitherbe0or1andtherighthandsidecanonlybe1ifandonlyif bk +k 1whichimpliesthat
wheneveritis1then bk needstobenon-zeroandthus (cid:2) bk (cid:1) =1whichprovestheinequality. f g (cid:21)
|     | f g |     |     |     |     | df  | ge  |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
36

– Case2f =106
s
Then we know that we should have a 0 or only the exact input branches are reached. Also we
spec
|     | =106. | (cid:20) |     |     |     |
| --- | ----- | -------- | --- | --- | --- |
knowinthiscasef Thenthereare2cases.
L
Case2.1(seeSwapMath.sol#L70-L71)
*
| Inthiscasebotha | =a =0whichthentheinequalityisobvious. |     |     |     |     |
| --------------- | ------------------------------------- | --- | --- | --- | --- |
f i
* Case2.2(seeSwapMath.sol#L77-L81)
| sqrtPriceNextX96 | = SqrtPriceMath.getNextSqrtPriceFromInput( |     |     |     |     |
| ---------------- | ------------------------------------------ | --- | --- | --- | --- |
T
| sqrtPriceCurrentX96, |     | liquidity, | amountRemainingLessFee, |     | zeroForOne |
| -------------------- | --- | ---------- | ----------------------- | --- | ---------- |
);
| amountIn                                          | = zeroForOne |     |     |                      |     |
| ------------------------------------------------- | ------------ | --- | --- | -------------------- | --- |
| ? SqrtPriceMath.getAmount0Delta(sqrtPriceNextX96, |              |     |     | sqrtPriceCurrentX96, |     |
| liquidity,                                        | true)        |     |     |                      |     |
,!
| : SqrtPriceMath.getAmount1Delta(sqrtPriceCurrentX96, |     |     |     |     | sqrtPriceNextX96, |
| ---------------------------------------------------- | --- | --- | --- | --- | ----------------- |
F
| ,! liquidity, | t rue); |     |     |     |     |
| ------------- | ------- | --- | --- | --- | --- |
’
// we didn t reach the target, so take the remainder of the maximum input as fee
| feeAmount | = uint256(-amountRemaining) |     | - amountIn; |     |     |
| --------- | --------------------------- | --- | ----------- | --- | --- |
We know that amountRemainingLessFee == 0 and thus sqrtPriceNextX96 == sqrtPriceCur-
rentX96 which implies that amountIn == 0 and feeAmount == uint256(-amountRemaining). So
A
inthiscasewehave:
|     |     |     | a =0,a = | a         |     |
| --- | --- | --- | -------- | --------- | --- |
|     |     |     | i f      | (cid:0) r |     |
andtheinequalitybecomes:
R
f
p
|     |     |     | a                      | a   |     |
| --- | --- | --- | ---------------------- | --- | --- |
|     |     |     | 106(cid:1) f %(cid:20) | f   |     |
$
(cid:3) Pool.sol#L408: Wehavethat:
D
|     |     | L   | =L +L   |     |     |
| --- | --- | --- | ------- | --- | --- |
|     |     | i,g | i,l i,u |     |     |
|     |     | L   | =L L    |     |     |
|     |     | i,n | i,l i,u |     |     |
(cid:0)
andweknowthatmaxgrossliquidityofatickcannotbegreaterthanthetickSpacingToMaxLiquidityPer-
Tick(tickSpacing):
|     |     | 2128 | 1   | 2128 |     |
| --- | --- | ---- | --- | ---- | --- |
<2127
|     | L i,g    |     | (cid:0) | <   |     |
| --- | -------- | --- | ------- | --- | --- |
|     | (cid:20) | i   | i       | 3   |     |
max min
|     |     | + j | j +1 |     |     |
| --- | --- | --- | ---- | --- | --- |
(cid:1)i (cid:1)i
|     |     | $ % $ | %   |     |     |
| --- | --- | ----- | --- | --- | --- |
andsinceL ,L arenon-negativevalues,onecandeducethat:
i,l i,u
|     |     | 2127 | <L  |     |     |
| --- | --- | ---- | --- | --- | --- |
i,n
(cid:0)
parameter description
L liquidityGrossattheticki
i,g
L liquidityNetattheticki
i,n
37

parameter description
L Sumofalltheliquidityofallpositionswiththeirlowertickequaltoi
i,l
L Sumofalltheliquidityofallpositionswiththeiruppertickequaltoi
i,u
(cid:1)i tickSpacing
T
5.4.11 Dirtybitcleaning
Severity: Informational
Context: SwapMath.sol#L31,Pool.sol#L419
Description:
F
SwapMath.sol#L31: In the context of the codebase this and some other upper bit cleanings are not nec-
essary and(zeroForOne, 0xff) since on external calls the solc compiler performs cleaning. But in the
contextofalibraryandinternalfunctionswhythezeroForOnevalueisnotcompletelycleanedbydoing
and(zeroForOne, 1)?
(cid:3) Pool.sol#L419: WhynotjustandwiAth1?
Recommendation: Applythefollowingbitcleaninginstead:
and(zeroForOne, 1)
Uniswap:
R
• FixedinPR838.
• Pool.sol#L419: istransformedintoandthusavoidingthebitcleanupnecessary. SeePR827.
unchecked {
result.tick = zeroForOne ? step.tickNext - 1 : step.tickNext;
}
D
Spearbit: Verified.
5.4.12 Namedreturnareunusedinsettle()andsettleFor()
Severity: Informational
Context: PoolManager.sol#L288-L291
Description: settle()andsettleFor()functionsdeclareanamedreturnvariablepaid,butdonotexplicitlyuse
itinthefunctionbody. Instead,theydirectlyreturntheresultofthe_settle()functioncall.
Recommendation: Eitherusethenamedreturnvariableexplicitlyorremoveit.
function settle() external payable onlyWhenUnlocked returns (uint256 paid) {
- return _settle(msg.sender);
+ paid = _settle(msg.sender);
Uniswap: FixedinPR829.
Spearbit: Fixed. Thepaidparameterwasremoved.
38

5.4.13 collectProtocolFeeslacksanowneventtotrackfeecollections
Severity: Informational
Context: ProtocolFees.sol#L57
Description: collectProtocolFees transfers collected protocol fees to a recipient but only emits a generic cur-
rencyTransferevent. Thislacksspecificityandmakesitdifficulttotrackprotocolfeecollectionactivitiesseparately
fromothertransfers. Adedicatedeventforprotocolfeecollectionwouldimprovetransparencyandmakeiteasier
tomonitorandanalyzethesespecifictransactions.
Recommendation: ImplementaspecificeventforprotocolfeecollectionT. Forexample:
event ProtocolFeeCollected(address indexed recipient, Currency indexed currency, uint256 amount,
,! address caller);
Uniswap: Acknowledged. WearenotgoingtobeaddinganeventtocollectProtocolFees.
F
Spearbit: Acknowledged.
5.4.14 Bestpracticesforhandlingactionflows
Severity: Informational
A
Context: PoolManager.sol#L271-L285
Description: Developershavetobeawareofpotentialissuesthatmaycauseswapsorflashloanstorevert. First,
sync() can be called outside of unlocks, and at most 1 currency can be synced each time before settlement. In
otherwords,sync()cannotbecalledinsuccession,whichenablesaDenialofService(DoS)attackvector.
Second,nativetokentransfersviathetake()actionwhichexecutesCurrency(native).transfer()wouldhand
R
overthecontrolflowtotherecipient,allowingittoreverttheentiretransaction.
Recommendation: Recommend best practices for integrators and developers, and highlight present limitations
thattheyshouldbeawareof. Specifically:
• Considercheckingforanexistingsyncandcallingsettle()beforeinvokingsync().
• Becautiouswithnativetokentransferstountrustedrecipients.
D
Uniswap: 2PRsthatchangethecurrentbehaviour:
1. LockaddedtosyncinPR856.
2. sync no longer reverts (just overrides), and allows native to be synced to remove DoS attack vectors in PR
866.
Spearbit: Acknowledged on the new behaviour. There is a footgun introduced that developers should be aware
of: if one syncs one currency transfers tokens syncs another without settlement, the token transfer will not
! !
beaccountedfor.
5.4.15 PoolswithmaximumlpFeedonotsupportexactoutputswaps
Severity: Informational
Context: Pool.sol#L312-L314
Description: WhileitispossibletosetlpFeeto100%, itwillcauseexactoutputswapstorevert. Inotherwords,
suchpoolswillonlyworkwithexactInswaps.
Recommendation: Developers and pool creators should be aware of this side-effect should they choose to set
maximumlpFee.
Uniswap: FixedinPR842.
Spearbit: Fixed.
39

5.4.16 Currency.isZero()isequivalenttoCurrency.isNative()
| Severity: | Informational          |     |     |     |     |     |     |
| --------- | ---------------------- | --- | --- | --- | --- | --- | --- |
| Context:  | Currency.sol#L104-L110 |     |     |     |     |     |     |
Description: isZero() is equivalent to isNative(). Either function could be removed for simplicity and its in-
stancesreplacedwiththeother.
Recommendation: ConsiderremovingeitherisZero()orisNative()andreplaceallitsinstanceswiththeother
function.
| Uniswap: | FixedinPR834. |     |     |     |     |     |     |
| -------- | ------------- | --- | --- | --- | --- | --- | --- |
Spearbit: Fixed. isZero()isrenamedtoisAddressZero()andisNative()hasbeenremoved.
5.4.17 CommentImprovements
| Severity: | Informational |     |     |     |     |     |     |
| --------- | ------------- | --- | --- | --- | --- | --- | --- |
Context: IPoolManager.sol#L104, IPoolManager.sol#L190, IHooks.sol#L9-L11, IHooks.sol#L72, IHooks.sol#86,
ProtocolFees.sol#L61, LPFeeLibrary.sol#L21, LPFeeLibrary.sol#L34, TransientStateLibrary.sol#L27,
Pool.sol#L559,ProtocolFees.sol#L67,IPoolManager.sol#L140-L142,IPoolManager.sol#L140-L142
Description: Thefollowingarecommentclarificationsforcorrectnessandclarity,andtypos.
Recommendation:
|     |     |     |     | ‘   | ‘ ‘ |     | ‘   |
| --- | --- | --- | --- | --- | --- | --- | --- |
- /// @dev The only functions callable without an unlocking are initialize and updateDynamicLPFee
|     |     |     |     | ‘   | ‘ ‘ | ‘   |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
+ /// @dev The only functions callable without an unlTocking are initialize , sync and
| ‘   |     | ‘   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
,! updateDynamicLPFee F
A
- retreivable
R
+ retrievable
D
- /// @notice The PoolManager contract decides whether to invoke specific hooks by inspecting the
| ,! leading | bits |     |     |     |     |     |     |
| ---------- | ---- | --- | --- | --- | --- | --- | --- |
- /// of the hooks contract address. For example, a 1 bit in the first bit of the address will
|     | ’   | ’   |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
- /// cause the before swap hook to be invoked. See the Hooks library for the full spec.
+ /// @notice V4 decides whether to invoke specific hooks by inspecting the lowest significant bits of
| ,! the    | address that   |             |     |     |     |     |     |
| --------- | -------------- | ----------- | --- | --- | --- | --- | --- |
| + /// the | hooks contract | is deployed | to. |     |     |     |     |
+ /// For example, a hooks contract deployed to address: 0x0000000000000000000000000000000000002400
|     |     | ’   | ’   | ’   |     | ’ ’ |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
+ /// has the lowest bits 10 0100 0000 0000 which would cause the before initialize and after add
’
| liquidity | hooks | to be used. |     |     |     |     |     |
| --------- | ----- | ----------- | --- | --- | --- | --- | --- |
,!
| + /// See | the Hooks library | for the full | spec. |     |     |     |     |
| --------- | ----------------- | ------------ | ----- | --- | --- | --- | --- |
- liquidty
+ liquidity
- overriden
+ overridden
- beforeSwaphook
| + beforeSwap | hook |     |     |     |     |     |     |
| ------------ | ---- | --- | --- | --- | --- | --- | --- |
- maxmimum
+ maximum
- zerod
+ zeroed
| - /// @dev | Executed within | the pool constructor |     |     |     |     |     |
| ---------- | --------------- | -------------------- | --- | --- | --- | --- | --- |
| + /// @dev | Executed when   | adding liquidity     |     |     |     |     |     |
40

- /// @dev the success of this function must be checked when called in setProtocolFee
| (the function | under the     | comment above  | is not called | in setProtocolFee) |
| ------------- | ------------- | -------------- | ------------- | ------------------ |
| + /// Whether | to swap token | zero for token | one or vice   | versa              |
bool zeroForOne;
+ /// The desired input amount if negative ("exact in"), or the desired output amount if positive
| ,! ("exact              | out") |     |     |     |
| ----------------------- | ----- | --- | --- | --- |
| int256 amountSpecified; |       |     |     |     |
+ /// The most extreme square-root-price the pool may reach by the end of the swap
| uint160                             | sqrtPriceLimitX96; |     |              | T   |
| ----------------------------------- | ------------------ | --- | ------------ | --- |
| TheIPoolManagerhavestalecommentsvs. |                    |     | PoolManager: |     |
- /// @return feeDelta The balance delta of the fees generated in the liquidity range. Returned for
| ,! informational | purposes. |     |     |     |
| ---------------- | --------- | --- | --- | --- |
+ /// @return feesAccrued The balance delta of the feFes generated in the liquidity range. Returned for
| ,! informational | purposes. |     |     |     |
| ---------------- | --------- | --- | --- | --- |
function modifyLiquidity(PoolKey memory key, ModifyLiquidityParams memory params, bytes calldata
,! hookData)
external
| - returns              | (BalanceDelta | callerDelta,  | BalanceDelta | feeDelta);    |
| ---------------------- | ------------- | ------------- | ------------ | ------------- |
| + returns              | (BalanceDelta | callerDAelta, | BalanceDelta | feesAccrued); |
| Uniswap: FixedinPR846. |               |               |              |               |
Fixed.
Spearbit:
5.4.18 memory-safeaRnnotation
| Severity: Informational |     |     |     |     |
| ----------------------- | --- | --- | --- | --- |
Context: CurrencyDelta.sol#L20-L22, CurrencyReserves.sol#L25, CurrencyReserves.sol#L31,
CurrencyReserves.sol#L37,CurrencyReserves.sol#L44,CustomRevert.sol#L69-L74
Description/Recommendation:
D
• CurrencyDelta.sol#L20-L22, CurrencyReserves.sol#L25, CurrencyReserves.sol#L31, CurrencyRe-
serves.sol#L37,CurrencyReserves.sol#L44: missingmemory-safeannotation.
• CustomRevert.sol#L69-L74: this assembly block does not follow the memory-safe annotation requirement
sinceit writesto memoryspace rightpassed thescratchmemory slots. To besafe oneshould usethe free
memorypointerandwritetomemoryrightatandafterthatlocation.
| Uniswap: FixedinPR830. |     |     |     |     |
| ---------------------- | --- | --- | --- | --- |
| Spearbit: Verified.    |     |     |     |     |
41