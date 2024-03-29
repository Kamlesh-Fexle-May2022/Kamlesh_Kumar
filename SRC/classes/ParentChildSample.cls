/**
*  Description     :  Insert Parent Child Record using foreign key
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  07/11/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class ParentChildRelationShip {
    /**
    *   @description    :  Insert parent Child Record Used only for foreign key reference
    *                       and doesn't contain any other fields. 
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/11/2022 - Developer Name - Kamlesh Kumar
    **/
    public static void InsertParentChild() {
        Date dt = Date.today()+7;
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=dt);
       
        Account accountReference = new Account(
            MyExtID__c='SAP111111');                
        newOpportunity.Account = accountReference;
       
        // Used for the insert.
        Account parentAccount = new Account(
            Name='Hallie',
            MyExtID__c='SAP111111');      
        
        // Create the account and the opportunity.
        Database.SaveResult[] results = Database.insert(new SObject[] {
            parentAccount, newOpportunity });
        
        // Check results.
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
            System.debug('Successfully created ID: '
                  + results[i].getId());
            } else {
            System.debug('Error: could not create sobject '
                  + 'for array element ' + i + '.');
            System.debug('   The error reported was: '
                  + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}
