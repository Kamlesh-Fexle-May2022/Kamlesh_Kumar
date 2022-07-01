/**
* Description   - This Keyword
*
* Created By    - Kamlesh Kumar
*
* Created Date  - 29/06/2022
*
* Revision Logs  -  V_1.0 - Created  - Kamlesh Kumar
*
**/
public with sharing class ThisKeyword {
    // Method M
    public void m() {
        System.debug('Hello M'); 
    } 
    // Method N
    public void n() {  
        System.debug('Hello N');  
        this.m();  
   }  
}
