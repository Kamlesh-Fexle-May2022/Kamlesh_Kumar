trigger Opportunity_Trigger on Opportunity (after insert, after update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        OpportunityTriggerHandlar.fillRecordOnObjects(Trigger.New);
    }
}