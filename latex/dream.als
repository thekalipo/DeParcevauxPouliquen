
//Sig
sig Email, Location {}

abstract sig User {
email : Email
}

sig PolicyMaker extends User {
area : some Location,
well : lone WellPerformingFarmers,
poor : lone PoorlyPerformingFarmers,
farmersWithConfirmation : set Farmer //Set of farmers who confirmed their batch of production release. We want to keep it up-to-date
} 

sig Farmer extends User {
policyMaker : lone PolicyMaker,
location : Location,
production : lone Batch
}

abstract sig Release {}

sig CompleteRelease, IncompleteRelease extends Release {}

abstract sig Batch {
batch : some Release, // A batch is a non empty set of releases. It can gather releases from different types or dates
}

sig ReleaseBatch extends Batch {}
sig ConfirmedBatch extends Batch {}
{
not (IncompleteRelease in batch)
}

sig WellPerformingFarmers { // Gather all well performing farmers of a given policy maker
farmers : some Farmer
}

sig PoorlyPerformingFarmers {
farmers : some Farmer
}

sig BestPractice {
wellToPm : Farmer -> PolicyMaker,
}

sig HelpRequest {
farmerToPm: Farmer -> PolicyMaker
}

sig Suggestion {
pmToFarmer: PolicyMaker -> Farmer
}

//Functions
fun farmersInArea [pm:PolicyMaker] : set Farmer {  // Gives the set of farmers in the pm area
policyMaker.pm
}


//Facts
fact uniqueEmail {
all disj u1, u2: User |
u1.email != u2.email
}

fact noAreaIntersection {
all disj pm1,pm2 : PolicyMaker | pm1.area & pm2.area = none
}

fact farmerInPmArea {
all f: Farmer |  f.policyMaker != none implies f.location in f.policyMaker.area
}

fact noBatchIntersection {
all disj rb1,rb2 : Batch| rb1.batch & rb2.batch = none
}

fact noBatchDoubleOwnership {
all disj f1,f2 : Farmer| f1.production != f2.production
}

fact noBatchAlone {
all b:Batch | some f:Farmer | f.production = b
}

//fact noReleaseAlone {  //Commented to test the 'AddIncompleteRelease' predicate
//all r:Release | some b:Batch | r in b.batch
//}

fact confirmedBatchContainCompleteRelease {
all ir:IncompleteRelease | all cb: ConfirmedBatch | not(ir in cb.batch)
}

fact farmersWithConfirmation {
all f: Farmer | all pm: PolicyMaker | f in pm.farmersWithConfirmation iff ((some cb: ConfirmedBatch | cb = f.production) 
and f.policyMaker = pm)
}

fact BestPracticeExistence{
all bp:BestPractice | (some f:Farmer|some pm:PolicyMaker|  f.(bp.wellToPm) = pm)
}

fact HelpRequestExistence{
all hr:HelpRequest | (some f:Farmer|some pm:PolicyMaker|  f.(hr.farmerToPm) = pm)
}

fact SuggestionExistence{
all s:Suggestion | (some f:Farmer|some pm:PolicyMaker|  pm.(s.pmToFarmer) = f)
}


fact WellExistBecauseOfPm {
all wpf: WellPerformingFarmers | (some pm:PolicyMaker | pm.well = wpf)
}

fact WellPoorExistBecauseOfPm {
all ppf: PoorlyPerformingFarmers| (some pm:PolicyMaker | pm.poor = ppf)
}

fact noWellPoorIntersection{
all pm: PolicyMaker | pm.well.farmers & pm.poor.farmers = none
}

fact WellAndPoorReferToTheirPm{
all f: Farmer | all pm:PolicyMaker | ( f in pm.well.farmers or f in pm.poor.farmers) implies f.policyMaker = pm
}

fact WellAndPoorHaveBatch{
all f: Farmer|( f in f.policyMaker.well.farmers or f in f.policyMaker.poor.farmers) implies (f.production != none)
}

fact bestPracticeWellToPm {
all bp:BestPractice | all f:Farmer| all pm:PolicyMaker | f.(bp.wellToPm) = pm implies f in pm.well.farmers
}

fact helpRequestFarmerToPm {
all hr:HelpRequest | all f:Farmer| all pm:PolicyMaker| f.(hr.farmerToPm) = pm implies pm = f.policyMaker
}

fact suggestionPMToFarmer {
all s:Suggestion | all f:Farmer| all pm:PolicyMaker| pm.(s.pmToFarmer) = f implies (pm = f.policyMaker and 
(some bp:BestPractice|some f:Farmer| f.(bp.wellToPm)=pm ) and (some hr:HelpRequest|f.(hr.farmerToPm) = pm))
}


//Predicates
pred completeRelease {
all r: Release | r = CompleteRelease
}

pred confirmBatch {
all b: Batch | b = ConfirmedBatch
}

pred PoorRequestHelp {
all f:Farmer| f in (f.policyMaker).poor.farmers implies (some hr:HelpRequest| f.(hr.farmerToPm)=f.policyMaker)
}

pred PmSuggestWhenHelpRequest {
all pm:PolicyMaker | all f:Farmer| (some hr:HelpRequest | f.(hr.farmerToPm) = pm) implies (
some s:Suggestion | pm.(s.pmToFarmer) = f)
}

pred WellGiveBestPractices {
all f:Farmer| all pm:PolicyMaker |  f in pm.well.farmers implies (
some bp:BestPractice| f.(bp.wellToPm)= pm)
}

pred AddIncompleteRelease[f:Farmer,ir:IncompleteRelease] {
f.production.batch = f.production.batch + ir
}

pred definePoorWell {
#PoorlyPerformingFarmers >0 and
#WellPerformingFarmers >0
}

pred produce{
all f:Farmer | f.production != none
}

//Assertions

//Given that the farmers produced, complete their release and confirm their batch, the policy makers have all farmers with confirmed data releases (at the end of the release period)
assert EndOfReleasePeriod { 
produce and completeRelease and confirmBatch implies (
all pm:PolicyMaker|farmersInArea[pm]=pm.farmersWithConfirmation)
}


//Given that poorly performing farmers ask for help, well performing ones give their best practices and policy makers make suggestions when required, all poorly performing farmers get advices at the end of the analysis period.
assert EndOfAnalysisPeriod {
definePoorWell and PoorRequestHelp and PmSuggestWhenHelpRequest and WellGiveBestPractices implies (
all f:Farmer | f in PoorlyPerformingFarmers.farmers implies(
some s:Suggestion| (f.policyMaker).(s.pmToFarmer) = f)
)
}

//When a farmer makes a new release, he/she should be dropped out of the list of farmers who confirmed their batch
assert AdditionDeconfirmABatch {
all f:Farmer | all ir:IncompleteRelease | (all f2:Farmer| ir not in f2.production.batch) implies (AddIncompleteRelease[f,ir] implies f not in f.policyMaker.farmersWithConfirmation)
}

//Commands

//run {} for 5
check EndOfReleasePeriod for 5
check EndOfAnalysisPeriod for 5
check AdditionDeconfirmABatch for 5




