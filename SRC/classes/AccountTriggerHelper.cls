/**
*  Description     :  OpportunityTriggerHandlar Class
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  06/08/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class AccountTriggerHelper {
    //Custom Validations
    public static void processData(){
        List<Account> newList = Trigger.New;
        List<Account> oldList = Trigger.Old;
        Integer count = 0;
        for(Account acc : newList){
            if(acc.Phone == Null && oldList[count].Phone != Null){
                acc.addError('you can not blank Phone Number');
            }
            if(acc.Website == Null && oldList[count].Website != Null){
                acc.addError('you can not blank Website');
            }
            if(acc.AccountNumber == Null && oldList[count].AccountNumber != Null){
                acc.addError('you can not blank AccountNumber');
            }
            if(acc.AnnualRevenue !=oldList[count].AnnualRevenue && acc.AnnualRevenue > 100) {
                acc.Discount__c = 50;
            }  
        }
        count++;
    }
    
    public static void processData1(){
        List<Account> newList = Trigger.New;
        List<Account> oldList = Trigger.Old;
        List<Opportunity> opportunities = [Select Id, Name, AccountId, Amount From Opportunity Where AccountId IN : newList];
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : opportunities){
            if(opp.Amount > 100 ) {
                accountIds.add(opp.AccountID);
            }
            Integer count = 0;
            for(Account acc : newList) {
                if(accountIds.contains(acc.Id)){
                    acc.Type = 'Prospect';
                }
            }
            count++;
        }            
    }
}