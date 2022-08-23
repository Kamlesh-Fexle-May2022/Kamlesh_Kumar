trigger Account_Trigger on Account (before update) {
    if( trigger.isBefore && trigger.isUpdate){
        AccountTriggerHelper.processData();
        AccountTriggerHelper.processData1();
    }
}