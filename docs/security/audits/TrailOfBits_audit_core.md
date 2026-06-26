Uniswap v4 Core
Security Assessment
September5,2024
Preparedfor:
AliceHenshaw
Uniswap
Preparedby:AlexanderRemie,PriyankaBose,BenjaminSamuels,TarunBansal,
GuillermoLarregay, JosselinFeist,andXianganHe

About Trail of Bits
Foundedin2012andheadquarteredinNewYork,TrailofBitsprovidestechnicalsecurity
assessmentandadvisoryservicestosomeoftheworld’smosttargetedorganizations.We
combinehigh- endsecurityresearchwithareal -worldattackermentalitytoreduceriskand
fortifycode.With100+employeesaroundtheglobe,we’vehelpedsecurecriticalsoftware
elementsthatsupportbillionsofendusers,includingKubernetesandtheLinuxkernel.
Wemaintainanexhaustivelistofpublicationsathttps://github.com/trailofbits/publications,
withlinkstopapers,presentations,publicauditreports,andpodcastappearances.
Inrecentyears,TrailofBitsconsultantshaveshowcasedcutting-edgeresearchthrough
presentationsatCanSecWest,HCSS,Devcon,EmpireHacking,GrrCon,LangSec,NorthSec,
theO’ReillySecurityConference,PyCon,REcon,SecurityBSides,andSummerCon.
Wespecializeinsoftwaretestingandcodereviewprojects,supportingclientorganizations
inthetechnology,defense,andfinanceindustries,aswellasgovernmententities.Notable
clientsincludeHashiCorp,Google,Microsoft,WesternDigital,andZoom.
TrailofBitsalsooperatesacenterofexcellencewithregardtoblockchainsecurity.Notable
projectsincludeauditsofAlgorand,BitcoinSV,Chainlink,Compound,Ethereum2.0,
MakerDAO,Matic,Uniswap,Web3,andZcash.
Tokeepuptodatewithourlatestnewsandannouncements,pleasefollow@trailofbitson
Twitterandexploreourpublicrepositoriesathttps://github.com/trailofbits.Toengageus
directly,visitour“Contact”pageathttps://www.trailofbits.com/contact,oremailusat
info@trailofbits.com.
TrailofBits,Inc.
497CarrollSt.,Space71,SeventhFloor
Brooklyn,NY11215
https://www.trailofbits.com
info@trailofbits.com
TrailofBits 1 Uniswapv4CoreSecurityAssessment
PUBLIC

Notices and Remarks
Copyright and Distribution
©2024byTrailofBits,Inc.
Allrightsreserved.TrailofBitsherebyassertsitsrighttobeidentifiedasthecreatorofthis
reportintheUnitedKingdom.
ThisreportisconsideredbyTrailofBitstobepublicinformation;itislicensedtoUniswap
underthetermsoftheprojectstatementofworkandhasbeenmadepublicatUniswap’s
request.Materialwithinthisreportmaynotbereproducedordistributedinpartorin
wholewithouttheexpresswrittenpermissionofTrailofBits.
ThesolecanonicalsourceforTrailofBitspublicationsistheTrailofBitsPublicationspage.
Reportsaccessedthroughanysourceotherthanthatpagemayhavebeenmodifiedand
shouldnotbeconsideredauthentic.
Test Coverage Disclaimer
AllactivitiesundertakenbyTrailofBitsinassociationwiththisprojectwereperformedin
accordancewithastatementofworkandagreeduponprojectplan.
Securityassessmentprojectsaretime-boxedandoftenreliantoninformationthatmaybe
providedbyaclient,itsaffiliates,oritspartners.Asaresult,thefindingsdocumentedin
thisreportshouldnotbeconsideredacomprehensivelistofsecurityissues,flaws,or
defectsinthetargetsystemorcodebase.
TrailofBitsusesautomatedtestingtechniquestorapidlytestthecontrolsandsecurity
propertiesofsoftware.Thesetechniquesaugmentourmanualsecurityreviewwork,but
eachhasitslimitations:forexample,atoolmaynotgeneratearandomedgecasethat
violatesapropertyormaynotfullycompleteitsanalysisduringtheallottedtime.Theiruse
isalsolimitedbythetimeandresourceconstraintsofaproject.
TrailofBits 2 Uniswapv4CoreSecurityAssessment
PUBLIC

Table of Contents
AboutTrailofBits 1
NoticesandRemarks 2
TableofContents 3
ProjectSummary 5
ExecutiveSummary 6
ProjectGoals 9
ProjectTargets 10
ProjectCoverage 11
AutomatedTesting 15
StatefulInvariants 16
PoolInitialization 16
SwapAction 17
DonateAction 19
SettlementActions 19
ModifyLiquidityAction 20
TakeAction 21
End-to-EndProperties 21
Inter-ActionProperties 22
StatelessInvariants 22
ProtocolFeeLibrary 22
LiquidityMath 22
DifferentialTestingbetweenV3andV4 23
DifferentialTestingbetweenLow-LevelCodeandHigh-LevelImplementations 23
StaticInvariants 24
CodebaseMaturityEvaluation 25
SummaryofFindings 28
DetailedFindings 29
1.Strictequalityonfeecomparisoncancausefeestoexceed100% 29
2.Incorrectvariableusageonswapfee 31
3.Collectedprotocolfeesmaycountagainstuser’scurrencydeltas 33
4.UseofincorrectmasktoclearhigherbitsoftheprotocolFeevalue 35
5.Insufficienteventgeneration 37
6.Similar-lookingpoolIDscanbebrute-forcedthroughthePoolKeyhooksfields 39
TrailofBits 3 Uniswapv4CoreSecurityAssessment
PUBLIC

A.VulnerabilityCategories 42
B.CodeMaturityCategories 44
C.CodeQualityFindings 46
D.InvariantTestingandHarnessDesign 47
StatelessInvariantTesting 47
StatefulInvariantTesting 47
StatefulInvariantsUsingtheEnd-to-EndHarness 48
StatefulInvariantsUsingtheActionsHarness 50
ActionsHarnessDesign 50
SelectedInvariantsforDiscussion 53
EnsuringthataPool’sFeeGrowthGlobalCannotUnderflow 53
EnsuringthattheSingletonCanAlwaysCoverItsDebts 53
FutureWork 55
E.StaticInvariants 56
F.FixReviewResults 61
DetailedFixReviewResults 61
G.FixReviewStatusCategories 63
TrailofBits 4 Uniswapv4CoreSecurityAssessment
PUBLIC

Project Summary
Contact Information
Thefollowingprojectmanagerwasassociatedwiththisproject:
SamGreenup,ProjectManager
sam.greenup@trailofbits.com
Thefollowingengineeringdirectorwasassociatedwiththisproject:
JosselinFeist,EngineeringDirector,Blockchain
josselin.feist@trailofbits.com
Thefollowingconsultantswereassociatedwiththisproject:
AlexanderRemie,Consultant PriyankaBose,Consultant
alexander.remie@trailofbits.com priyanka.bose@trailofbits.com
BenjaminSamuels,Consultant TarunBansal,Consultant
benjamin.samuels@trailofbits.com tarun.bansal@trailofbits.com
GuillermoLarregay,Consultant XianganHe,Consultant
guillermo.larregay@trailofbits.com xiangan.he@trailofbits.com
Project Timeline
Thesignificanteventsandmilestonesoftheprojectarelistedbelow.
Date Event
July15,2024 Pre-projectkickoffcall
July24,2024 Statusupdatemeeting#1
August5,2024 Deliveryofreportdraftandreadoutmeeting
September5,2024 Deliveryofcomprehensivereport
TrailofBits 5 Uniswapv4CoreSecurityAssessment
PUBLIC

Executive Summary
Engagement Overview
UniswapengagedTrailofBitstoreviewthesecurityoftheUniswapv4Coresmart
contracts.Uniswapv4isthenextiterationofthepopulardecentralizedexchange.This
fourthiterationbuildsonthecoreofUniswapv3byaddingthefollowingfeatures:a
singletonPoolManagercontract;anoptional,arbitraryHookscontractperpoolthatis
calledduringvariousstagesintheexecution;flashaccounting;dynamicLPfees;nativeETH
support;andusingERC6909foroptionallystoringuserbalancesinternallyinsteadof
performingtokentransfers.
AteamofsixconsultantsconductedthereviewfromJuly15,2024toAugust2,2024,fora
totalofsixengineer-weeksofeffort.Ourtestingeffortsfocusedonthenewlyintroduced
featuresinv4oftheprotocolandhowthosechangesaffecttheexistingv3protocol.
Additionally,wefocusedonthecorrectnessandsafetyofthenumeroususagesofinline
assemblythroughoutthecodebase.Withfullaccesstosourcecodeanddocumentation,we
performedstaticanddynamictestingoftheUniswapv4corecodebase,usingautomated
andmanualprocesses.
Observations and Impact
TheUniswapv4projectisamatureprojectthatbuildsontopoftheUniswapv3
implementation—inotherwords,itbuildsontopofabattle-testedfoundation.Every
aspectofthisprojectshowsthattheUniswapv4teamhasputalotofeffortintoits
security.Thecodequality—ofthehigh-levelSolidityaswellasthelow-levelinline
assembly—ishigh;thereissufficientsource-leveldocumentation;thereisproper
high-level,user-facingdocumentationwithdiagramsandusecases;andthetestingsuiteis
extensiveandusesfuzzing.
Theextensivetestingsuiteheavilyusesfoundryfuzzingtoextendthetestedvalues,leading
tohigheroveralltestingcoverage.ForgetestcoverageisintegratedintheCIanddisplayed
ineachPR.Echidnatestsarepresenttotestoutthevariousmathlibraries.
Sincetheimplementationissignificantlygearedtowardgasoptimization,manypartshave
beenimplementedininlineassemblyinsteadofSolidity.Thishasmadethe
implementationsignificantlymoredifficulttocomprehendandpresentsmanymore
possiblefootgunsfor(future)Uniswapdevelopers.However,whiletheinlinecommentsof
theassemblycodehelptolowerthecomplexity,thelackofaSoliditycounterpartandthe
levelofassemblyusageincreasetherisks.
ThenewlyaddedHooksfeatureenablesextensivecustomizationbyexternalprojectsthat
previouslywouldhavehadtoforkUniswapv3tocreatetheircustomizedversion.Inv4,
theseprojectscanusetheHooksfeaturetocreateacustomizedpooltotheirliking.
TrailofBits 6 Uniswapv4CoreSecurityAssessment
PUBLIC

However,theflipsideofthisflexibilityistheaddedcomplexityoftheoverallUniswapv4
projectcomparedtov3.Thisflexibilityalsomakesitmoredifficultforuserstochoosea
non-maliciouspool,sincetheymustconfrontchallengeslikedecidingwhichpooltouse
anddeterminingthatitisnotmalicious.
Duringthisreview,wefoundsixissues,ofwhichoneislowseverityandtheremainingfive
areinformational.Inaddition,wecreated100invariants,ofwhicheighthavebeenformally
verifiedbyHalmos,88checkedbyMedusaandEchidna,andfourstaticallycheckedby
Slither.SeeappendixDforanin-depthoverviewofhowweusedfuzzingduringthis
engagement.
Recommendations
Basedonthecodebasematurityevaluationandfindingsidentifiedduringthesecurity
review,TrailofBitsrecommendsthatUniswaptakethefollowingsteps:
● Remediatethefindingsdisclosedinthisreport.Thesefindingsshouldbe
addressedaspartofadirectremediationoraspartofanyrefactorthatmayoccur
whenaddressingotherrecommendations.
● Addmoredocumentationthroughoutthesourcecode.Thiswillhelpprevent
(new)developersfromintroducingmistakesbecausetheyforgetundocumented
assumptionsormisunderstandthecomplexandassembly-heavyimplementation.
● Reuseandpotentiallyexpandtheprovidedstatefulinvariantsandfuzzing
harnessesthatwedevelopedduringthisengagement.ThisallowstheUniswap
teamtoeasilyperformmoreadvancedstatefulfuzzingthatsupersedeswhatcanbe
doneusingFoundry.Theprovidedstatefulinvariantscanalsoeasilybeextended
withnewinvariants,forwhichweprovidesomerecommendationsintheFuture
Worksection.
● Writeextensiveguidelinesforusersthathelpthemavoidbeingtrickedinto
usingamaliciouspool.AshighlightedinTOB-UNI4-6,itismucheasierinUniswap
v4thaninUniswapv3formaliciousactorstotrickusersintousingmaliciouspools.
Additionally,itisgenerallyeasiertocreatemaliciouspoolsinUniswapv4duetothe
arbitrarynatureofhookscontracts.Guidelinescansignificantlylowertheserisks.
TrailofBits 7 Uniswapv4CoreSecurityAssessment
PUBLIC

| Finding | Severities | and Categories |     |     |     |
| ------- | ---------- | -------------- | --- | --- | --- |
Thefollowingtablesprovidethenumberoffindingsbyseverityandcategory.
| EXPOSUREANALYSIS |     |     |       | CATEGORYBREAKDOWN  |       |
| ---------------- | --- | --- | ----- | ------------------ | ----- |
| Severity         |     |     | Count | Category           | Count |
| High             |     |     | 0     | AuditingandLogging | 1     |
| Medium           |     |     | 0     | DataValidation     | 3     |
| Low              |     |     | 1     | UndefinedBehavior  | 2     |
| Informational    |     |     | 5     |                    |       |
| Undetermined     |     |     | 0     |                    |       |
TrailofBits
8 Uniswapv4CoreSecurityAssessment
PUBLIC

