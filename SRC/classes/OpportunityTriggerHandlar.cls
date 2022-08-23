/**
*  Description     :  OpportunityTriggerHandlar Class
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  10/08/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public class OpportunityTriggerHandlar {
/**
*  Description     :  insertOrUpdateOpportunityAndRelatedObjects  Method
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  10/08/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/

// Insertion and updation the record on the Automobiles objects
    static final String CONST_AUTOMOBILE_SENSOR = '00:11:CE:00';
    static final String CONST_AUTOMOBILE_PRESENCE_SENSOR = '00:11:CE:D';
    static final String CONST_AUTOMOBILE_TAG = '00:11:CE:E';

    public static void fillRecordOnObjects(List<Opportunity> newList) {
        
        // Retreive Automobile Sensor old record
        Map<String, Automobile_Sensor__c> oldMapSensor = new Map<String, Automobile_Sensor__c> ();
        // Query On Automobile Sensor And Store in List
        List<Automobile_Sensor__c> listOfSensor = new List<Automobile_Sensor__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Sensor__c ]);
        for(Automobile_Sensor__c sensor : listOfSensor){
            oldMapSensor.put(sensor.Name, sensor);
        }
        // Retreive Automobile Presence Sensor old record
        Map<String, Automobile_Presence_Sensor__c> oldMapPresence = new Map<String, Automobile_Presence_Sensor__c>();
        // Query On Automobile Presence Sensor And Store in List
        List<Automobile_Presence_Sensor__c> listOfPresence = new List<Automobile_Presence_Sensor__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensor__c]);
        for(Automobile_Presence_Sensor__c Presence : listOfPresence){
            oldMapPresence.put(Presence.Name, Presence);
        }
        // Retreive Automobile TDU Sensor old record
        Map<String, Automobile_TDU__c> oldMapTDU = new Map<String, Automobile_TDU__c>();
        // Query On Automobile TDU Sensor And Store in List
        List<Automobile_TDU__c> listOfTDU = new List<Automobile_TDU__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_TDU__c]);
        for(Automobile_TDU__c tdu : listOfTDU){
            oldMapTDU.put(tdu.Name, tdu);
        }
        // Retreive Automobile Tag Sensor old record
        Map<String, Automobile_Tag__c> oldMapTag = new Map<String, Automobile_Tag__c>();
        // Query On Automobile Tag Sensor And Store in List
        List<Automobile_Tag__c> listOfTag = new List<Automobile_Tag__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Tag__c]);
        for(Automobile_Tag__c tag : listOfTag){
            oldMapTag.put(tag.Name, tag);
        }
        // Map Hold the new record Of Automobile Sensor
        Map<String, Automobile_Sensor__c> mapOfSensor = new Map<String, Automobile_Sensor__c>();
        // Map Hold the new record Of Automobile Presence Sensor
        Map<String, Automobile_Presence_Sensor__c> mapOfPresence = new Map<String, Automobile_Presence_Sensor__c>();
        // Map Hold the new record Of Automobile TDU Sensor
        Map<String, Automobile_TDU__c> mapOfTDU = new Map<String, Automobile_TDU__c>();
        // Map Hold the new record Of Automobile Tag Sensor
        Map<String, Automobile_Tag__c> mapOfTag = new Map<String, Automobile_Tag__c>();
        // List Store the updated record Of Automobile Sensor
        Map<String,Automobile_Sensor__c> mapUpdateSensor = new Map<String,Automobile_Sensor__c>();
        // List Store the updated record Of Automobile Presence Sensor
        Map<String,Automobile_Presence_Sensor__c> mapUpdatePresence = new Map<String,Automobile_Presence_Sensor__c>();
        // List Store the updated record Of Automobile TDU Sensor
        Map<String,Automobile_TDU__c> mapUpdateTDU = new  Map<String,Automobile_TDU__c>();
        // List Store the updated record Of Automobile Tag Sensor
        Map<String,Automobile_Tag__c> mapUpdateTag = new Map<String,Automobile_Tag__c>();
        // Name Of Return To HQ 
        Set<String> namesOfReturnHQ = new Set<String>();
        // Invalid Sensor
        Set<String> invalidSensor = new Set<String>();
        // Already Exist Sensor
        Set<String> alreadyExistSensors = new Set<String>();
        Set<String> setOfTags = new Set<String>();
        Set<String> setOfHQ = new Set<String>();
        for(Opportunity opp : newList){   
            // For Shipped To Customer Stage & Return to Customer Stage      
            if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer'){
                if(opp.Automobile_Tag_Details_1__c != null){
                    for(String str : opp.Automobile_Tag_Details_1__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }
                if(opp.Automobile_Tag_Details_2__c != null){
                    for(String str : opp.Automobile_Tag_Details_2__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }
                if(opp.Automobile_Tag_Details_3__c != null){
                    for(String str : opp.Automobile_Tag_Details_3__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }                
                if(setOfTags != null){
                    for(String str : setOfTags){
                        //Instance Of Automobile Sensor
                        Automobile_Sensor__c sensorObj = new Automobile_Sensor__c();
                        //Instance Of Automobile Presence Sensor
            			Automobile_Presence_Sensor__c presenceObj = new Automobile_Presence_Sensor__c();
            			Automobile_TDU__c objOfTDU = new Automobile_TDU__c(); //Instance Of Automobile Presence Sensor
            			Automobile_Tag__c tagObj = new Automobile_Tag__c();   //Instance Of Automobile Tag Presence Sensor
                        
                        if(str.length() > 18){           //Checking the condition
                            str = str.Substring(0,18);
						}
                        // checking for Automobile Sensor
                        if(str.startsWith(CONST_AUTOMOBILE_SENSOR)){                            
                            sensorObj.Name = str;
                            sensorObj.Account__c = opp.AccountId;
                            sensorObj.Opportunity__c = opp.Id;        
                            //Insert the record on automobile sensor object if stage is Shipped To Customer OR Return to Customer                                            
                            if(!oldMapSensor.containsKey(sensorObj.Name)){
                                if(!mapOfSensor.containsKey(sensorObj.Name)){
                                    mapOfSensor.put(sensorObj.Name, sensorObj);
                                }
                            }
                            // Update the record of account on automobile sensor if stage is return to customer
                            else if(oldMapSensor.containsKey(sensorObj.Name) && opp.StageName == 'Return to Customer' && oldMapSensor.get(sensorObj.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_Sensor__c  record = oldMapSensor.get(sensorObj.Name) ;
                                record.Name = sensorObj.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                               
                                if(!oldMapSensor.containsKey(sensorObj.Name) && oldMapSensor.get(sensorObj.Name).Opportunity__c == opp.Id){
                                   mapUpdateSensor.put(sensorObj.Name,record);
                                }
                                
                            }  
                            else if(oldMapSensor.containsKey(sensorObj.Name)){
                                alreadyExistSensors.add(sensorObj.Name);
                            }
                        }
                         // checking for Automobile Presence Sensor
                        else if(str.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR)){
                            presenceObj.Account__c = opp.AccountId;
                            presenceObj.Opportunity__c = opp.Id;
                            presenceObj.Name = str;
                            //Insert the record on automobile presence sensor object if stage is Shipped To Customer OR Return to Customer                           
                            if(!oldMapPresence.containsKey(presenceObj.Name)){
                                if(!mapOfPresence.containsKey(presenceObj.Name)){
                                    mapOfPresence.put(presenceObj.Name, presenceObj);
                                }
                            }
                            // Update the record of account on automobile presence sensor if stage is return to customer
                            else if(oldMapPresence.containsKey(presenceObj.Name) && opp.StageName == 'Return to Customer' && oldMapPresence.get(presenceObj.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_Presence_Sensor__c  record = oldMapPresence.get(presenceObj.Name) ;
                                record.Name = presenceObj.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                  
                                if(!oldMapPresence.containsKey(presenceObj.Name) && oldMapPresence.get(presenceObj.Name).Opportunity__c == opp.Id){
                                   mapUpdatePresence.put(presenceObj.Name,record);
                                }
                             
                            }   
                            else if(oldMapPresence.containsKey(presenceObj.Name)){
                                alreadyExistSensors.add(presenceObj.Name);
                            }
                        }
                        // checking for Automobile TDU Sensor
                        else if(str.startsWith(CONST_AUTOMOBILE_TAG)){
                            objOfTDU.Name = str;
                            objOfTDU.Account__c = opp.AccountId;
                            objOfTDU.Opportunity__c = opp.Id;
                            //Insert the record on automobile tdu object if stage is Shipped To Customer OR Return to Customer 
                            if(!oldMapTDU.containsKey(objOfTDU.Name)){
                                if(!mapOfTDU.containsKey(objOfTDU.Name)){
                                    mapOfTDU.put(objOfTDU.Name, objOfTDU);
                                }
                            }
                            // Update the record of account on automobile TDU if stage is return to customer
                            else if(oldMapTDU.containsKey(objOfTDU.Name) && opp.StageName == 'Return to Customer' && oldMapTDU.get(objOfTDU.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_TDU__c  record = oldMapTDU.get(objOfTDU.Name) ;
                                record.Name = objOfTDU.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                                if(!oldMapTDU.containsKey(objOfTDU.Name) && oldMapTDU.get(objOfTDU.Name).Opportunity__c == opp.Id){
                                   mapUpdateTDU.put(objOfTDU.Name,record);
                                }
                                
                              
                            }
                            else if(oldMapTDU.containsKey(objOfTDU.Name)){
                                alreadyExistSensors.add(objOfTDU.Name);
                            }                            
                        }
                        else{  
                            // checking for Automobile Tag Sensor
                            if(str.substring(0, 3).isNumeric()){                           
								tagObj.Name = str;
                                tagObj.Opportunity__c = opp.Id;
                                tagObj.Account__c = opp.AccountId;
                                //Insert the record on automobile tag object if stage is Shipped To Customer OR Return to Customer 
                                if(!oldMapTag.containsKey(tagObj.Name)){
                                    if(!mapOfTag.containsKey(tagObj.Name)){
                                        mapOfTag.put(tagObj.Name, tagObj);
                                    }
                                }
                                // Update the record of account on automobile Tag if stage is return to customer
                                else if(oldMapTag.containsKey(tagObj.Name) && opp.StageName == 'Return to Customer'  && opp.StageName == 'Return to Customer' && oldMapTag.get(tagObj.Name).Account__c == opp.Shipment_Account__c){
                                    Automobile_Tag__c  record = oldMapTag.get(tagObj.Name) ;
                                    record.Name = tagObj.Name;
                                    record.Account__c = opp.AccountId;
                                    record.Opportunity__c = opp.Id;
                         
                                    if(!oldMapTag.containsKey(tagObj.Name) && oldMapTag.get(tagObj.Name).Opportunity__c == opp.Id){
                                   mapUpdateTag.put(objOfTDU.Name,record);
                                }
                                                                    
                                }
                                else if(oldMapTag.containsKey(tagObj.Name)){
                                	alreadyExistSensors.add(tagObj.Name);
                            	}
                            }
                            else{
                                invalidSensor.add(str);
                            }
                        }
                    }
                }           
            }
           // Return to HQ
            else if(opp.StageName == 'Return to HQ'){           
               if(opp.Return_To_HQ__c != null){   
                                       
                    for(String str : opp.Return_To_HQ__c.split('\n')){
                        setOfHQ.add(str.trim());
                    }         
                    for(String str : setOfHQ){                        
                        if(str.length() > 18){                       
                            str = str.Substring(0,18);
						}
                        // checking for Automobile Sensor
                        if(str.startsWith(CONST_AUTOMOBILE_SENSOR)){                        
                            if(oldMapSensor.containsKey(str)){
                                Automobile_Sensor__c  record = oldMapSensor.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                mapUpdateSensor.put(str,record);
                                namesOfReturnHQ.add(str);
                            }
                        }
                        // checking for Automobile Presence Sensor
                        else if(str.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR)){                        
                            if(oldMapPresence.containsKey(str)){
                                Automobile_Presence_Sensor__c  record = oldMapPresence.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                mapUpdatePresence.put(str,record);
                                namesOfReturnHQ.add(str);
                            } 
                        }
                        // checking for Automobile TDU Sensor
                        else if(str.startsWith(CONST_AUTOMOBILE_TAG)){                       
                            if(oldMapTDU.containsKey(str)){
                                Automobile_TDU__c  record = oldMapTDU.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                mapUpdateTDU.put(str,record);
                                namesOfReturnHQ.add(str);
                            }
                        }
                        else{ 
                            // checking for Automobile Tag Sensor
                            if(str.substring(0, 3).isNumeric()){                           
                                if(oldMapTag.containsKey(str)){
                                    Automobile_Tag__c  record = oldMapTag.get(str) ;
                                    record.Name = str;
                                    record.Account__c = opp.Shipment_Account__c;
                                    record.Opportunity__c = opp.Id;
                                    mapUpdateTag.put(str,record);
                                    namesOfReturnHQ.add(str);
                                }
                            }
                        }
                    }
            	}
            }           
        }
        // Inserting all the map of objects
        if(!mapOfSensor.values().isEmpty()){
            insert mapOfSensor.values();       
        }
        if(!mapOfPresence.values().isEmpty()){
            insert mapOfPresence.values();
        }
        if(!mapOfTDU.values().isEmpty()){
            insert mapOfTDU.values();
        }
        if(!mapOfTag.values().isEmpty()){
            insert mapOfTag.values();
        }
        // update all the map of sensors
        if(!mapUpdateSensor.isEmpty()){
            update mapUpdateSensor.values();
        }
        if(!mapUpdatePresence.isEmpty()){
            update mapUpdatePresence.values();
        }
        if(!mapUpdateTDU.isEmpty()){
            update mapUpdateTDU.values();
        }
        if(!mapUpdateTag.isEmpty()){
            update mapUpdateTag.values();
        }  
        // Store all names of new record sensor, presence, tdu and tag
        Set<String> namesOfInsertTags = new Set<String>();
        
        if(!mapOfSensor.isEmpty()){
            namesOfInsertTags.addAll(mapOfSensor.keySet());
        } 
        if(!mapOfPresence.isEmpty()){
            namesOfInsertTags.addAll(mapOfPresence.keySet());
        } 
        if(!mapOfTDU.isEmpty()){
            namesOfInsertTags.addAll(mapOfTDU.keySet());
        } 
        if(!mapOfTag.isEmpty()){
            namesOfInsertTags.addAll(mapOfTag.keySet());
        } 
        // Update records fill on set
        Set<String> namesOfUpdateTags = new Set<String>();
        if(!mapUpdateSensor.isEmpty()){
            for(Automobile_Sensor__c sensor : mapUpdateSensor.values()){
                namesOfUpdateTags.add(sensor.name);
            }
        }
        if(!mapUpdatePresence.isEmpty()){
            for(Automobile_Presence_Sensor__c presence : mapUpdatePresence.values()){
                namesOfUpdateTags.add(presence.name);
            }
        }
        if(!mapUpdateTDU.isEmpty()){
            for(Automobile_TDU__c tdu : mapUpdateTDU.values()){
                namesOfUpdateTags.add(tdu.name);
            }
        }
        if(!mapUpdateTag.isEmpty()){
            for(Automobile_Tag__c tag : mapUpdateTag.values()){
                namesOfUpdateTags.add(tag.name);
            }
        }
        for(Opportunity opp : newList){
            if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer' || opp.StageName == 'Return to HQ'){
                sendEmail(mapOfSensor, mapOfPresence, mapOfTDU, mapOfTag,  mapUpdateSensor,mapUpdatePresence, mapUpdateTDU,mapUpdateTag, newList, setOfHQ,setOfTags );
            }
        }
        // Send the mail of the user with successful records and unsuccessful records.
    }
    public static void sendEmail( Map<String, Automobile_Sensor__c> mapOfSensor, Map<String, Automobile_Presence_Sensor__c> mapOfPresence,  Map<String, Automobile_TDU__c> mapOfTDU,  Map<String, Automobile_Tag__c> mapOfTag, Map<String,Automobile_Sensor__c> mapUpdateSensor,Map<String,Automobile_Presence_Sensor__c> mapUpdatePresence, Map<String,Automobile_TDU__c> mapUpdateTDU,Map<String,Automobile_Tag__c> mapUpdateTag, List<Opportunity> newList,Set<String> setOfHQ,Set<String> setOfTags){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Set<String> accId = new Set<String>();
        for(Opportunity opp : newList){
            accId.add(opp.AccountID);
            accId.add(opp.Shipment_Account__c);
        }
        Map<Id, Account> accountMap = new Map<Id, Account>([Select Id, Name FROM Account WHERE Id IN : accId]);
        for(Opportunity opp : newList){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(opp.OwnerId);
            mail.setToAddresses(sendTo);
            mail.setSubject(opp.Name + ' ' + Date.today().format());
            String body = ' ';
            body = '<table border="1" style="border-collapse: collapse"><caption style="font-weight:bold;text-align: left;">Successful:<br/><br/></caption><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';                  
            for(String names : setOfTags){                   
                if(names.startsWith(CONST_AUTOMOBILE_SENSOR) && mapOfSensor.containsKey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor inserted under installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR) && mapOfPresence.containsKey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;'  + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence Sensor inserted under installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_TAG) && mapOfTag.containsKey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'TDU' + '&nbsp;'  +'</td><td>'+ '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TUD inserted under installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else{
                    if(names.substring(0, 3).isNumeric() && mapOfTDU.containsKey(names)){
                        body += '<tr><td>'+ ' &nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag inserted under installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;'  +'</td></tr>';
                    }
                }        
            }
            for(String names : setOfTags){ 
                if(names.startsWith(CONST_AUTOMOBILE_SENSOR) && mapUpdateSensor.containsKey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor is moved from shipment account ' +  accountMap.get(opp.Shipment_Account__c).Name +  ' to installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR) && mapUpdatePresence.containskey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor is moved from shipment account ' +  accountMap.get(opp.Shipment_Account__c).Name +  ' to installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_TAG) && mapUpdateTag.containskey(names)){
                    body += '<tr><td>'+ ' &nbsp;' + 'TDU' + ' &nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU is moved from shipment account ' +  accountMap.get(opp.Shipment_Account__c).Name +  ' to installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                }
                else{ 
                    if(names.substring(0, 3).isNumeric() && mapUpdateTDU.containskey(names)){
                        body += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag is moved from shipment account ' +  accountMap.get(opp.Shipment_Account__c).Name +  ' to installation account ' + accountMap.get(opp.AccountID).Name + '&nbsp;' +'</td></tr>';
                    }
                }
            }
            for(String names : setOfHQ){             
                if(names.startsWith(CONST_AUTOMOBILE_SENSOR) && mapUpdateSensor.containskey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names +  '&nbsp;'  + '</td><td>' +  '&nbsp;&nbsp; Sensor is moved from installation account ' +  accountMap.get(opp.AccountID).Name +  ' to shipment account ' + '&nbsp;' + '</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR) && mapUpdatePresence.containskey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor is moved from installation account ' +  accountMap.get(opp.AccountID).Name +  ' to shipment account ' + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith(CONST_AUTOMOBILE_TAG) && mapUpdateTag.containskey(names)){
                    body += '<tr><td>'+ ' &nbsp;' + 'TDU' + ' &nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU is moved from installation account ' +  accountMap.get(opp.AccountID).Name +  ' to shipment account' + '&nbsp;' +'</td></tr>';
                }
                else{
                    if(names.substring(0, 3).isNumeric() && mapUpdateTDU.containskey(names)){
                    body += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag is moved from installation account ' +  accountMap.get(opp.AccountID).Name +  ' to shipment account ' + '&nbsp;'  +'</td></tr>';
                    }
                }  
            }
            body += '</table>';
            body += '<br/><br/><br/><table border="1" style="border-collapse: collapse"><caption style="font-weight:bold;text-align: left;">Unsuccessful:<br/><br/></caption><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';  
            for(String names : setOfTags){
                if(!names.startsWith(CONST_AUTOMOBILE_SENSOR) || !names.startsWith(CONST_AUTOMOBILE_PRESENCE_SENSOR) || !names.startsWith(CONST_AUTOMOBILE_TAG) || !names.substring(0, 3).isNumeric()){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Invalid sensor  ' + '&nbsp;' +'</td></tr>';
                }
                else{
                    if(!mapOfSensor.containsKey(names) && !mapUpdateSensor.containskey(names)){
                        body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + ' &nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor can’t inserted under installation account '  +  accountMap.get(opp.AccountID).Name +  ' b/c it is already exists under the installation account. ' + accountMap.get(opp.Shipment_Account__c).Name + '&nbsp; ' +'</td></tr>';
                    }
                    else if(!mapOfPresence.containsKey(names) && !mapUpdatePresence.containsKey(names)){
                        body += '<tr><td>'+ '&nbsp; ' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor can’t inserted under installation account ' +  accountMap.get(opp.AccountID).Name +  ' b/c it is already exists under the installation account. ' + accountMap.get(opp.Shipment_Account__c).Name + '&nbsp;' +'</td></tr>';
                    }
                    else if(!mapOfTag.containsKey(names) && !mapUpdateTag.containskey(names)){
                        body += '<tr><td>'+ '&nbsp;' + 'TDU' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU can’t inserted under installation account ' +  accountMap.get(opp.AccountID).Name +  ' b/c it is already exists under the installation account. ' + accountMap.get(opp.Shipment_Account__c).Name + '&nbsp;' +'</td></tr>';
                    }
                    else{
                        if(!mapOfTDU.get(names).Name.substring(0, 3).isNumeric() && mapUpdateTDU.containskey(names)){
                            body += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp; &nbsp; Tag can’t inserted under installation account ' +  accountMap.get(opp.AccountID).Name +  ' b/c it is already exists under the installation account. ' + accountMap.get(opp.Shipment_Account__c).Name + '&nbsp;' +'</td></tr>';
                        }
                    } 
                }
            body +='</table>'; 
            mail.setHtmlBody(body);
            mails.add(mail);   
            }
         Messaging.sendEmail(mails);
        }   
    }
}