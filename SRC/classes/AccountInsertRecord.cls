/**
*  Description     :  Insert Record IN Account
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  07/04/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class AccountInsertRecord {
    /**
    *   @description    :  Insert Record IN Account
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/04/2022 - Developer Name - Kamlesh Kumar
    **/
    public static void accountInsertRecord() {
        List<Account> accList = new List<Account>();
            for(Integer i=1;i<20;i++)
            {
                Account a = new Account(Name = 'Test Account'+i);
                accList.add(a);
            }
        insert accList;
    }
    
    public static void accountUpdateRecord() {
        List<Account> accList = [Select Name from Account where CreatedDate = TODAY];
            for(Account a : accList)
            {
             	a.Name = a.Name + 'Update';
            }
        update accList;
    }
    
    public static void accountUpsertRecord() {
        List<Account> accList = [Select Name,NumberOfEmployees from Account where CreatedDate = TODAY];
            for(Account a : accList)
            {
             	a.NumberOfEmployees = 1001;
            }
        	for(Integer i=0;i<=50;i++)
            {
                Account a = new Account(Name = 'NewRecords in Upsert'+i);
                accList.add(a);
            }
        upsert accList;
    }
}
