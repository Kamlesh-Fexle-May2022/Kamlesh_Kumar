/**
*  Description     :  Retrieve the district which is start from s and length is greater than 3
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  07/06/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class CodeWithCountryWithStateAndDistrict {
    /**
    *   @description    :  print country with state and district
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/06/2022 - Developer Name - Kamlesh Kumar
    **/
    public static void codeWithCountryWithStateAndDistrict() {
    
        map<String, Map<String, Map<String, List<String>>>> mapWithCountryWithStateWithDistrict = new map<String, Map<String, Map<String, List<String>>>>();

        // Add district in key
        Map<String, List<String>> mapDistrictWithState = new Map<String, List<String>>{
            'Rajasthan' => new List<String>{'Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh','Rajsamand','Sikar'},

            'Uttar Pradesh' => new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'Siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'},

            'Gujarat' =>  new List<String>{'Ahmedabad','Amreli','Anand','Aravalli','Banaskantha','Bharuch','Bhavnagar','Botad','Chhota Udepur','Dahod','Dangs (Ahwa)','Devbhoomi Dwarka','Gandhinagar','Gir Somnath','Jamnagar','Junagadh','Kachchh','Kheda (Nadiad)','Mahisagar','Mehsana','Morbi','Narmada (Rajpipla)','Navsari','Panchmahal','Patan','Porbandar','Rajkot','Sabarkantha','Surat','Surendranagar','Tapi (Vyara)','Vadodara','Valsad'},

            'Andalusia' => new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Córdoba', 'Jaén', 'Granada', 'Almería'},

            'Catalonia' => new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'},

            'Galicia' => new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia', 'Podolia'},

            'Arun Kshetra' => new List<String>{'Arundel', 'Bognor Regis', 'Littlehampton'},

            'Janakpur Kshetra' => new List<String>{'Dhanusha' , 'Madhesh'},

            'Kathmandu' => new List<String>{'Dolpa', 'Humla', 'Taplejung', 'Gorkha'}
        };

        // Add state 
        Map<String, List<String>> mapStateWithCountry = new Map<String, List<String>>{
            'India' => new List<String>{'Rajasthan', 'Uttar Pradesh', 'Gujarat'},
            'Spain' => new List<String>{'Andalusia', 'Catalonia', 'Galicia'},
            'Nepal' => new List<String>{'Arun Kshetra', 'Janakpur Kshetra', 'Kathmandu'}
        };
        map<String, List<String>> mapCountryWithCode = new map<String, List<String>>{
            '+91' => new List<String>{'India'},
            '+585' => new List<String>{'Spain'},
            '+98' => new List<String>{'Nepal'}
        };
        // Add country, state and district on map
        for(String keyOfCode : mapCountryWithCode.keySet()) {
            if(!mapWithCountryWithStateWithDistrict.containsKey(keyOfCode)) 
                mapWithCountryWithStateWithDistrict.put(keyOfCode, new Map<String,Map<String, List<String>>>());
                                                        
            if(mapWithCountryWithStateWithDistrict.containsKey(keyOfCode)) {
                for(String country : mapCountryWithCode.get(keyOfCode)) {
                    mapWithCountryWithStateWithDistrict.get(keyOfCode).put(country, new Map<String,List<String>>());
                    for(String state :mapStateWithCountry.get(country)){
                        mapWithCountryWithStateWithDistrict.get(keyOfCode).get(country).put(state, new List<String>());
                        if(mapWithCountryWithStateWithDistrict.get(keyOfCode).get(country).containsKey(state)) {
                            mapWithCountryWithStateWithDistrict.get(keyOfCode).get(country).get(state).addAll(mapDistrictWithState.get(state));
                        }
                    }                                                  
                  
                }
            }
        }
            if(!mapWithCountryWithStateWithDistrict.isEmpty()){
                for(String countryCode :mapWithCountryWithStateWithDistrict.keySet()){
                    if(!mapWithCountryWithStateWithDistrict.get(countryCode).isEmpty()){
                    for(String countryName : mapWithCountryWithStateWithDistrict.get(countryCode).keySet()){
                        if(countryName.indexOf('I')==0){
                            if(!mapWithCountryWithStateWithDistrict.get(countryCode).get(countryName).isEmpty()){
                            for(String state :mapWithCountryWithStateWithDistrict.get(countryCode).get(countryName).KeySet()){
                                if(state.indexOf('R')==0){
                                    if(!mapWithCountryWithStateWithDistrict.get(countryCode).get(countryName).get(state).isEmpty()){
                                    for(String district : mapWithCountryWithStateWithDistrict.get(countryCode).get(countryName).get(state)){
                                        if(district.indexOf('S')==0 &&district.length() >= 5){
                                            System.debug(countryCode+'=>'+countryName+ '=>'+state+ '=>'+district);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