Project Goals
TheengagementwasscopedtoprovideasecurityassessmentoftheUniswapv4Core
contracts.Specifically,wesoughttoanswerthefollowingnon-exhaustivelistofquestions:
● Isthereawaytoaltertheinternalaccountingofbalancesorfeeswithoutproviding
tokensorEther?Canamalicioususergeneratelossesorotherwisegain
unauthorizedaccesstofundsinpoolsbyprovidingmalicioustokens?
● Canexternalusersorcontractslosefunds,receivefewertokensthanexpectedfrom
aswap,orhavetheirfundsstuckinthepoolduringnormaloperation?
● Canmalicioushooksgetaccesstofundsorblockoperationsofadifferentpool?
● Areaccesscontrolscorrectlyimplemented?Canmalicioususersexecuteprivileged
functionsorchangesystemparameters?
● Arearithmeticoperationsimplementedcorrectly?Forlow-levelimplementations,is
itpossibletotriggeranoverfloworunexpectedresultsthatcanaffectpools?Arethe
low-levelfunctionsequivalenttotheirhigh-levelcounterparts?Arerounding
directionsconsideredandverifiedforallcriticalcalculations?
● Doalltransientstoragemanipulationfunctionscleanupthestatecorrectlywhen
thecallsreturn,andifso,cananattackerexploitthis?Canacallsetastatethatis
notclearedbeforereturning?Arelockscorrectlyimplemented?
● Arestorageslots,structures,anddatacorrectlymanipulated?Canstoragebe
overwrittenbymalicioususersfromadifferentpoolorexternalcalls?
● Arefeesanddeltascorrectlycalculatedandvalidatedinallusages?Aredata
structurescorrectlypackedandunpacked,andtypecastsperformedwithoutlosing
dataorprecision?Arecustomtypesanduser-definedoperatorscorrectly
implemented?
● Arepricesandtickscorrectlycalculatedwhenliquidityisaddedandremovedor
whenswapsareperformed?Canpricesbemanipulated?
TrailofBits 9 Uniswapv4CoreSecurityAssessment
PUBLIC

Project Targets
Theengagementinvolvedareviewandtestingofthefollowingtarget.
Uniswapv4core
Repository https://github.com/Uniswap/v4-core
Version 7a72031574fc4548ca8fce197114cf87d5a2c037
Type Solidity
Platform EVM
TrailofBits 10 Uniswapv4CoreSecurityAssessment
PUBLIC

Project Coverage
Thissectionprovidesanoverviewoftheanalysiscoverageofthereview,asdeterminedby
ourhigh-levelengagementgoals.Ourapproachesincludedthefollowing:
● Hooks.HooksareanewfeatureintroducedbyUniswapV4thatenableahighlevel
ofcustomizationbyallowingdeveloperstoimplementspecificfunctionalitiesat
variousstagesofaliquiditypool’slifecycleinsideanarbitraryHookscontract.
Duringpoolcreation,anoptionalHookscontractcanbeattachedtothepool.The
lowerbitsoftheHookscontractaddressdeterminetheenabled/disabledhookcalls.
Therearehooksforpoolinitialization,addingliquidity,removingliquidity,
performingaswap,anddonatingtokenstoLPs.
WemanuallyreviewedthepoolcreationprocesstoseeifaninvalidHookscontract
couldbeconfiguredandiftheconfiguredHookscontractaddresscouldbechanged
afterpoolcreation.Weusedunittestsandmanualreviewofthevariouslifecycle
hooks(swaps,donations,andaddingorremovingliquidity)todetermineifthehook
callsaremadeattherightplaceinthelifecycleandif,throughreentrancy,tokens
canbestolenfromtheprotocol(includingotherpools)ortheinternalaccounting
canbeincorrectlyupdatedinanyway.Wereviewedtheuseof
hooks-returning-deltasthroughouttheprotocoltoseeifthedeltaswereapplied
correctly.WecheckedifanupgradeableHookscontractcaninanywayleadto
unforeseenproblems.Weverifiedtheimplementationofallhookcallswithinthe
Hookslibraryandthebitwiseoperationstoenable/disablespecifichookcalls.We
reviewedthecallHookfunctiontoassessitscorrectfunctioning,thepossibilityand
effectofareturn-bombattackfromthehook,andtheuseofinlineassemblytocall
andparsethehookcall’sreturnvalue.Weusedstaticinvariantstoassesstheuseof
thenoSelfCallmodifierandwhethertherearecollisionsbetweenthefunctionsin
thePoolManagerandthevarioushooksfunctions(seeAutomatedTesting:Static
Invariants).
● Flashaccounting.Uniswapv4introducesflashaccounting.Thisentailskeepingan
internaldeltaoftokensowedtoauserandtokensowedtotheprotocol,andonlyat
theveryendofallactionsisauserrequiredtopaytheirdebtandwithdrawtheir
credit.Failingtodobothofthesethingswillcausethetransactiontorevert.Fora
usertopaytheirdebt,theycancallsettle(orburnERC69096tokensthrough
burn),andforausertowithdrawtheircredit,theycancalltake(ormintERC6909
tokensthroughmint).
Wemanuallyreviewedthedeltamechanismthroughoutthevariouslifecycle
functions.Welookedforwaystobringthedeltatozerowithoutpayingthefulldebt,
suchaspayingthedebtinadifferenttokeninsteadoftheexpectedone;flawsdue
tomultiple/reentrantcallstosync,settle,andtakeinvariousorders;andwaysto
TrailofBits 11 Uniswapv4CoreSecurityAssessment
PUBLIC

maliciouslyinflatethecreditdeltaamountorsetcreditinadifferenttokenthanthe
expectedone.Wemanuallyreviewedthedeltalibrariesandtypes(BalanceDelta,
BalanceSwapDelta,CurrencyDelta,NonZeroDeltaCount)forflawsduetothe
useofinlineassembly,specificallythecorrectuseofarithmetic-relatedinline
assemblyoperations.
Wealsotestedflashaccountingusingstatefulinvarianttesting(UNI-SETTLE-1
throughUNI-SETTLE-13).
● (Dynamic)LPfees.WhereasUniswapv3hadalimitedsetofpossibleLPfeetiers,
Uniswapv4allowsapooltosetanarbitraryLPfeeupto100%.Apoolcanchooseto
setastaticLPfeeoradynamicLPfeeduringpoolcreation.Inthecaseofadynamic
LPfee,thepool’sconfiguredHookscontractcanatanypointupdatetheLPfeeby
callingupdateDynamicLPFee.
WemanuallyreviewedtheupdateDynamicLPFeefunction,LPFeeLibrary,and
theLPfee-relatedvalidationinsidetheHooks.initializefunctiontolookfor
waystoconfigureaninvalidLPfee.Wealsoreviewedthecorrectapplicationofthe
staticanddynamicLPfeeintheswapfunction.
● Protocolfees.AnoptionalprotocolfeecanbeenabledbytheUniswapteam
throughaconfiguredProtocolFeeControllercontract.
Wemanuallyreviewedtheaccesscontrolsonthefunctionsthatupdateandcollect
theprotocolfee.Welookedforwaysinwhichamalicious
ProtocolFeeControllercontractcouldleadtoaDoS.Wealsoreviewedtheuse
ofinlineassembly(TOB-UNI4-4)andthecorrecthandlingofthelow-levelcallresult.
Wereviewedtheeffectofwithdrawingtheprotocolfeewhilethecontractis
unlocked(TOB-UNI4-3).
Wealsotestedprotocolfeesusingstatefulinvarianttesting,focusingonassessing
whetherthesingletoncontractalwayscontainsenoughfundstocoveroutstanding
protocolfeedebts(UNI-ACTION-6,UNI-ACTION-3).
● NativeETHsupport.Uniswapv4addedbacksupportfornativeETHinsteadofonly
WETH.
WeverifiedthatETHiscorrectlyhandledasaparticularcaseinalltransfer-related
functions.WelookedforawaytouseETHtosettleanoutstandingERC20debitand
viceversa.
● Singletonpoolcontract.ThePoolManagerinUniswapv4isacrucialcomponent
andprovidesanentrypointtotheprotocol.Itmaintainsthestateofthepoolsand
incorporateslifecyclefunctionslikeinitialize,whichconfiguresanewpool;
TrailofBits 12 Uniswapv4CoreSecurityAssessment
PUBLIC

swap,whichfacilitatestheexchangeofcurrencieswithinapool;and
modifyLiquidity,whichallowsmodificationsintheliquidityprovided.The
balancefunctionsconsistofmintandburn,exclusivelydealingwiththecreation
anddestructionofERC6909claims;take,forwithdrawingaspecificamountof
currency;andsettle,forcompensatingoutstandingbalances.
Wemanuallyreviewedwhetherthepoolinitializationisdonecorrectly;whether
criticalstoragevariablesareupdatedfollowinganuntrustedexternalcallthatcould
beabusedusingreentrancy;andwhetherthecurrencydeltasforthevariousactions
(swaps,liquiditymodifications,mint,take,etc.)arecorrectlyupdated.Wealso
examinedthepotentialforanattackertoabusethepoolIDgeneration
(TOB-UNI4-6).Furthermore,weexploredwhetheramalicioususercouldcreatea
duplicatepoolandoverwritetheexistingliquidity.Wealsoassessedwhetherthe
accesscontrolchecksforthecriticalfunctionsinthePoolManagercontractare
properlyimplementedandifsufficienteventsareemitted(TOB-UNI4-5).Weuseda
staticinvarianttoensurethatonlythesettleandsettleForfunctionsare
payable(seeAutomatedTesting:StaticInvariants).Weadditionallyusedextensive
statefulinvariantstotestthevariousactionsinthePoolManager(seeAutomated
Testing:StatefulInvariants).
● ERC6909.ThisisanimplementationoftheERC6909proposal(whichitselfisbased
onERC1155,i.e.,amulti-tokencontract).TheERC6909contractisusedtooptionally
storeuserbalancesinternallyinsteadoftransferringERC20tokens.Userscanthen,
lateron,usetheirERC6909balanceinsteadoftransferringtokens.
Weusedmanualreviewtolookforcommontoken-relatedflaws,comparedthe
implementationagainstthereferenceimplementation,andreviewedthecorrect
updatingofaccountdeltaswhenusingtheERC6909mintandburnfunctionswithin
thePoolManager.
● Arithmetic.Uniswapv4reusesthemathfromUniswapv3.However,thehigh-level
Solidityimplementationis(mostly)rewritteninlow-levelinlineassembly(Yul).
Wemanuallyreviewedthemath-relatedlibraries,focusingonthedifferences
betweenUniswapv3andUniswapv4(i.e.,therewriteintoinlineassembly).We
additionallyusedstatelessfuzzingonvariousmathfunctionality(seeAutomated
Testing:StatelessInvariants)anddifferentialfuzztestingtocomparetheBitMath,
FullMath,andLiquidityMathlibraries(seeAutomatedTesting:Differential
testingbetweenv3andv4).WealsouseddifferentialtestingbetweentheUniswap
inlineassemblyimplementationandarewriteinhigh-levelSolidity(seeAutomated
Testing:Differentialtestingbetweenlow-levelcodeandhigh-levelimplementations).
● Transientstorage.Uniswapv4usestransientstorageinmultiplecontracts/libraries
(Exttload,CurrencyDelta,CurrencyReserves,andNonZeroDeltacount).
TrailofBits 13 Uniswapv4CoreSecurityAssessment
PUBLIC

Transientstorageisusedtostoredatathatshouldpersistbetweendifferentcall
framesbutnotbeyondthecurrenttransaction.Usingtransientstorageforthese
lowersthegascostcomparedtosettingandclearingstoragevariables.
Wemanuallyreviewedthecorrectusageoftransientstorage,lookingforflaws
relatedto:incorrectvalidationofsetvalues,notcorrectlymaskingsetvalues,
incorrectlyoverwritingexistingvalues,notclearingoutpreviouslysetvalues,and
reusingsettransientstoragevaluesacrossmultiplecallframesthatareindividual
actions.
● Donationattacks.Wemanuallyreviewedthecodetodeterminewhetherany
donationattacksarepresentthatmaycausethefeesearnedcomputationto
overflow,oralternativelycausethefeeGrowthGlobaltounderflow.Welookedat
possibilitiesofmanipulatingfeegrowthorcurrencydeltatostealtokensusingthe
donationfunction.Wealsoconsideredtheuseoffaketokenstocreateamalicious
pooltomanipulatereservesorfeesofotherlegitimatepoolsusingdonations.In
additiontomanualreview,wewroteseveralinvariantsthatwoulddetectpotential
issueswithfeeGrowthGlobalunderflows(UNI-DONATE-1throughUNI-DONATE-9).
Coverage Limitations
Thefollowingitemswereconsideredoutofscopeforthisengagement:
● Issuespreviouslyfoundinotherauditsthatwerenotfixedinthetargetcommitof
thisengagement.
● IssuesalreadyknowntotheUniswapteamandpresentinaGitHubissue/PRinthe
Uniswapv4repo.
TrailofBits 14 Uniswapv4CoreSecurityAssessment
PUBLIC

| Automated | Testing |     |
| --------- | ------- | --- |
TrailofBitsusesautomatedtechniquestoextensivelytestsoftware'ssecurityproperties.
Weuseopen-sourcestaticanalysisandfuzzingutilities,alongwithtoolsdeveloped
in-house,toperformautomatedtestingofsourcecodeandcompiledsoftware.
| Test Harness | Configuration |     |
| ------------ | ------------- | --- |
Weusedthefollowingtoolsintheautomatedtestingphaseofthisproject:
| Tool | Description | Policy |
| ---- | ----------- | ------ |
Echidna Asmartcontractfuzzerthatcanrapidlytest 400,000,000runs,split
|     | securitypropertiesviamalicious,   | acrossfourmachineswitha |
| --- | --------------------------------- | ----------------------- |
|     | coverage-guidedtestcasegeneration | maximumsequencelength   |
of150.(Approximately24
hours)
Medusa Across-platformgo-ethereum-basedfuzzer 800,000,000runs,split
providingparallelizedfuzztestingofsmart acrossfourmachineswitha
|     | contracts,heavilyinspiredbyEchidna | maximumsequencelength |
| --- | ---------------------------------- | --------------------- |
of150.(Approximately24
hours)
Slither Astaticanalyzerplatformusedtowritecustom Noexplicitlypolicyasthe
|     | staticinvariants | rulescreatedrunundera |
| --- | ---------------- | --------------------- |
fewseconds(AppendixE)
Halmos AsymbolictestingtoolforEVMsmartcontracts Timeoutof2hours
TrailofBits
15 Uniswapv4CoreSecurityAssessment
PUBLIC

