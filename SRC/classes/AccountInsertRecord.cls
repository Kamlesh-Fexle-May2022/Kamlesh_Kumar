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
        acc.id ='0015i00000BDPHrAAP';
        acc.Name = 'Shahil';
        acc.AccountNumber = '324964587673';
        acc.Phone = '5125562355';
        System.debug(acc);
        //insert acc;
        //delete acc;
        update acc;

    }
}