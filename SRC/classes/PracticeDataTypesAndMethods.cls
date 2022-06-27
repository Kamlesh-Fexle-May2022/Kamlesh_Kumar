/**
*  Description     :  Apex Data Types
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  06/24/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar 
*
**/
public with sharing class PracticeDataTypesAndMethods {
     /**
     * 
     *   @description    :  All Data Types And Methods
     *  
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Developer Name - Kamlesh Kumar
     *  
     **/
    // Date Time Method
    public static void dateMethod(){
        Date myDate = Date.newInstance(2022,6,23);
        System.debug('Today Date : ' + myDate);
    }
	
    public static void dateMethod1(){
        Date myDate = Date.newInstance(2022,6,23);
        Date newDate = myDate.addYears(2);
        system.debug('New Date : '+ newDate);
    }
	
    public static void dateMethod_2(){
        Date myDate = Date.today();
        system.debug(myDate);
    }
	
    public static void dateTimeMethod_1(){
        DateTime myDateTime = DateTime.now();
        system.debug(myDateTime);
    }
	
    public static void dateTimeMethod_2(){
        DateTime myDateTime = DateTime.newInstance(1993,6,6,3,3,3);
        system.debug(myDateTime);
    
    //Boolean
    public static void bolleanExample(){
        Boolean isWinner = True;
        system.debug(isWinner);
    }
   
    // Double
    public static void doubleExample(){
        Double d = 4.5689;
        system.debug(d);
    }
   
    // ID
    public static void idExample(){
        Id i = '00300000003T2PGAA0';
        system.debug(i);
    }
   
    // Integer
    public static void integerExample(){
        Integer i = 10;
        system.debug(i);
    }
   
    // Object
    public static void objectExample(){
        Object obj = 10;
        Integer i = (Integer)obj;
        system.debug(obj);
        system.assertEquals(10, i);
    }
	
    // String Method
    public static void stringExample(){
        String str1 = 'I am learning apex.';
        system.debug(str1);
    }
   
    public static void stringMethod(){
        String str1 = 'I am learning apex.';
        String str2 = str1.capitalize();
        system.debug(str2);
    }
   
    public static void stringMethod_1(){
        String str1 = 'i am learning apex.';
        system.debug(str1.isAllLowerCase());
    }
   
    // Map method
    public static void mapMethod(){
        Map<String,String> myString = new Map<String,String>{'a'=> 'b', 'C' => 'd'.toLowerCase()};
        system.debug(myString);
    }
   
    public static void mapMethod_1(){
        Map<String,String> country_Currencies = new Map<String,String>();
        map<ID, Set<String>> m = new Map<Id, set<String>>();
        system.debug(m);
    }
   
    public static void mapMethod_2(){
        Map<Integer,String> rollNumber_Name = new Map<Integer,String>();
        rollNumber_Name.put(01,'Abhishek Girhare');
        rollNumber_Name.put(02,'Aakash Bhade');
        system.debug(rollNumber_Name);
    }
   
    //List Method
    public static void listMethod_1(){
        List<String> myList = new List<String>();
        myList.add('Abhshek');
        myList.add('Aakash');
        system.debug(myList);
    }
	
    public static void listMethod_2(){
        List<String> myList = new List<String>{'Bhopal','Indore','Jabalpur','Betul'};
        system.debug(myList);
    }

    // Set Method
    public static void setMethod_1(){
        Set<Integer> mySet = new Set<Integer>();
        mySet.add(45);
        mySet.add(56);
        mySet.add(89);
        mySet.add(45);
        system.debug(mySet);      
	}
  }