| Summary of             | Invariants |                     |             |
| ---------------------- | ---------- | ------------------- | ----------- |
| Component              |            | InvariantType       | TotalNumber |
| Poolinitialization     |            | Statefulinvariants  | 10          |
| Swapaction             |            | Statefulinvariants  | 24          |
| Donateaction           |            | Statefulinvariants  | 9           |
| Settlementactions      |            | Statefulinvariants  | 13          |
| Modifyliquidityaction  |            | Statefulinvariants  | 11          |
| Takeaction             |            | Statefulinvariants  | 3           |
| End-to-endproperties   |            | Statefulinvariants  | 3           |
| Inter-Actionproperties |            | Statefulinvariants  | 6           |
| ProtocolFeeLibrary     |            | Statelessinvariants | 2           |
| LiquidityMath          |            | Statelessinvariants | 2           |
DifferentialfuzzingbetweenV3andV4math Statelessdifferentialinvariants 5
libraries
Differentialtestingbetweenlow-levelcode Statelessdifferentialinvariants 8
andhigh-levelimplementations
| PoolManagerandHooks |     | Staticinvariants | 4   |
| ------------------- | --- | ---------------- | --- |
| Stateful Invariants |     |                  |     |
PoolInitialization
| ID  | Property |     | Result |
| --- | -------- | --- | ------ |
UNI-INIT-1 initialize()shouldnotrevertwhenitispassedavalidsetof Passed
parameters(tickspacing,price,fee,poolkey,non-existingpool).
UNI-INIT-2 initialize()mustnotthrowPoolAlreadyInitialized()when Passed
thereisnopre-existingpoolinitializedwiththesamePoolKey.
UNI-INIT-3 initialize()mustnotthrowInvalidSqrtPrice()when Passed
providedapricewithinthevalidrange.
UNI-INIT-4 initialize()mustnotthrowLPFeeTooLarge()whenthefeeisin Passed
TrailofBits
16 Uniswapv4CoreSecurityAssessment
PUBLIC

thevalidrange.
UNI-INIT-5 initialize()mustnotthrowTickSpacingTooLarge()whenthe Passed
tickspacingisinthevalidrange.
UNI-INIT-6 initialize()mustnotthrowTickSpacingTooSmall()whenthe Passed
tickspacingisinthevalidrange.
UNI-INIT-7 initialize()mustrevertiftheprovidedpoolkeyisalready Passed
initialized.
UNI-INIT-8 initialize()mustconstructapoolwhosetickisgreaterthanor Passed
equaltoMIN_TICK.
UNI-INIT-9 initialize()mustconstructapoolwhosetickislessthanorequal Passed
toMAX_TICK.
UNI-INIT-10 initialize()mustnevercreateapoolwithaninitialsqrtPriceof Passed
zero.
SwapAction
ID Property Result
UNI-SWAP-1 Afteraswap,ifthepool’sactivetickdidnotchange,itsliquiditymust Passed
bethesameasitwasbeforetheswap.
UNI-SWAP-2 Thepool’ssqrtPriceX96shoulddecreaseorstaythesameafter Passed
makingazeroForOneswap.
UNI-SWAP-3 Thepool’ssqrtPriceX96shouldincreaseorstaythesameafter Passed
makingaoneForZeroswap.
UNI-SWAP-4 Thepool’snewsqrtPriceX96mustnotbelowerthanthe Passed
transaction'spricelimitaftermakingazeroForOneswap.
UNI-SWAP-5 Thepool’snewsqrtPriceX96mustnotexceedthetransaction'sprice Passed
limitaftermakingaoneForZeroswap.
UNI-SWAP-6 Thepool’sactivetickshoulddecreaseorstaythesameaftermaking Passed
azeroForOneswap.
UNI-SWAP-7 Thepool’sactivetickshouldincreaseorstaythesameaftermakinga Passed
oneForZeroswap.
UNI-SWAP-8 AfterazeroForOneswap,thefeegrowthforcurrency1shouldnot Passed
change.
TrailofBits 17 Uniswapv4CoreSecurityAssessment
PUBLIC

UNI-SWAP-9 AfteraoneForZeroswap,thefeegrowthforcurrency0shouldnot Passed
change.
UNI-SWAP-10 Theswapactionmustrevertiftheswapamountiszero. Passed
UNI-SWAP-11 Thepool’snewpriceafteraswapmustbelessthan Passed
MAX_SQRT_PRICE.
UNI-SWAP-12 Thepool’snewpriceafteraswapmustbegreaterthanorequalto Passed
MIN_SQRT_PRICE.
UNI-SWAP-13 Thepool’snewtickafteraswapmustbelessthanorequalto Passed
MAX_TICK.
UNI-SWAP-14 Thepool’snewtickafteraswapmustbegreaterthanorequalto Passed
MIN_TICK.
UNI-SWAP-15 SwapsrespectthesqrtPriceLimitaheadoftheneedtoconsume Passed
exactInputorexactOutput.
UNI-SWAP-16 Forexactinputswapswherethepricelimitisnotreached,the Passed
fromBalanceDeltamustmatchtheexactinputamount.
UNI-SWAP-17 Forexactoutputswapswherethepricelimitisnotreached,the Passed
toBalanceDeltamustmatchtheexactoutputamount.
UNI-SWAP-18 IfthefromBalanceDeltaofaswapiszero,thetoBalanceDelta Passed
mustalsobezero(rounding).
UNI-SWAP-19 Foranyswap,theamountcreditedtotheuserisgreaterthanor Passed
equaltozero.
UNI-SWAP-20 Foranyswap,theamountdebitedfromtheuserisgreaterthanor Passed
equaltozero.
UNI-SWAP-21 ForazeroForOneswap,theamountcreditedtotheusermustbe Passed
lessthanorequaltothetotalnumberoftradeabletokensinthe
pool.
UNI-SWAP-22 ForaoneForZeroswap,theamountcreditedtotheusermustbe Passed
lessthanorequaltothetotalnumberoftradeabletokensinthe
pool.
UNI-SWAP-23 Afteraswap,theuser’scurrencyDeltaforamount0shouldmatch Passed
theexpecteddeltabasedonBalanceDelta.
UNI-SWAP-24 Afteraswap,theuser’scurrencyDeltaforamount1shouldmatch Passed
theexpecteddeltabasedonBalanceDelta.
TrailofBits 18 Uniswapv4CoreSecurityAssessment
PUBLIC

DonateAction
ID Property Result
UNI-DONATE-1 Afteradonationwithanon-zeroamount0,thepool’s Passed
feeGrowthGlobal0X128shouldmatchtheexpectedvaluebased
ondonate()’sinputs.
UNI-DONATE-2 Afteradonationwithanon-zeroamount1,thepool’s Passed
feeGrowthGlobal1X128shouldmatchtheexpectedvaluebased
ondonate()’sinputs.
UNI-DONATE-3 Afteradonationwithazeroamount0,thepool’s Passed
feeGrowthGlobal0X128shouldnotchange.
UNI-DONATE-4 Afteradonationwithazeroamount1,thepool’s Passed
feeGrowthGlobal1X128shouldnotchange.
UNI-DONATE-5 Donatingtoapoolwithzeroliquidityshouldresultinarevert. Passed
UNI-DONATE-6 Adonate()callmustnotreturnapositiveBalanceDeltafor Passed
currency0.
UNI-DONATE-7 Adonate()callmustnotreturnapositiveBalanceDeltafor Passed
currency1.
UNI-DONATE-8 Thedonate()callBalanceDeltamustmatchtheamount Passed
donatedforamount0.
UNI-DONATE-9 Thedonate()callBalanceDeltamustmatchtheamount Passed
donatedforamount1.
SettlementActions
ID Property Result
UNI-SETTLE-1 Theusermustnotbeowedmoretokensafterasettle()or Passed
settleFor()thantheywereowedbeforethesettlement.
UNI-SETTLE-2 Theamountpaidduringasettle()orsettleFor()mustequal Passed
thedifferenceintheuser'scurrencydeltasbeforeandafterthe
settle()call.
UNI-SETTLE-3 Theamountpaidduringasettle()orsettleFor()mustequal Passed
theremittancespaidtothesingleton.
UNI-SETTLE-4 Afteraburn,thesender’scurrencydeltashouldincreasetoreflect Passed
thedecreaseddebt.(Weak)
TrailofBits 19 Uniswapv4CoreSecurityAssessment
PUBLIC

UNI-SETTLE-5 Afteraburn,thedifferencebetweenthesender’spreviousand Passed
newcurrencydeltashouldequaltheburnamount.Thisisastrong
versionofUNI-SETTLE-4.
UNI-SETTLE-6 Afteraburn,thefromactor’sERC6909balanceshoulddecreaseto Passed
reflecttheburnedamount.(Weak)
UNI-SETTLE-7 Afteraburn,thedifferencebetweenthefromactor’spreviousand Passed
newERC6909balanceshouldequaltheburnamount.Thisisa
strongversionofUNI-SETTLE-6.
UNI-SETTLE-8 Afteramint,thesender’scurrencydeltashoulddecreasetoreflect Passed
increaseddebt.(Weak)
UNI-SETTLE-9 Afteramint,thedifferencebetweenthesender’spreviousandnew Passed
currencydeltashouldmatchthemintamount.Thisisastrong
versionofUNI-SETTLE-8.
UNI-SETTLE-10 Afteramint,therecipient’sERC6909balanceshouldincrease. Passed
(Weak)
UNI-SETTLE-11 Afteramint,therecipient’sERC6909balanceshouldincreaseby Passed
themintamountThisisastrongversionofUNI-SETTLE-10.
UNI-SETTLE-12 Afteraclear,theactor’scurrencydeltashouldgodownorbeequal Passed
tozero.(Weak)
UNI-SETTLE-13 Afteraclear,theactor’scurrencydeltashouldequaltheamount Passed
cleared.ThisisastrongversionofUNI-SETTLE-12.
ModifyLiquidityAction
ID Property Result
UNI-MODLIQ-1 Foraspecificposition,getPositionInfomustreturnthesame Passed
liquidityasgetPosition.
UNI-MODLIQ-2 Foraspecificposition,getPositionInfomustreturnthesame Passed
feeGrowthInside0asgetPosition.
UNI-MODLIQ-3 Foraspecificposition,getPositionInfomustreturnthesame Passed
feeGrowthInside1asgetPosition.
UNI-MODLIQ-4 Theamount0offeesaccruedfrommodifyPosition()mustbe Passed
non-negative.
UNI-MODLIQ-5 Theamount1offeesaccruedfrommodifyPosition()mustbe Passed
non-negative.
TrailofBits 20 Uniswapv4CoreSecurityAssessment
PUBLIC

UNI-MODLIQ-6 Thesingletonmustbeabletocredittheuserfortheir Passed
feesAccrued.amount0.
UNI-MODLIQ-7 Thesingletonmustbeabletocredittheuserfortheir Passed
feesAccrued.amount1.
UNI-MODLIQ-8 Thepoolmusthaveenoughcurrency0toreturntheLP'sliquidity Passed
balance.
UNI-MODLIQ-9 Thepoolmusthaveenoughcurrency1toreturntheLP'sliquidity Passed
balance.
UNI-MODLIQ-10 Thesingletonmusthaveenoughcurrency0toreturntheLP’s Passed
liquiditybalance.
UNI-MODLIQ-11 Thesingletonmusthaveenoughcurrency1toreturntheLP’s Passed
liquiditybalance.
TakeAction
ID Property Result
UNI-TAKE-1 Afterexecutingtake(),theuser'scurrencyDeltashouldbethe Passed
differencebetweentheirpreviousdeltaandtheamounttaken.
UNI-TAKE-2 Afterexecutingtake(),theuser'sbalanceshouldincreasebythe Passed
amounttaken.
UNI-TAKE-3 Afterexecutingtake(),thesingleton'sbalanceshoulddecreaseby Passed
theamounttaken.
End-to-EndProperties
ID Property Result
UNI-E2E-1 Outstandingdeltasmustbezeroafterthesingletonisre-locked. Passed
UNI-E2E-2 Whenswappingthroughapairinonedirection,thenswappingin Passed
theoppositedirection,theusermustnothavemorefromTokens
thantheystartedwith.
UNI-E2E-3 Whenswappingthroughapairinonedirection,thenswappingin Passed
theoppositedirection,theusermustnothavemoretoTokens
thantheystartedwith.
TrailofBits 21 Uniswapv4CoreSecurityAssessment
PUBLIC

Inter-ActionProperties
| ID  | Property |     |     | Result |
| --- | -------- | --- | --- | ------ |
UNI-ACTION-1 Theamountowedtoanactorinasingle-actorsystemmustalways Passed
belessthanorequaltothebalanceofthesingleton.(Weak)
UNI-ACTION-2 Theamountowedtoanactorinasingle-actorsystemmustalways Passed
belessthanorequaltothebalanceofthesingleton,lessprotocol
feesandLPfees.(Strong)
UNI-ACTION-3 Theamountofprotocolfeesowedmaynotexceedthesingleton’s Passed
balance(lessitsdeployedliquidity)whilethecurrencyhasapositive
orzerodelta.
UNI-ACTION-4 Anactor’sdebiteddeltamustnotexceedint256.maxforany Passed
singleaction.
UNI-ACTION-5 Anactor’screditeddeltamustnotexceedint256.maxforany Passed
singleaction.
UNI-ACTION-6 collectProtocolFees()mustnotrevertonvalidinput. Passed
| Stateless Invariants |     |     |     |     |
| -------------------- | --- | --- | --- | --- |
ProtocolFeeLibrary
| ID            | Property                    |     |     | Result   |
| ------------- | --------------------------- | --- | --- | -------- |
| UNI-PROTOFEE- | Theswapfeecannotexceed100%. |     |     | Verified |
1
UNI-PROTOFEE- ValidProtocolFeeisequivalenttogetZeroForOneFee(self) <= Verified
| 2   | MAX_PROTOCOL_FEE | && getOneForZeroFee(self) | <=  |     |
| --- | ---------------- | ------------------------- | --- | --- |
MAX_PROTOCOL_FEE.
LiquidityMath
| ID            | Property                             |     |     | Result   |
| ------------- | ------------------------------------ | --- | --- | -------- |
| UNI-LIQMATH-1 | addDeltaincreases/decreasesbasedony. |     |     | Verified |
UNI-LIQMATH-2 addDeltarevertsifitunderflows/overflows. Verified
TrailofBits
22 Uniswapv4CoreSecurityAssessment
PUBLIC

