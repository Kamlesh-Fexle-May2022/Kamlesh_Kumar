/**
*  Description     :  Retrieve the district which is start from s and length is greater than 3
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  07/05/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class CountryStateAndDistrict {
    /**
    *   @description    :  print country with state and district
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Developer Name - Kamlesh Kumar
    **/
public static void findDistrictName(String countryCode_1, String countryName_1,String stateName,String startWithChar) {
    Map<String, Map<String, Map<String, List<String>>>> countryCode = new Map<String, Map<String, Map<String, List<String>>>>();
    Map<String, Map<String, List<String>>> country = new Map<String, Map<String, List<String>>>();

    // District  for Rajasthan
    List<String> rajasthandistrict = new List<String>{'Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh','Rajsamand','Sikar'};
    List<String> gujaratdistrict =  new List<String>{'Ahmedabad',
    'Amreli','Anand','Aravalli','Banaskantha','Bharuch','Bhavnagar','Botad','Chhota Udepur','Dahod','Dangs (Ahwa)','Devbhoomi Dwarka','Gandhinagar','Gir Somnath','Jamnagar','Junagadh','Kachchh','Kheda (Nadiad)','Mahisagar','Mehsana','Morbi','Narmada (Rajpipla)','Navsari','Panchmahal','Patan','Porbandar','Rajkot','Sabarkantha','Surat','Surendranagar','Tapi (Vyara)','Vadodara','Valsad'};
    List<String> uttarPradeshdistrict = new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'Siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'};
    List<String> andalusiadistrict =  new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Granada', 'Almería'};

    List<String> cataloniadistrict =  new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'};

    List<String> galiciadisrtict =  new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia', 'Podolia'};
    Map<String, List<String>> state = new Map<String, List<String>>();
    state.put('Rajasthan', rajasthandistrict);
    state.put('Gujarat', gujaratdistrict);
    state.put('Uttar Pradesh', uttarPradeshdistrict);
    Map<String, List<String>> state_2 = new Map<String, List<String>>();
    state_2.put('Andalusia', andalusiadistrict);
    state_2.put('Catalonia', cataloniadistrict);
    state_2.put('Galicia', galiciadisrtict);
    Map<String, Map<String, List<String>>> countryName = new Map<String, Map<String, List<String>>>();
        countryName.put('India', state);

    Map<String, Map<String, List<String>>> countryName_2 = new Map<String, Map<String, List<String>>>();
        countryName_2.put('Spain', state_2);
    // Add country with country code on map
    countryCode.put('+91', countryName);
    countryCode.put('34', countryName_2);
    // Find the code, country name, states and districts
    for(String code : countryCode.keySet()) {
        if(code.equals(countryCode_1)) {
            for(String countryNames : countryCode.get(code).keySet()) {
                if(countryNames.equals(countryName_1)) {
                    for(String stateNames : countryCode.get(code).get(countryNames).keySet()) {
                        if(stateNames.equals(stateName)) {                            
                            for(String districtName : countryCode.get(code).get(countryNames).get(stateNames)) {                                 
                                if(districtName.startsWith(startWithChar) && districtName.length() >= 5) {
                                    System.debug(districtName);
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