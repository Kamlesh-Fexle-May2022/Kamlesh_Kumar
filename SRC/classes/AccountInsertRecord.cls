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
    public AccountInsertRecord() {
        Account acc = new Account();
        List<Account> acc_4 = [SELECT Name FROM Account Where Name = 'Shahil'];
        for(Account accName : acc_4) {
            if(accName.Name.equals('Shahil')) {
                accName.Name = 'Aron';
            }
        }
        update acc;
    }
}