Di erentialTestingbetweenV3andV4
TochecktheequivalenceoftheV3components(Solidity0.7)againsttheirV4counterparts
(Solidity0.8),weimplementedaharnessusingabytecode-baseddifferentialtesting
approach.WecompiledtheV3libraryusingSolidity0.7,anddeployedtheirrawbytecodes
inaharnesscompiledwithSolidity0.8,allowingustocomparebothversions.
ID Property Result
UNI-DIFFV3-1 FullMath.mulDiv()behavesthesameonV3andV4. Verified
UNI-DIFFV3-2* FullMath.mulDivRoundingUp()behavesthesameonV3and Passed
V4. (*)
UNI-DIFFV3-3 BitMath.mostSignificantBit()behavesthesameonV3and Verified
V4.
UNI-DIFFV3-4 BitMath.leastSignificantBit()behavesthesameonV3and Verified
V4.
UNI-DIFFV3-5 LiquidityMath.addDeltabehavesthesameonV3andV4. Verified
(*)UNI-DIFFV3-2couldnotbeverifiedbyHalmos(timeouttwohours)andwascheckedwithEchidna
(500,000calls).
Di erentialTestingbetweenLow-LevelCodeandHigh-LevelImplementations
Toverifytheequivalencebetweenlow-level(assembly)gas-optimizedimplementationsand
theirhigh-levelcounterparts,afuzzingharnesswasadded.Functionsinthiscontract
containsnippetsoffunctionsusingassemblyfromUniswapV4,andimplementationsofthe
samefunctionsusingpureSolidity.
Wherepossible,theSolidityequivalentsweretakenfromthecommentsoftheassembly
implementations,andintheremainingcases,thecodewasreconstructedfromthe
intendedgoalofthefunction.
ID Property Result
UNI-LOWLEVEL- Low-levelimplementationofPosition.get()shouldmatchits Passed
1 high-levelimplementation.
UNI-LOWLEVEL- Low-levelimplementationofCurrencyDelta.computeSlot() Passed
2 shouldmatchitshigh-levelimplementation.
UNI-LOWLEVEL- Low-levelimplementationofLiquidityMath.addDelta()should Passed
3 matchitshigh-levelimplementation.
TrailofBits 23 Uniswapv4CoreSecurityAssessment
PUBLIC

| UNI-LOWLEVEL- | Low-levelimplementationof                          |     | Passed |
| ------------- | -------------------------------------------------- | --- | ------ |
| 4             | Pool.tickSpacingToMaxLiquidityPerTick()shouldmatch |     |        |
itshigh-levelimplementation.
| UNI-LOWLEVEL- | Low-levelimplementationof                          |     | Passed |
| ------------- | -------------------------------------------------- | --- | ------ |
| 5             | ProtocolFeeLibrary.isValidProtocolFee()shouldmatch |     |        |
itshigh-levelimplementation.
| UNI-LOWLEVEL- | Low-levelimplementationof                           |     | Passed |
| ------------- | --------------------------------------------------- | --- | ------ |
| 6             | ProtocolFeeLibrary.calculateSwapFee()shouldmatchits |     |        |
high-levelimplementation.
UNI-LOWLEVEL- Low-levelimplementationofSwapMath.getSqrtPriceTarget() Passed
| 7   | shouldmatchitshigh-levelimplementation. |     |     |
| --- | --------------------------------------- | --- | --- |
UNI-LOWLEVEL- Low-levelimplementationofTickBitmap.compress()should Passed
| 8   | matchitshigh-levelimplementation. |     |     |
| --- | --------------------------------- | --- | --- |
Static Invariants
Throughthereview,weidentifiedmultiplecodepatternsthatrequiretobeenforced
throughthecodebase.Toensuretheircorrectness,wewrotealintertoolbasedonslither.
Thefollowingcheckswereimplementedandwereallpassing:
| ID  | Property | Why | Result |
| --- | -------- | --- | ------ |
noSelfCall_shou Functionsthatuse Themodifierisano-op;anyreturn Passed
| ld_not_return | noSelfCalldonothave |     |     |
| ------------- | ------------------- | --- | --- |
variablewouldalwaysbeits
|     | anyreturnvariable | defaultvalue. |     |
| --- | ----------------- | ------------- | --- |
callHook Functionsthatcall Thisensuresthatthehookwillnot Passed
|     | callHookareprotected | re-entertoitself. |     |
| --- | -------------------- | ----------------- | --- |
againstself-calls
pool_manager_fu PoolManager’sfunctions Afunctioncollisioncouldleadto Passed
| nction_ids | donotcollidewiththe | settingahooktobethepool   |     |
| ---------- | ------------------- | ------------------------- | --- |
|            | Hooksfunction       | manageritselfandexecuting |     |
unexpectedcode(e.g.,havingthe
managerswapassets).
| pool_manager_pa | Onlysettle/settleFor |                             |        |
| --------------- | -------------------- | --------------------------- | ------ |
|                 |                      | Onlythesetwofunctionsshould | Passed |
| yable           | arepayableinthepool  | receivefunds.               |        |
manager
TrailofBits
24 Uniswapv4CoreSecurityAssessment
PUBLIC

Codebase Maturity Evaluation
TrailofBitsusesatraffic-lightprotocoltoprovideeachclientwithaclearunderstandingof
theareasinwhichitscodebaseismature,immature,orunderdeveloped.Deficiencies
identifiedhereoftenstemfromrootcauseswithinthesoftwaredevelopmentlifecyclethat
shouldbeaddressedthroughstandardizationmeasures(e.g.,theuseofcommonlibraries,
functions,orframeworks)ortrainingandawarenessprograms.
Category Summary Result
Arithmetic Newcompilerversionsareusedforthehigh-levelcode; Strong
therefore,allhigh-leveloperationsusechecked
arithmeticbydefault.Thelow-levelarithmeticiscorrect,
andtheresultsmatchtheirhigh-levelcounterparts.
Roundingdirectionsareconsideredandexplicitly
documented.Thereiswidespreadusageofunchecked
arithmetictomakethecodegas-efficient.However,
specialconsiderationismadeforoperationsthatcould
overfloworotherwiserevert,andedgecasesare
documented.
Auditing Ingeneral,eventsareproperlyemittedformostofthe Satisfactory
statechangesandothercriticalfunctions.However,we
foundafewinstances(TOB-UNI4-5)wheretheeventis
missing.
Authentication/ Theprotocolfeescontract,usedtoestablishandcollect Satisfactory
AccessControls thefeesbelongingtotheprotocol,isprivileged.Access
controlisimplemented.However,thereisnotwo-step
proceduretochangeownership.Thereisnoindicationof
multisignatureorhardwarekeyusagefortheprivileged
address.
Complexity Ingeneral,functionsfollowtheestablishedgood Moderate
Management practices:theyareshort,havelittleornoredundancyor
duplication,andhaveaclearandlimitedscope.The
namingschemeisalsoclear.
Giventheoptimizationsinthecode,assemblycodeis
extensivelyused,anditcansometimesbequitecomplex
tofolloworanalyze.Somefunctionsdonotvalidateinput
parameterstosavegas(forexample,therearenozero
TrailofBits 25 Uniswapv4CoreSecurityAssessment
PUBLIC

addresschecksinthecode;seeCodeQuality).
Thereareseveralusagesofcustomtypesand
user-definedoperatorsthatsimplifytheunderstanding
offunctionsandcontracts.
Allthesepointscanimpacttheonboardingofnew
developerstotheteam:thecomplexityofthesystemand
thelow-leveloptimizationsmakeasteeplearningcurve,
anditishighlylikelythataninexperienceddeveloperwill
introducebugsinadvertently.
Decentralization Theprotocolisbuilttobedecentralized.Theonly Strong
privilegedaccessfunctionsaretheonesrelatedtothe
protocolfees,whicharecappedatmax0.1%iftheywere
tobeenabled.
Documentation Thedocumentationclearlyshowsthedifferences Satisfactory
betweenV3andV4andusesdiagramstosummarize
information.Readingthedocumentationcanhelpone
gainahigh-levelunderstandingofhowthedifferent
systemcomponentsinV4work.Developersintegrating
withUniswapV4havecodesnippetsandexamples.
NotallcontractsarecoveredinV4docs.
Codedocumentationisextensive,bothinNatSpecand
in-linecomments.
Aminordeviationbetweendocumentationandcodewas
foundintheHookslibrary.SeetheCodeQuality
appendix.
Low-Level Assemblyandlow-levelstructuresareusedextensivelyto Satisfactory
Manipulation savegas.Low-levelblockscommonlyreimplement
higher-levelcode.
Assemblyusageiscorrect.MostblockshaveaNatSpecor
inlinedocumentationspecifyingwhatthecodeisdoing,
howitisimplemented,andwhatthehigher-level
equivalencewouldbe.Statelessfuzztestsshowedthat
bothresultsmatchforseveralfunctions.
Inothercases,wherethecodeisborrowedfromother
projects,thisisdocumented,andlinkstotheoriginal
TrailofBits 26 Uniswapv4CoreSecurityAssessment
PUBLIC

repositoriesareprovided.
Somearithmeticoperationsarealsofullyimplementedin
assembly.
Testingand Atotalof590testswereprovided.Thetestsuiteruns Satisfactory
Verification “outofthebox,”andtherearenofailingtests.However,
testcoverageisnot100%forsomefilesandfunctions.
Contractsandlibrarieshaveunitaryandbasicfuzzing
tests.ThetestsrunintheCI/CDpipelinefornewpull
requestsandmergeoperations.Additionally,forgetest
coverageisintegratedintheCIanddisplayedineachPR.
Transaction Thelock/unlockmechanismmakesallactionsinsidea Satisfactory
Ordering transactionatomic,minimizingtherisksoffront-running
andmaliciousMEVactors.
Theonlytransactionorderingriskpresentinthe
codebaseisconsideredoutofscope,asitwasalready
reportedandconsistsoffront-runningthepool
initializationtransaction.
TrailofBits 27 Uniswapv4CoreSecurityAssessment
PUBLIC

Summary of Findings
Thetablebelowsummarizesthefindingsofthereview,includingtypeandseveritydetails.
| ID Title | Type | Severity |
| -------- | ---- | -------- |
1 Strictequalityonfeecomparisoncancausefees DataValidation Informational
toexceed100%
2 Incorrectvariableusageonswapfee DataValidation Informational
| 3 Collectedprotocolfeesmaycountagainstuser’s | Undefined | Low |
| -------------------------------------------- | --------- | --- |
| currencydeltas                               | Behavior  |     |
4 Useofincorrectmasktoclearhigherbitsofthe DataValidation Informational
protocolFeevalue
| 5 Insufficienteventgeneration | Auditingand | Informational |
| ----------------------------- | ----------- | ------------- |
Logging
6 Similar-lookingpoolIDscanbebrute-forced Undefined Informational
| throughthePoolKeyhooksfields | Behavior |     |
| ---------------------------- | -------- | --- |
TrailofBits
28 Uniswapv4CoreSecurityAssessment
PUBLIC

| Detailed | Findings |     |     |
| -------- | -------- | --- | --- |
1.Strictequalityonfeecomparisoncancausefeestoexceed100%
| Severity:Informational |     | Difficulty:High      |     |
| ---------------------- | --- | -------------------- | --- |
| Type:DataValidation    |     | FindingID:TOB-UNI4-1 |     |
Target:libraries/Pool.sol
Description
Theusageofstrictequalityonthemaxfeevalidationcanleadtoacceptanceofanincorrect
fee.
Whenperformingaswap,thefeecomprisesaprotocolandanLPfee,andiscalculated
throughthecalculateSwapFeefunction:
swapFee = protocolFee == 0 ? lpFee : uint16(protocolFee).calculateSwapFee(lpFee);
Figure1.1:src/libraries/Pool.sol#L307
swapFeeisrepresentedasapercentage.Itischeckedtonotbeequalto100%
(MAX_LP_FEE):
| if (swapFee | == LPFeeLibrary.MAX_LP_FEE | && !exactInput) | {   |
| ----------- | -------------------------- | --------------- | --- |
InvalidFeeForExactOut.selector.revertWith();
}
Figure1.2:src/libraries/Pool.sol#L312-L314
Duetotheusageofastrictequality(==),ifthefeeexceeds100%,thevalidationpasses,
causingthefeetobegreaterthanexpected.
Notethattheissueisnotcurrentlyexploitable,as:
● Wecouldnotfindarealisticwaytoincreasethefeeabove100%.
● ThefollowingoperationsincomputeSwapStepwouldrevert(e.g.,:MAX_FEE_PIPS
| - _feePips). |     |     |     |
| ------------ | --- | --- | --- |
Thisissue’sseveritycanbehigherifcombinedwithTOB-UNI4-2.
TrailofBits
|     |     | 29  | Uniswapv4CoreSecurityAssessment |
| --- | --- | --- | ------------------------------- |
PUBLIC

Recommendations
Shortterm,use>=insteadof==whencomparingtheswapfeeagainstitsmaxvalue.
Longterm,createtestsforwhichthedifferentfeelimitsarenotsetto100%.
TrailofBits 30 Uniswapv4CoreSecurityAssessment
PUBLIC

2.Incorrectvariableusageonswapfee
| Severity:Informational |     |     |     | Difficulty:High      |     |
| ---------------------- | --- | --- | --- | -------------------- | --- |
| Type:DataValidation    |     |     |     | FindingID:TOB-UNI4-2 |     |
Target:libraries/Pool.sol
Description
TheswapfeeiscomparedagainstthemaxLPfeeconstantinsteadofthemaxswapfee
constant.
Theswapfeeiscomposedoftwocomponents:theprotocolfeeandtheLPfee.swapFeeis
representedasapercentage.Itischeckedtonotbeequalto100%:
| if (swapFee | == LPFeeLibrary.MAX_LP_FEE |     | &&  | !exactInput) | {   |
| ----------- | -------------------------- | --- | --- | ------------ | --- |
InvalidFeeForExactOut.selector.revertWith();
}
Figure2.1:src/libraries/Pool.sol#L312-L314
However,thevariableusedforthecomparisonisthemaxLPfee(MAX_LP_FEE)insteadof
themaxswapfee(MAX_FEE_PIPS):
/// @notice the lp fee is represented in hundredths of a bip, so the max is 100%
| uint24 public | constant | MAX_LP_FEE | = 1000000; |     |     |
| ------------- | -------- | ---------- | ---------- | --- | --- |
Figure2.2:src/libraries/LPFeeLibrary.sol#L24-L25
| library SwapMath | {        |                       |     |        |     |
| ---------------- | -------- | --------------------- | --- | ------ | --- |
| uint256          | internal | constant MAX_FEE_PIPS |     | = 1e6; |     |
Figure2.3:src/libraries/SwapMath.sol#L9-L10
Bothconstantshavethesamevalue(10**6),sothisissueisnotanimmediatethreattothe
protocol.However,thisissue’sseveritywouldbehigherifcombinedwithTOB-UNI4-1.
Exploitscenario
TheLPfeeisupdatedtobeatmaximum10%,andtheprotocolfeeisexpectedtobe5%.As
theswapfeeiscappedattheLPfeeamount(10%),theswapfeeisincorrect.
Recommendations
Shortterm,useSwapMath.MAX_FEE_PIPSinsteadofLPFeeLibrary.MAX_LP_FEEwhen
comparingtheswapfeeagainstitsmaxvalue.
TrailofBits
|     |     |     |     | 31  | Uniswapv4CoreSecurityAssessment |
| --- | --- | --- | --- | --- | ------------------------------- |
PUBLIC

Longterm,createtestsforwhichthedifferentfeelimitsarenotsetto100%.
TrailofBits 32 Uniswapv4CoreSecurityAssessment
PUBLIC

3.Collectedprotocolfeesmaycountagainstuser’scurrencydeltas
Severity:Low Difficulty:High
Type:UndefinedBehavior FindingID:TOB-UNI4-3
Target:PoolManager.sol
Description
Uniswapv4’sprotocol-levelfeecollectionoperatesoutsideofthecurrencyDeltamodel
usedbytherestoftheprotocol.Thiscreatesanopportunityforerroneoussettle
calculationsifprotocolfeecollectionisperformedaftersynciscalled,ultimatelyleadingto
anunexpectedrevert.
Whenauserconductsaswap,positionadjustment,orotheraction,itgenerates
currencyDeltasforthatusertorepresenttheamountowedtotheuserorowedtothe
protocol.ThesecurrencyDeltasareclearedbycallingsync(currency),payingthe
amountofdebtowed,thencallingsettle.
Thesyncandsettlefunctionsdeterminehowmuchtheuserhaspaidbycomparingthe
differencebetweencurrency.balanceOfSelfwhenbothsyncandsettlearecalled.If
theusercallscollectProtocolFeesbetweensyncandsettle,theamountoffeespaid
totherecipientwillerroneouslycountagainsttheuser’scurrencyDelta,asiftheuser
hadcalledtakeormintfortheamountoffeespaid.
Exploitscenario
TheUniswapDAOvotestoturnontheprotocolfeeswitch,andcreatesacontractthatwill
harvestprotocolfeesandthenswapthemfortheUniswapProtocolgovernancetoken.The
contracterroneouslycallsthecollectProtocolFeesfunctionbetweensyncand
settle,andwhendetermininghowmuchneedstobepaidtosuccessfullysettlethe
transaction,itmanuallycalculatesthecurrencyDelta.
Inthissituation,thefeecollectionprocesseither:1.becomesano-opthatcollectsfeesand
burnsthembysendingthemtothev4singleton,or2.thetransactionreverts.
Recommendations
Shortterm,addaguardtothecollectProtocolFees()functiontopreventitfrombeing
calledwhilethecontractisunlocked,andaddaguardtosynctoensureitcanonlybe
calledwhenthesingletonisunlocked.Alternatively,addcommentsordocumentation
regardingthesafeuseofcollectPoolFees.
TrailofBits 33 Uniswapv4CoreSecurityAssessment
PUBLIC

Longterm,addstatefulpropertiestodetectthiskindofbalancetamperingattackinthe
future.
TrailofBits 34 Uniswapv4CoreSecurityAssessment
PUBLIC

4.UseofincorrectmasktoclearhigherbitsoftheprotocolFeevalue
Severity:Informational Difficulty:Low
Type:DataValidation FindingID:TOB-UNI4-4
Target:libraries/ProtocolFeeLibrary.sol
Description
ThecalculateSwapFeefunctionoftheProtocolFeeLibrarycontractusesanincorrect
maskof0xfffftoclearhigherbitsoftheprotocolFeevalue,whichisa12-bitvalue.
TheswapfunctionofthePoollibrarycontractloadstheprotocolfeefromthestorage
variableslot0ofthesingletoncontractandcallsoneofthegetZeroForOneFeeor
getOneForZeroFeefunctionstoobtaintheprotocolfeepercentagevalue:
uint256 protocolFee =
zeroForOne ? slot0Start.protocolFee().getZeroForOneFee() :
slot0Start.protocolFee().getOneForZeroFee();
Figure4.1:libraries/Pool.sol#L291-L292
ThegetZeroForOneFeefunctionoftheProtocolFeeLibrarycontractcapturesthe
lower12bitsofthestoragevalueandreturnstheminauint16typevalue:
function getZeroForOneFee(uint24 self) internal pure returns (uint16) {
return uint16(self & 0xfff);
}
Figure4.2:libraries/ProtocolFeeLibrary.sol#L17-L19
Next,theswapfunctionofthePoollibrarycontractcallsthecalculateSwapFeefunction
ontheprotocolFeevariableoftypeuint16tocomputetheswapfeeamount,combining
theprotocolfeeandliquidityproviderfee.However,thecalculateSwapFeefunction
assumesthevalueoftheselfvariable,whichistheprotocolFeevariable,tobeof16-bit
lengthinsteadof12-bitlengthandusesamaskof0xffffinsteadof0xffftoclearhigher
bitsoftheprovidedvalue:
function calculateSwapFee(uint16 self, uint24 lpFee) internal pure returns (uint24
swapFee) {
// protocolFee + lpFee - (protocolFee * lpFee / 1_000_000). Div rounds up to
favor LPs over the protocol.
assembly ("memory-safe") {
self := and(self, 0xffff)
TrailofBits 35 Uniswapv4CoreSecurityAssessment
PUBLIC

lpFee := and(lpFee, 0xffffff)
let numerator := mul(self, lpFee)
let divRoundingUp := add(div(numerator, PIPS_DENOMINATOR), gt(mod(numerator,
PIPS_DENOMINATOR), 0))
swapFee := sub(add(self, lpFee), divRoundingUp)
}
}
Figure4.3:libraries/ProtocolFeeLibrary.sol#L38-L47
Usageofanincorrectmaskdoesnotleadtoincorrectcalculationsorfinanciallossinthe
currentimplementationbecauseofcorrectmaskinginthegetZeroForOneFeeor
getOneForZeroFeefunctions.Itcouldleadtoahigherfeebeingchargedtotheuserifthe
calculateSwapFeefunctionwascalledonauint16valuethatdidnothaveitsupperfour
bitscleared.
Recommendations
Shortterm,usethecorrectmask0xffftoclearhigherbitsoftheprotocolFeevalueand
documentthisbehaviorininlinecodecomments.
Longterm,consideractuallimitsofvaluesinsteadofthetypeswhensanitizingthevalues
forarithmeticoperations.
TrailofBits 36 Uniswapv4CoreSecurityAssessment
PUBLIC

5.Insu cienteventgeneration
Severity:Informational Difficulty:Low
Type:AuditingandLogging FindingID:TOB-UNI4-5
Target:Various
Description
Multiplecriticaloperationsdonotemitevents.Asaresult,itwillbedifficulttoreviewthe
correctbehaviorofthecontractsoncetheyhavebeendeployed.
Eventsgeneratedduringcontractexecutionaidinmonitoring,baseliningofbehavior,and
detectionofsuspiciousactivity.Withoutevents,usersandblockchain-monitoringsystems
cannoteasilydetectbehaviorthatfallsoutsidethebaselineconditions;malfunctioning
contractsandattackscouldgoundetected.
Thefollowingoperationshouldtriggerevents:
● PoolManager
○ updateDynamicLPFee
Thefollowingoperationshouldmodifyevents:
● PoolManager
○ TheinitializefunctionshouldincludesqrtPriceX96asanevent
parameterifitemits.
Thefollowingoperationsmayalsobeconsideredtotriggerevents.Iftheydonot,they
shouldbedocumentedproperly.
● PoolManager
○ donate
○ settle
○ take
Recommendations
Shortterm,addeventsforalloperationsthatcouldcontributetoahigherlevelof
monitoringandalerting.Ifcertainoperationsarenotsetuptoemiteventstooptimizegas
usage,theyshouldbecomprehensivelydocumented.
Longterm,considerusingablockchain-monitoringsystemtotrackanysuspiciousbehavior
inthecontracts.Thesystemreliesonseveralcontractstobehaveasexpected.A
TrailofBits 37 Uniswapv4CoreSecurityAssessment
PUBLIC

monitoringmechanismforcriticaleventswouldquicklydetectanycompromisedsystem
components.
TrailofBits 38 Uniswapv4CoreSecurityAssessment
PUBLIC

6.Similar-lookingpoolIDscanbebrute-forcedthroughthePoolKeyhooks
fields
| Severity:Informational |     |     |     | Difficulty:High      |     |
| ---------------------- | --- | --- | --- | -------------------- | --- |
| Type:UndefinedBehavior |     |     |     | FindingID:TOB-UNI4-6 |     |
Target:types/PoolId.sol,types/PoolKey.sol
Description
Similar-lookingpoolIDscanbebrute-forcedbyusingthePoolKey.hooksfieldasanonce.
Attackerscouldusethistotrickusersintousingtheirmaliciouspools.Thisdoesnotaffect
theUniswapv4protocol;however,thisdoesimpactthird-partyintegrators,whichshould
trytominimizeusersfallingvictimtousingmaliciouspools.
PoolscanbefreelycreatedinUniswapv4throughthePoolManager.initialize
function.EachPoolhasfivefields(seefigure6.1),andthehashoftheseresultsinthepool’s
ID(seefigure6.2).
| 8 struct | PoolKey | {   |     |     |     |
| -------- | ------- | --- | --- | --- | --- |
9 /// @notice The lower currency of the pool, sorted numerically
| 10  | Currency | currency0; |     |     |     |
| --- | -------- | ---------- | --- | --- | --- |
11 /// @notice The higher currency of the pool, sorted numerically
| 12  | Currency | currency1; |     |     |     |
| --- | -------- | ---------- | --- | --- | --- |
13 /// @notice The pool swap fee, capped at 1_000_000. If the highest bit is
1, the pool has a dynamic fee and must be exactly equal to 0x800000
| 14  | uint24 | fee; |     |     |     |
| --- | ------ | ---- | --- | --- | --- |
15 /// @notice Ticks that involve positions must be a multiple of tick
spacing
| 16  | int24       | tickSpacing; |              |      |     |
| --- | ----------- | ------------ | ------------ | ---- | --- |
| 17  | /// @notice | The          | hooks of the | pool |     |
| 18  | IHooks      | hooks;       |              |      |     |
19 }
Figure6.1:ThePoolKeystructintypes/PoolKey.sol#L8-L19
| 9 library | PoolIdLibrary |     | {   |     |     |
| --------- | ------------- | --- | --- | --- | --- |
10 /// @notice Returns value equal to keccak256(abi.encode(poolKey))
11 function toId(PoolKey memory poolKey) internal pure returns (PoolId
poolId) {
| 12  | assembly | ("memory-safe") |                       | {   |             |
| --- | -------- | --------------- | --------------------- | --- | ----------- |
| 13  |          | poolId          | := keccak256(poolKey, |     | mul(32, 5)) |
| 14  | }        |                 |                       |     |             |
| 15  | }        |                 |                       |     |             |
16 }
TrailofBits
39 Uniswapv4CoreSecurityAssessment
PUBLIC

Figure6.2:HashingofthePoolKeystructintypes/PoolId.sol#L9-L16
AnattackercancreateapoolwithamaliciousHookscontractthatlookssimilartoa
legitimatevictimpoolbyfulfillingthefollowingrequirements:
1. Thecurrency0,currency1,fee,andtickSpacingfieldsareidenticaltothe
victimpool.Thiscanbeeasilyachievedsincemultiplepoolswiththesame
currency0,currency1,fee,andtickSpacingfieldscanexistaslongasthey
haveadifferenthooksfield(whichhappenstobeoneoftheattacker’sother
requirements;seebelow).
2. TheIDofthemaliciouspoolissimilartotheIDofthevictimpool(i.e.,thefirst
andlastXcharactersareidentical).Thiscanbeachievedbytreatingthehooks
fieldasanonceandbrute-forcingituntiladesiredkeccak256hash(=poolID)is
generated.UIstendtoshortenlongstringsofhexadecimalcharacters,inwhichcase
havinganidenticalfirstandlastXcharactercouldbeenoughtotrickusers.
3. Theattacker’scustomHookscontractisdeployedatthegeneratedhooks
address.ThiscanbeachievedbyusingaCREATE2(orCREATE3)factoryto
precomputeadeploymentaddressthat,whenplacedinthePoolKey.hooksfield,
generatesapoolIDthatissimilartothevictimpool’sID.
4. TheaddressoftheHookscontracthastherightflagsenabled(presentinthe
lower14bits).ThiscanbeachievedbyrequiringthattheCREATE2(orCREATE3)
precomputedaddresshasthelower14bitssetasdesiredtoenabletherightflags.
InUniswapv3,thisproblemdidnotexistsinceeachpoolwasdeployedseparately,there
wasnofieldthatcouldbeusedasanoncetogenerateadesiredaddress,andonlyone
tokenpairperfeetier(ofwhichthereareonlyahandful)couldbecreated.InUniswapv4,
theselimitationsdonotexist.
Thisbegsthequestion:howdoweb/mobileappsdisplaypoolstouserssothattheyknow
whichis“therightone”?Onesolutionis,ofcourse,byshowingtheliquidityinapool,which
shouldimmediatelymakeclearwhichpoolistherightpooltouse(i.e.,duetoalarge
amountofliquidity).However,fornewlycreatedpools,theremaynotbealotofliquidity
upon(orwithinashorttimeframeafter)poolcreation.Also,awell-fundedattackermight
actuallycreateapoolandaddasubstantialamountofliquidity,whichthenlateris
withdrawnagain.
Recommendations
Shortterm,thereisnosilverbulletsolutiontothisproblem.Wethereforerecommend
documentingthisissueintheofficialUniswapv4docssothatusersandintegratorsare
madeaware.
TrailofBits 40 Uniswapv4CoreSecurityAssessment
PUBLIC

Longterm:
● Designachecklist(orflowchart)forusersthathelpsthemtodetermineifa
poolislikelysafetointeractwith.Thiswillnotbeeasysincesimplysaying,“do
notinteractwithapoolwithlessthan5LPs”mayactuallyfilteroutpoolsthatare
notmalicious.Thesamegoesfor“donotinteractwithpoolscreatedlessthan7
daysago,”whichfiltersoutnewprojectsthatarenotmalicious.Thebestsolution
couldbecreatingalistofthingstocheckthatadduptoacertainscore, indicating
thatthepoolisprobablynotsafetointeractwith.
● Designguidelinesforintegratorsthatexplainwhatinformationtodisplayin
theUIforeachpool.Theseguidelinesshouldbealignedtothechecklistfromthe
abovepointsothatuserscaneasilyfollowthechecklist.
● ConsidercreatingaallowlistofpoolIDsthatareknowntobenon-malicious,
andonlydisplaythesebydefaultintheUniswapv4UI.
● Considercreatingaallowlistofhookcontractaddressesand/orhashesof
runtimebytecodeofhookcontracts.Thiscouldbeusedtoshowtouserswhich
hooksareknownnottobemalicious(although,duetothearbitrarynatureofhooks
contracts,theymaystillperformexternalcallsthatleadtomaliciousbehavior).The
flexibilityofhookscontractsisbothaplus—itprovidesflexibilityforprojectstobuild
customintegrations—andanegative,duetoallthewayshookscontractscanact
maliciously.
● ConsiderusingadifferentwaytodetermineapoolID.Forexample,an
incrementingintegerasIDwouldpreventthisissueentirely.However,thiswould
incurmoregascostssincethenthePoolKeystructfieldwouldneedtobestored
withinthecontractstorage(andSLOADedduringeveryaction).Andsincelowergas
costsisoneofthedesigngoalsofUniswapv4,thisisprobablynotavalidsolution.
However,theremaybeothercreativewaystogenerateapoolIDthatwedidnot
thinkofandthatwouldpreventthisissue.
TrailofBits 41 Uniswapv4CoreSecurityAssessment
PUBLIC

A. Vulnerability Categories
Thefollowingtablesdescribethevulnerabilitycategories,severitylevels,anddifficulty
levelsusedinthisdocument.
VulnerabilityCategories
Category Description
AccessControls Insufficientauthorizationorassessmentofrights
AuditingandLogging Insufficientauditingofactionsorloggingofproblems
Authentication Improperidentificationofusers
Configuration Misconfiguredservers,devices,orsoftwarecomponents
Cryptography Abreachofsystemconfidentialityorintegrity
DataExposure Exposureofsensitiveinformation
DataValidation Improperrelianceonthestructureorvaluesofdata
DenialofService Asystemfailurewithanavailabilityimpact
ErrorReporting Insecureorinsufficientreportingoferrorconditions
Patching Useofanoutdatedsoftwarepackageorlibrary
SessionManagement Improperidentificationofauthenticatedusers
Testing Insufficienttestmethodologyortestcoverage
Timing Raceconditionsorotherorder-of-operationsflaws
UndefinedBehavior Undefinedbehaviortriggeredwithinthesystem
TrailofBits 42 Uniswapv4CoreSecurityAssessment
PUBLIC

SeverityLevels
Severity Description
Informational Theissuedoesnotposeanimmediateriskbutisrelevanttosecuritybest
practices.
Undetermined Theextentoftheriskwasnotdeterminedduringthisengagement.
Low Theriskissmallorisnotonetheclienthasindicatedisimportant.
Medium Userinformationisatrisk;exploitationcouldposereputational,legal,or
moderatefinancialrisks.
High Theflawcouldaffectnumeroususersandhaveseriousreputational,legal,
orfinancialimplications.
DifficultyLevels
Difficulty Description
Undetermined Thedifficultyofexploitationwasnotdeterminedduringthisengagement.
Low Theflawiswellknown;publictoolsforitsexploitationexistorcanbe
scripted.
Medium Anattackermustwriteanexploitorwillneedin-depthknowledgeofthe
system.
High Anattackermusthaveprivilegedaccesstothesystem,mayneedtoknow
complextechnicaldetails,ormustdiscoverotherweaknessestoexploitthis
issue.
TrailofBits 43 Uniswapv4CoreSecurityAssessment
PUBLIC

| B. Code | Maturity | Categories |
| ------- | -------- | ---------- |
Thefollowingtablesdescribethecodematuritycategoriesandratingcriteriausedinthis
document.
CodeMaturityCategories
| Category   | Description                                        |     |
| ---------- | -------------------------------------------------- | --- |
| Arithmetic | Theproperuseofmathematicaloperationsandsemantics   |     |
| Auditing   | Theuseofeventauditingandloggingtosupportmonitoring |     |
Authentication/ Theuseofrobustaccesscontrolstohandleidentificationand
AccessControls authorizationandtoensuresafeinteractionswiththesystem
Complexity Thepresenceofclearstructuresdesignedtomanagesystemcomplexity,
Management includingtheseparationofsystemlogicintoclearlydefinedfunctions
Cryptographyand Thesafeuseofcryptographicprimitivesandfunctions,alongwiththe
KeyManagement presenceofrobustmechanismsforkeygenerationanddistribution
Decentralization Thepresenceofadecentralizedgovernancestructureformitigating
insiderthreatsandmanagingrisksposedbycontractupgrades
Documentation Thepresenceofcomprehensiveandreadablecodebasedocumentation
| Low-Level | Thejustifieduseofinlineassemblyandlow-levelcalls |     |
| --------- | ------------------------------------------------ | --- |
Manipulation
Testingand Thepresenceofrobusttestingprocedures(e.g.,unittests,integration
Verification tests,andverificationmethods)andsufficienttestcoverage
Transaction Thesystem’sresistancetotransaction-orderingattacks
Ordering
RatingCriteria
| Rating | Description |     |
| ------ | ----------- | --- |
Strong Noissueswerefound,andthesystemexceedsindustrystandards.
Satisfactory Minorissueswerefound,butthesystemiscompliantwithbestpractices.
| Moderate | Someissuesthatmayaffectsystemsafetywerefound. |     |
| -------- | --------------------------------------------- | --- |
TrailofBits
44 Uniswapv4CoreSecurityAssessment
PUBLIC

Weak Manyissuesthataffectsystemsafetywerefound.
Missing Arequiredcomponentismissing,significantlyaffectingsystemsafety.
NotApplicable Thecategoryisnotapplicabletothisreview.
NotConsidered Thecategorywasnotconsideredinthisreview.
Further Furtherinvestigationisrequiredtoreachameaningfulconclusion.
Investigation
Required
TrailofBits 45 Uniswapv4CoreSecurityAssessment
PUBLIC

C. Code Quality Findings
Thisappendixcontainsfindingsthatdonothaveimmediateorobvioussecurity
implications.However,theymayfacilitateexploitchainstargetingothervulnerabilities,
becomeeasilyexploitableinfuturereleases,ordecreasecodereadability.Werecommend
fixingtheissuesreportedhere.
● Usetwo-stepownershiptransferinProtocolFees.TheProtocolFeescontract
inheritsfromsolmate’sOwnedcontract,whichfeaturesasingle-stepownership
transfer.TheeffectisthatitispossibletoloseaccesstotheProtocolFeeController
setter.Giventhatthisfunctionisnotmeanttobecalledoften,havinganadditional
stepforownershiptransferdoesnotaffecttheruntimegasoptimizations.
Additionally,werecommendthattheinitialownerbedifferentfromthedeployer.
● RenamethestatevariableinPool.modifyLiquidity.ThePoollibrarydefines
aStatestructurethatcontainsthepoolstate.Later,inthesamefile,the
modifyLiquidityfunctiondefinesalocalvariablecalledstate,oftype
ModifyLiquidityState.GiventhatthefirstargumenttothefunctionisaState
structure,thesimilarityinnamesbetweentheStatestructureandstatevariable
makesthecodedifficulttoread.
● FixthehashedvaluefortheNonZeroDeltaCountslot.Thelibrarynameis
NonZeroDeltaCount,andthevalueusedtocalculatetheslothashis
NonzeroDeltaCount.
● FixincorrectcommentsinCurrencydatatype.Thecommentsinthetransfer
functionoftheCurrencylibraryareincorrect.
● UpgradeOpenZeppelincontractstothelatestversion.TheOpenZeppelin
contractssubmoduleusesversion4.4.2ofthecontracts,whilethelatestreleaseis
version5.0.2.
● FixthedocumentationfortheHookslibrary.Theofficialdocumentationwebsite
forhookdeployment,mentionsthatthehigher-orderbitsofthehookaddressare
usedasflags.However,theHookslibrarycodeusesthelower-orderbits.
● Includezero-valuechecksforcertainfunctionarguments.Certainfunction
parametersdonotcontainzero-valuechecks,leadingtotokenloss.More
specifically,thefunctionargumenttointhetakefunction,andthefunction
argumentrecipientincollectProtocolFees,shouldbecheckedforthezero
address.
TrailofBits 46 Uniswapv4CoreSecurityAssessment
PUBLIC

D. Invariant Testing and Harness Design
Whenreviewingprotocolswithalargepotentialstatespace,TrailofBitscreatesvarious
statefulandstatelessfuzztestingharnessestoverifysystempropertiesthatwouldbe
challengingorevenimpossibletoverifyusingmanualreview.
Weperformedautomatedtestingusingacombinationofstatefulfuzztestingharnesses
runusingEchidnaandMedusa,andasetofstatelessinvariantstestedusingbothfuzzing
andformalmethods.
StatelessInvariantTesting
Asageneralrule,werecommendfavoringfuzzingoverformalmethods(seeWhyfuzzing
overformalverification?).However,giventhecriticalandlowcomplexityofsome
invariants,wedecidedtouseHalmostocheckfortheircorrectness.Theseinvariantsdid
notrequireanyspecialharnessandaredocumentedintheAutomatedTestingsection.
StatefulInvariantTesting
Statefulinvarianttestinginvolvesinitializingasystem,thenusingafuzzertorunvarious
publicfunctionswithspeciallyselectedparametersinordertobreakuser-defined
invariants.ThefuzzerrunsuptoNselectedfunctionsforagivenEVMcontextbefore
resettingthecontextandstartingover.Statefulinvarianttestingis“stateful”becausethe
EVMcontextisreusedforthenexttransactioninthesequence,meaningeachinvariant
mayberunagainstexoticsystemstatesproducedbytheprevioustransactions.
Statefulinvarianttesting,whileitdoesuseafuzzer,shouldnotbeconfusedwith
parameterizedfuzzingprovidedbytoolslikefoundry fuzz.Parameterizedfuzzingallows
invariantstobetestedonlyagainstaveryspecificsubsetofthestatespace—specifically,
whateverstatethesystemisinaftersetUpiscompleted.Thismeansthattheamountof
statespacethatcanbeverifiedbyaparameterizedfuzzingtestisastronomicallysmaller
thanthestatespacethatcanbeverifiedbyastatefulinvarianttest.
Forstatefulinvarianttesting,weusetwofuzzers,EchidnaandMedusa,bothmaintainedby
TrailofBits.Thesefuzzersareusedinconjunctionwithatestharness:aspecialcontract
thatsitsinfrontofthesystemundertest,andiscalledbythefuzzerstoproduce
transactionsequencesthatexplorethestatespace,asmeasuredbycodecoverage.
Sincethereisnocanonicalwayofperformingstatefulinvarianttests,designingatest
harnessismoreofanartthanascience.Inthefollowingsections,weprovidedetailsabout
eachharnesswewrote,thedesigndecisionsthatwentintoeachharness,andthekindsof
propertiesweexpecttoverifywitheachharnessdesign.
TrailofBits 47 Uniswapv4CoreSecurityAssessment
PUBLIC

Stateful Invariants Using the End-to-End Harness
Atthebeginningoftheengagement,westartedwithatargetedend-to-endharnessthat
couldbeusedtoverifythepropertiesofspecificuserflows,suchasswapping,providing
liquidity,anddonating.Thegoalofthisharnessisnotonlytotestthosespecificflows,but
alsotohelpacquaintuswithv4’snewlock/unlockmodel,itsexistingtestsuite,andto
determinewhetherpartsoftheexistingunittestsuitecanberepurposedintoamore
generalizedfuzzingharness.
FigureC.1showsaharnessdiagram.TheharnessrevolvesaroundtheEnd2Endcontract,
whichisusedtoinitializetheharness,todeployactor/ancillarycontracts,andasan
entrypointforthefuzzertotriggeractionswithinthesystem.Weborrowedmuchofthe
initializationandcallbacklogicfromUniswap’sDeployer,PoolSwapTest,
PoolDonateTest,andsimilarcontracts,drasticallyreducingtheamountoftimerequired
tosetuptheharness.
Theend-to-endharnessmaybeinitializedwithaspecifiednumberofcurrencies,a
specifiednumberofdistinctactors,andadynamicnumberofpoolsthatareinitialized
usingfuzzedvalues.Thefullsupplyofeachcurrencyismintedtotheend-to-endcontract,
andactorscanborrowfundsfromthecontractasneededfortheirtests.Thisallowsactors
tousefundsuptothetotalSupplyforeachcurrency,whereifthevaluesforeach
currencyweredistributedtoeachactor,eachactorwouldonlybeabletotestupto
totalSupply/numActorstokens.
TrailofBits 48 Uniswapv4CoreSecurityAssessment
PUBLIC

FigureC.1:Diagramoftheend-to-endfuzzingharness
TrailofBits 49 Uniswapv4CoreSecurityAssessment
PUBLIC

Stateful Invariants Using the Actions Harness
Shortlyaftercompletingtheend-to-endharness,wenotedseverelimitationsonthekinds
ofpropertiesthatcouldbeverifiedbyanend-to-endharness.Uniswapv4lackstheatomic
propertiesthatitspriorsandmostothersmartcontractprotocolshave,meaningthefuzzer
cannotsimplyuseswapormodifyPositionasentrypoints—theymustbeorchestrated
withmultipleotheractionstoproduceavalidtransaction.Theend-to-endharness,byits
nature,automaticallyperformsthisoverheadactionorchestration,thuspreventing
action-levelpropertiesfrombeingdirectlyverified.
Thisdetailnecessitatedadrasticallydifferentharnessdesign—onethatcouldverify
Uniswapv4’snon-atomic“actions”inadditiontoitsend-to-endproperties.
Webegandesigninganewharnessthatcouldaddressthefollowingrequirements:
1. Theabilitytotestthestatetransition/sideeffectsofeachindividualUniswapv4
action(swap,modifyPosition,donate,settle,etc.)
2. Theabilitytotestmultipleunlock/lockcontextsduringthesametransactionto
verifythatfailingtocleantransientstoragedoesnotcauseissues.
3. Theabilitytodetectunexpectedoverflows/underflowsinv4’snewarithmetic.
4. Theabilitytoimplementlock-wideproperties,includingpropertiesdefinedinthe
previousend-to-endharness.
5. Theabilitytoaddressshortcomingsinthesystem’spreviousformal
analysis—specificallytheassumptionthatallloopsiterateatmostonce.
6. Allowasmanyvaluestobeparameterizedaspossible(e.g.,variablenumberof
currencies,variablenumberofpools,variablepoolconfiguration).
ActionsHarnessDesign
Thecoreprincipleoftheharnessistousethefuzzertogeneraterandomsequencesof
actionswithparameters,usingonetransactionforeachactiontobeaddedtothe
sequence.Eachactionanditsparametersarestoredintheactionsandparamslistsof
ActionFuzzEntrypoint.OneofthefunctionsexposedtothefuzzerisrunActions,
whichtakestheactionsandparamslistsandcallsintoActionsRouter.executeActions
toexecutealloftheactionsinthesametransaction.
ActionsRouterisapre-existingcontractusedbythev4testsuitetorunarbitrarylistsof
actionsagainstthev4singleton.When
ActionsRouter.executeActions(actions,params)iscalled,itlocksthev4singleton,
andtheninitsunlockCallback(),itsequentiallyrunseachaction.
TrailofBits 50 Uniswapv4CoreSecurityAssessment
PUBLIC

WemodifiedActionsRoutertoaddaHARNESS_CALLBACKaction.Thisactioncallsback
intoActionFuzzEntrypointinsteadofcallingthev4singleton,allowingourtestharness
toobservethestateofthev4singletonbeforeitiscalledwithanaction,andcompareitto
thesingleton’sstateafterthecall.
FigureC.2showsasequencediagramfortheActionsHarness,andfigureC.3showsablock
diagramoftheharness.
FigureC.2:SequencediagramoftheActionsfuzzingharness
NotethatinfigureC.2,thattherearetechnicallythreetouchpointswherethesystem’s
propertiescanbeverified:
1. Beforeanactioniscalled,wecanverifythatthesystemwasleftinavalidstate.We
canalsocapturethesystem’sstatebeforetheactioniscalled.
TrailofBits 51 Uniswapv4CoreSecurityAssessment
PUBLIC

2. Afteranactioniscalled,wecanverifyitssideeffectsandensurethatthevalues
returnedbytheactionarecorrect.
3. Afterthesystemisrelocked,wecanverifyunlock-wide,end-to-endproperties.If
multipleunlock/lockcyclesoccurduringagivenrunActionstransaction,wecan
verifypropertiesrelatingtotransientstoragereuse.
TrailofBits 52 Uniswapv4CoreSecurityAssessment
PUBLIC

FigureC.3:BlockdiagramoftheActionsfuzzingharness,includingacharacterizationof
addSwap'sbehavior
Selected Invariants for Discussion
Atthebeginningoftheengagement,theclientflaggedseveralpotentialissuesforwhichno
knownexploitexisted,buttherewasalsonoproofthatanexploitdidnotexist.The
primaryissueis#60-InvestigateOverflowSafetyofDonateandfeeGrowthGlobal.
Thefundamentalconcernbehindthisissueisthatitmaybepossibletooverflowor
underflowcertainfunctions/variablesinthesystem,causingoneofthefollowingeffects:
1. AnLPposition’sliquidityorfeesbecomeworthmorethantheyshouldbe.
2. AusermayartificiallyincreaseordecreasetheircurrencyDeltaoutsidethe
intendedfunctionality.
SinceUniswapv4isimplementedsothatallpoolbalancesarestoredonthesamecontract,
eitheroftheseissueswouldbeofcriticalseverity,sincetheywouldallowthemalicious
actortostealliquiditybelongingtoanotherpool.
Wedecidedtotacklethisissueusingtwosetsofproperties:onesetthatensuresapool’s
FeeGrowthGlobalcannotunderflow,andonesetthatensurestherearealwaysenough
tokensinagivenpooltopayoutoweddebtstoliquidityprovidersandprotocolfees.
EnsuringthataPool’sFeeGrowthGlobalCannotUnderflow
Weimplementedsixpropertiestoensurethatapool’sFeeGrowthGlobaldoesnot
underflowthroughthedonatefunction;twotoverifythatthecall’sBalanceDeltais
alwayszeroornegative;twotoverifythatthefeegrowthmatchestheexpectedvalues
basedonthechangeinBalanceDelta;andtwotoverifythattheBalanceDeltas
returnedbydonatematchtheamount0andamount1thatdonatewascalledwith
(UNI-DONATE-1,UNI-DONATE-2,UNI-DONATE-6,UNI-DONATE-7,UNI-DONATE-8,
UNI-DONATE-9).AnabridgedversionofthecodeisshowninfigureC.4.
EnsuringthattheSingletonCanAlwaysCoverItsDebts
Atanyonepoint,thedebtowedbythesingletoncontracttocreditorscanbebrokendown
intofourcategories:
1. BalancesowedtocreditorsthroughtheircurrencyDelta
2. BalancesowedtotheDAOthroughprotocolfees
3. AccruedLPfeesowedtoliquidityproviders
4. Liquidityowedtoliquidityproviders
TrailofBits 53 Uniswapv4CoreSecurityAssessment
PUBLIC

Aftereachactionisexecuted,wecancheckthesepropertiestoensurethattheyhold,using
_verifyGlobalProperties.ThisfunctioncontainspropertiesUNI-ACTION-1,
UNI-ACTION-2,andUNI-ACTION-3,whichensurethatthesumofalldebtsandcreditsdoes
notexceedthesingleton’sbalance.
Therearesomeadditionalpropertiesrelatedtoindividualcategoriesofdebt,suchas
UNI-MODLIQ-8andUNI-MODLIQ-9,whichverifytheamountofliquiditybeingwithdrawn
byaliquidityproviderdoesnotexceedtheamountofliquidityavailableforthepool.This
effectivelyverifiesthatwhenwithdrawingliquidity,thatamountwillnotbe“taken”from
anotherpool.
TheseareaccompaniedbyUNI-MODLIQ-6andUNI-MODLIQ-7,whichverifythatthe
singletonhasadequatebalancetocredittheliquidityproviderfortheiraccruedfees.These
twopropertiesmakemoresensebyscopingthemdownfromthesingletonleveltothe
poollevel,butduetotimeconstraints,wewereunabletocompletethis.
| function | _afterDonate(BalanceDelta |     | delta) | internal | {   |     |
| -------- | ------------------------- | --- | ------ | -------- | --- | --- |
// UNI-DONATE-6
assertLte(delta.amount0(), 0, "A donate() call must not return a positive
| BalanceDelta | for | currency0"); |     |     |     |     |
| ------------ | --- | ------------ | --- | --- | --- | --- |
// UNI-DONATE-8
assertEq(_donateAmount0, -delta.amount0, "The donate() call BalanceDelta must
| match the | amount | donated for | amount0"); |     |     |     |
| --------- | ------ | ----------- | ---------- | --- | --- | --- |
[...]
| //      | how far until       | the 128x128 | overflows           |     |     |     |
| ------- | ------------------- | ----------- | ------------------- | --- | --- | --- |
| uint256 | growth0OverheadX128 |             | = type(uint256).max |     | -   |     |
_feeGrowthGlobalBeforeDonate0X128;
| //      | the expected        | change | in fee growth | based on | delta |     |
| ------- | ------------------- | ------ | ------------- | -------- | ----- | --- |
| uint256 | feeGrowthDelta0X128 |        | =             |          |       |     |
FullMath.mulDiv(uint256(uint128(-delta.amount0())), FixedPoint128.Q128, liquidity);
| uint256 | feeGrowth0ExpectedX128 |     | = _calculateExpectedFeeDelta( |     |     |     |
| ------- | ---------------------- | --- | ----------------------------- | --- | --- | --- |
feeGrowthDelta0X128,
_feeGrowthGlobalBeforeDonate0X128
);
| (uint256 | feeGrowth0AfterX128, |     | uint256 | feeGrowth1AfterX128) |     | =   |
| -------- | -------------------- | --- | ------- | -------------------- | --- | --- |
manager.getFeeGrowthGlobals(donatePoolId);
[...]
| if  | (liquidity        | > 0 ) { |      |     |     |     |
| --- | ----------------- | ------- | ---- | --- | --- | --- |
|     | if(_donateAmount0 | >       | 0) { |     |     |     |
// UNI-DONATE-1
assertEq(feeGrowth0ExpectedX128, feeGrowth0AfterX128 , "After a donation
with a non-zero amount0, the pool's feeGrowthGlobal0X128 be equal to the amount0
| BalanceDelta, | accounting | for | overflows."); |     |     |     |
| ------------- | ---------- | --- | ------------- | --- | --- | --- |
TrailofBits
|     |     |     |     | 54  | Uniswapv4CoreSecurityAssessment |     |
| --- | --- | --- | --- | --- | ------------------------------- | --- |
PUBLIC

FigureC.4:Anabridgedreproductionofthedonationpropertiesverifiedin_afterDonate.
(audit-uniswap-v4/test/trailofbits/actionprops/DonateActionProps.sol)
Future Work
Thereareseveralareasforpotentialfutureworktofurtherimprovetheinvarianttestsuite
thatwecouldnotaccomplishduringthisengagementduetotimeconstraints.
1. Somecriticalproperties,suchasUNI-MODLIQ-6andUNI-MODLIQ-7,are
over-generalized,andwouldgreatlybenefitfrombeingtightenedup.
2. Somepropertieswerenotimplementedduetotimeconstraints,suchas
calculationsforthechangeinfeeGrowthGlobalresultingfromaswapcall.
3. ManypropertiesofmodifyLiquidityandsettleNativeremainincomplete,and
aretestedonlyatdiscretepointsinthestatespaceusingtheunittestsuite.
4. Propertiesthatverifythatafunctioncallshouldnotrevert.Duetotimeconstraints,
onlyseveralofthesecouldbeimplemented,andonlyfortheinitialize()
function.
5. Somepotentialpropertiescouldbeaddedtobetterverifythatthesingleton’sdebts
neverexceeditsassetsbyverifyingthelevelsofdebtofeachindividualpoolinstead
ofthoseinthesingletonasawhole.Addingpropertiesthatoperateatthepool-level
willprovidehigherassuranceandwillbeeasierforthefuzzertodiscover.
UNI-MODLIQ-8andUNI-MODLIQ-9providesomeexamplesforwhatthiswouldlook
like,anditshouldbestraightforwardtoexpandtootherformsofdebt.
TrailofBits 55 Uniswapv4CoreSecurityAssessment
PUBLIC

| E. Static Invariants |     |     |     |
| -------------------- | --- | --- | --- |
Throughoutthereview,weidentifiedmultiplecodepatternsthatrequiretobeenforced
throughthecodebase.Toensuretheircorrectness,wewrotealintertoolbasedonslither.
Thelinterchecksthefollowing:
| ID  | Property | Why | Result |
| --- | -------- | --- | ------ |
Passed
| noSelfCall_sh | Functionsthatuse | Themodifierisano-op;any     |     |
| ------------- | ---------------- | --------------------------- | --- |
| ould_not_retu | noSelfCalldonot  | returnvariablewouldalwaysbe |     |
rn
|     | returnanyvariable | itsdefaultvalue. |     |
| --- | ----------------- | ---------------- | --- |
Passed
| callHook | Functionsthatcalls   | Thisensuresthatthehookwill |     |
| -------- | -------------------- | -------------------------- | --- |
|          | callHookareprotected | notre-entertoitself.       |     |
againstself-calls
Passed
pool_manager_ PoolManager’sfunctions Afunctioncollisioncouldleadto
| function_ids | donotcollidewiththe | settingahooktobethepool   |     |
| ------------ | ------------------- | ------------------------- | --- |
|              | Hooksfunction       | manageritselfandexecuting |     |
unexpectedcode(e.g.,havingthe
managerswapassets).
Passed
| pool_manager_ | Only                | Onlythesetwofunctionsshould |     |
| ------------- | ------------------- | --------------------------- | --- |
| payable       | settle/settleForare | receivefunds.               |     |
payableinthepool
manager
Thecodeofthelinterisprovidedbelow.WerecommendthatUniswapaddthetoolinthe
CI,andextenditwithfurtheranalysis:
| from collections               | import defaultdict |     |     |
| ------------------------------ | ------------------ | --- | --- |
| from slither import            | Slither            |     |     |
| from slither.core.declarations | import Function    |     |     |
from slither.slithir.operations import TypeConversion, Binary, BinaryType
from slither.core.solidity_types.elementary_type import ElementaryType
from slither.core.declarations.solidity_variables import SolidityVariableComposed
from slither.utils.function import get_function_id
def noSelfCall_should_not_return(sl: Slither):
# Check that the function that use noSelfCall don't return variable
# Given than the modifier is a no-op, that would lead to function to return
TrailofBits
56 Uniswapv4CoreSecurityAssessment
PUBLIC

| default             | values        |                                      |                          |                          |     |     |     |
| ------------------- | ------------- | ------------------------------------ | ------------------------ | ------------------------ | --- | --- | --- |
| no_finding_or_error |               |                                      | = True                   |                          |     |     |     |
| hook_contracts      |               | = sl.get_contract_from_name("Hooks") |                          |                          |     |     |     |
| for                 | hook_contract | in                                   | hook_contracts:          |                          |     |     |     |
|                     | noSelfCall    | = None                               |                          |                          |     |     |     |
|                     | for modifier  | in                                   | hook_contract.modifiers: |                          |     |     |     |
|                     | if            | modifier.full_name                   |                          | == "noSelfCall(IHooks)": |     |     |     |
|                     |               | noSelfCall                           | = modifier               |                          |     |     |     |
if not noSelfCall:
|     | print(f"noSelfCall  |                    | not                      | found in {hook_contract}") |                       |              |        |
| --- | ------------------- | ------------------ | ------------------------ | -------------------------- | --------------------- | ------------ | ------ |
|     | no_finding_or_error |                    |                          | = False                    |                       |              |        |
|     | for function        | in                 | hook_contract.functions: |                            |                       |              |        |
|     | if                  | noSelfCall         | in function.modifiers    |                            | and function.returns: |              |        |
|     |                     | print(f"{function} |                          | has the {noSelfCall}       |                       | modifier and | return |
variables")
|     |     | no_finding_or_error |     | = False |     |     |     |
| --- | --- | ------------------- | --- | ------- | --- | --- | --- |
if no_finding_or_error:
print(f" - [X] noSelfCall_should_not_return analyzed (no finding)")
else:
print(
f" - [ ] noSelfCall_should_not_return analyzed (incomplete or with
finding)"
)
| def _has_msg_sender_self_check(function: |       |                              |     | Function) | ->  | bool: |     |
| ---------------------------------------- | ----- | ---------------------------- | --- | --------- | --- | ----- | --- |
| self                                     | = []  |                              |     |           |     |       |     |
| for                                      | ir in | function.slithir_operations: |     |           |     |       |     |
if (
|     | isinstance(ir, |                  | TypeConversion)              |           |     |     |     |
| --- | -------------- | ---------------- | ---------------------------- | --------- | --- | --- | --- |
|     | and            | ir.variable.name |                              | == "self" |     |     |     |
|     | and            | ir.type          | == ElementaryType("address") |           |     |     |     |
):
self.append(ir.lvalue)
| for | ir in             | function.slithir_operations: |         |             |                      |     |     |
| --- | ----------------- | ---------------------------- | ------- | ----------- | -------------------- | --- | --- |
|     | if isinstance(ir, |                              | Binary) | and ir.type | == BinaryType.EQUAL: |     |     |
if (
|     |     | ir.variable_left      |     | == SolidityVariableComposed("msg.sender") |     |     |     |
| --- | --- | --------------------- | --- | ----------------------------------------- | --- | --- | --- |
|     |     | and ir.variable_right |     | in self                                   |     |     |     |
):
return True
| return           | False |           |     |     |     |     |     |
| ---------------- | ----- | --------- | --- | --- | --- | --- | --- |
| def callHook(sl: |       | Slither): |     |     |     |     |     |
TrailofBits
|     |     |     |     | 57  |     | Uniswapv4CoreSecurityAssessment |     |
| --- | --- | --- | --- | --- | --- | ------------------------------- | --- |
PUBLIC

| # Check             | that       | the function                         | that calls | callHook | have either |
| ------------------- | ---------- | ------------------------------------ | ---------- | -------- | ----------- |
| # - The             | noSelfCall | modifier                             |            |          |             |
| # - Or              | compare    | msg.sender                           | with self  |          |             |
| no_finding_or_error |            | =                                    | True       |          |             |
| hook_contracts      |            | = sl.get_contract_from_name("Hooks") |            |          |             |
| for hook_contract   |            | in hook_contracts:                   |            |          |             |
| callHook            |            | =                                    |            |          |             |
hook_contract.get_function_from_signature("callHook(address,bytes)")
| noSelfCall |                     | = None                            |                                 |           |                      |
| ---------- | ------------------- | --------------------------------- | ------------------------------- | --------- | -------------------- |
| for        | modifier            | in hook_contract.modifiers:       |                                 |           |                      |
|            | if                  | modifier.full_name                | == "noSelfCall(IHooks)":        |           |                      |
|            |                     | noSelfCall                        | = modifier                      |           |                      |
| if         | not                 | callHook or                       | not noSelfCall:                 |           |                      |
|            | print(f"callHook    |                                   | or noSelfCall                   | not found | in {hook_contract}") |
|            | no_finding_or_error |                                   | = False                         |           |                      |
| for        | function            | in hook_contract.functions:       |                                 |           |                      |
|            | #                   | Allowlist callHookWithReturnDelta |                                 |           |                      |
|            | if                  | function.name                     | in ["callHookWithReturnDelta"]: |           |                      |
continue
|     | if  | callHook in   | function.all_internal_calls(): |     |     |
| --- | --- | ------------- | ------------------------------ | --- | --- |
|     |     | if noSelfCall | in function.modifiers:         |     |     |
continue
if _has_msg_sender_self_check(function):
continue
print(f"{function} has is missing noSelfCall or msg.sender==self
check")
|     |     | no_finding_or_error | =   | False |     |
| --- | --- | ------------------- | --- | ----- | --- |
if no_finding_or_error:
| print(f" |     | - [X] callHook | analyzed | (no finding)") |     |
| -------- | --- | -------------- | -------- | -------------- | --- |
else:
print(
|     | f"  | - [ ] callHook | analyzed | (incomplete | or with finding)" |
| --- | --- | -------------- | -------- | ----------- | ----------------- |
)
| def pool_manager_function_ids(sl: |     |     | Slither): |     |     |
| --------------------------------- | --- | --- | --------- | --- | --- |
# Check that all the public functions of PoolManager dont collide with the hooks
| functions | (func | id) |     |     |     |
| --------- | ----- | --- | --- | --- | --- |
# This is to prevent a hook to point to the pool manager to executed unexpected
code
| # (ex:              | having | the manager | swapping | assets) |     |
| ------------------- | ------ | ----------- | -------- | ------- | --- |
| no_finding_or_error |        | =           | True     |         |     |
pool_manager_contracts = sl.get_contract_from_name("PoolManager")
TrailofBits
|     |     |     |     | 58  | Uniswapv4CoreSecurityAssessment |
| --- | --- | --- | --- | --- | ------------------------------- |
PUBLIC

hooks = sl.get_contract_from_name("IHooks")
| entry_ids =               | defaultdict(set) |                         |     |     |
| ------------------------- | ---------------- | ----------------------- | --- | --- |
| hooks_ids =               | defaultdict(set) |                         |     |     |
| for pool_manager_contract | in               | pool_manager_contracts: |     |     |
for entry_point in pool_manager_contract.functions_entry_points:
entry_ids[get_function_id(entry_point.solidity_signature)].add(
entry_point.solidity_signature
)
| for hook_contract | in hooks:                                |     |     |     |
| ----------------- | ---------------------------------------- | --- | --- | --- |
| for hook          | in hook_contract.functions_entry_points: |     |     |     |
hooks_ids[get_function_id(hook.solidity_signature)].add(
hook.solidity_signature
)
inter = set(entry_ids.keys()).intersection(set(hooks_ids.keys()))
for i in inter:
print(f"ID collision between {entry_ids[i]} and {hooks_ids[i]}")
| no_finding_or_error | = False |     |     |     |
| ------------------- | ------- | --- | --- | --- |
if no_finding_or_error:
print(f" - [X] pool_manager_function_ids analyzed (no finding)")
else:
print(f" - [ ] pool_manager_function_ids analyzed (with finding)")
| def pool_manager_payable(sl: | Slither): |     |     |     |
| ---------------------------- | --------- | --- | --- | --- |
# Check that only settle/settleFor are payable in the pool manager
| no_finding_or_error | = True |     |     |     |
| ------------------- | ------ | --- | --- | --- |
pool_manager_contracts = sl.get_contract_from_name("PoolManager")
| for manager  | in pool_manager_contracts: |     |     |     |
| ------------ | -------------------------- | --- | --- | --- |
| for function | in manager.functions:      |     |     |     |
if function.payable and not function.name in ["settle", "settleFor"]:
|     | print(f"{function}  | should not | be payable") |     |
| --- | ------------------- | ---------- | ------------ | --- |
|     | no_finding_or_error | = False    |              |     |
if no_finding_or_error:
| print(f" | - [X] pool_manager_payable |     | analyzed (no | finding)") |
| -------- | -------------------------- | --- | ------------ | ---------- |
else:
| print(f" | - [ ] pool_manager_payable |     | analyzed (with | finding)") |
| -------- | -------------------------- | --- | -------------- | ---------- |
def main() -> None:
| # Run with python | linters/linter.py |     |     |     |
| ----------------- | ----------------- | --- | --- | --- |
# If call from another path, update "." to point to the top level directory of
the project
sl = Slither(".")
TrailofBits
|     |     | 59  |     | Uniswapv4CoreSecurityAssessment |
| --- | --- | --- | --- | ------------------------------- |
PUBLIC

noSelfCall_should_not_return(sl)
callHook(sl)
pool_manager_function_ids(sl)
pool_manager_payable(sl)
if __name__ == "__main__":
main()
FigureE.1:Slitherscript
TrailofBits 60 Uniswapv4CoreSecurityAssessment
PUBLIC

F. Fix Review Results
Whenundertakingafixreview,TrailofBitsreviewsthefixesimplementedforissues
identifiedintheoriginalreport.Thisworkinvolvesareviewofspecificareasofthesource
codeandsystemconfiguration,notcomprehensiveanalysisofthesystem.
OnAugust30,2024,TrailofBitsreviewedthefixesandmitigationsimplementedbythe
Uniswapteamfortheissuesidentifiedinthisreport.Wereviewedeachfixtodetermineits
effectivenessinresolvingtheassociatedissue.
Insummary,ofthesixissuesdescribedinthisreport,Uniswaphasresolvedfourissues,
partiallyresolvedoneissue,anddecidedtonotresolveoneissue.Foradditional
information,pleaseseetheDetailedFixReviewResultsbelow.
ID Title Status
1 Strictequalityonfeecomparisoncanleadthefeestobegreaterthan Resolved
100%
2 Incorrectvariableusageonswapfee Resolved
3 Collectedprotocolfeesmaycountagainstuser’scurrencydeltas Resolved
4 UseofincorrectmasktoclearhigherbitsoftheprotocolFeevalue Resolved
Partially
5 Insufficienteventgeneration
Resolved
6 Similar-lookingpoolIDscanbebruteforcedthroughthePoolKey Unresolved
hooksfields
Detailed Fix Review Results
TOB-UNI4-1:Strictequalityonfeecomparisoncancausefeestoexceed100%
ResolvedinPR836.Thecomparisonwasupdatedfromis-equal-to(==)to
is-greater-than-or-equal-to(>=).
TOB-UNI4-2:Incorrectvariableusageonswapfee
ResolvedinPR831.Anewconstant(SwapMath.MAX_SWAP_FEE)wasaddedtothe
implementation.IntroducinganewconstantnamedMAX_SWAP_FEEismoreexplicitthan
usingtheMAX_FEE_PIPSconstant,whichweoriginallyrecommended.Allplaceswherethe
maxswapfeeisneedednowusethisnewconstant.Inotherwords,theuseofthe
TrailofBits 61 Uniswapv4CoreSecurityAssessment
PUBLIC

LPFeeLibrary.MAX_LP_FEEandSwapMath.MAX_FEE_PIPSconstantswasreplacedby
usingtheSwapMath.MAX_SWAP_FEEconstantinallapplicablelocations.
TOB-UNI4-3:Collectedprotocolfeesmaycountagainstuser’scurrencydeltas
ResolvedinPR856.Aguardwasaddedtothesyncfunctiontoensureitcanonlybecalled
whenthecontractisintheunlockedstate.Additionally,acheckwasaddedinthe
collectProtocolFeesfunctiontopreventitfrombeingcalledwhenthecontractis
unlocked,throwingacustomerror(ContractUnlocked)ifthischeckfails.Additionally,
newtestswereaddedtospecificallytestforthisedgecaseandtoensurethattheupdated
implementationcorrectlyhandlesit.
TOB-UNI4-4:UseofincorrectmasktoclearhigherbitsoftheprotocolFeevalue
ResolvedinPR835.Theimplementationwasupdatedtousea12-bitmaskinsteadofa
16-bitmask.
TOB-UNI4-5:Insu cienteventgeneration
PartiallyresolvedinPR845andPR808.Theimplementationwasupdatedtoemitanevent
inthedonatefunction,andtheexistingInitializedeventwasupdatedtoincludethe
sqrtPriceX96value.TheUniswapteamdecidedagainstaddinganeventinthe
updateDynamicLPFeefunctionsincehookscanalsoreturnadynamicLPfeeamount,
whichwouldnotnecessarilybeemittedinanevent.Tonormalizethebehavioracrossall
changesofupdateddynamicLPfees,noeventwillbeemittedfromthe
updateDynamicLPFeefunction.
TOB-UNI4-6:Similar-lookingpoolIDscanbebrute-forcedthroughthePoolKey
hooksfields
Unresolved.TheUniswapteamdecidedtonotresolvethisissue.
TrailofBits 62 Uniswapv4CoreSecurityAssessment
PUBLIC

| G. Fix | Review | Status | Categories |
| ------ | ------ | ------ | ---------- |
Thefollowingtabledescribesthestatusesusedtoindicatewhetheranissuehasbeen
sufficientlyaddressed.
FixStatus
| Status |     | Description |     |
| ------ | --- | ----------- | --- |
Undetermined Thestatusoftheissuewasnotdeterminedduringthisengagement.
| Unresolved |     | Theissuepersistsandhasnotbeenresolved. |     |
| ---------- | --- | -------------------------------------- | --- |
PartiallyResolved Theissuepersistsbuthasbeenpartiallyresolved.
| Resolved |     | Theissuehasbeensufficientlyresolved. |     |
| -------- | --- | ------------------------------------ | --- |
TrailofBits
63 Uniswapv4CoreSecurityAssessment
PUBLIC