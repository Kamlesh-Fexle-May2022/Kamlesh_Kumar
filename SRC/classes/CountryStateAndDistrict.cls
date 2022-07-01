/**
*  Description     :  Retrieve the district which is start from s and length is greater than 8
*
*  Created By      :  Kamlesh Kumar
*
*  Created Date    :  07/01/2022
*
*  Revision Logs   :    V1.0 - Created - Kamlesh Kumar
**/
public with sharing class CountryStateAndDistrict {
    /**
    *   @description    :  print country with state and district
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/01/2022 - Developer Name - Kamlesh Kumar
    **/
    public static void countryWithStateWithDistrict() {

        Map<String, Map<String, List<String>>> mapWithCountryWithStateWithDistrict = new Map<String, Map<String, List<String>>>();

        // Add district in key
        Map<String, List<String>> mapDistrictWithState = new Map<String, List<String>>{
            'Rajasthan' => new List<String>{'Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh','Rajsamand','Sikar'},

            'Uttar Pradesh' => new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'Siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'},

            'Gujarat' => new List<String>{'Ahmedabad',
			'Amreli','Anand','Aravalli','Banaskantha','Bharuch','Bhavnagar','Botad','Chhota Udepur','Dahod','Dangs (Ahwa)','Devbhoomi Dwarka','Gandhinagar','Gir Somnath','Jamnagar','Junagadh','Kachchh','Kheda (Nadiad)','Mahisagar','Mehsana','Morbi','Narmada (Rajpipla)','Navsari','Panchmahal','Patan','Porbandar','Rajkot','Sabarkantha','Surat','Surendranagar','Tapi (Vyara)','Vadodara','Valsad'}
        };

        // Add state 
        Map<String, List<String>> mapStateWithCountry = new Map<String, List<String>>{
            'India' => new List<String>{'Rajasthan', 'Uttar Pradesh', 'Gujarat'}   
        };

        // Add country, state and district on map
        for(String keyOfMap : mapStateWithCountry.keySet()) {
            if(!mapWithCountryWithStateWithDistrict.containsKey(keyOfMap)) 
                mapWithCountryWithStateWithDistrict.put(keyOfMap, new Map<String, List<String>>());

            if(mapWithCountryWithStateWithDistrict.containsKey(keyOfMap)) {
                for(String state : mapStateWithCountry.get(keyOfMap)) {
                    mapWithCountryWithStateWithDistrict.get(keyOfMap).put(state, new List<String>());

                    if(mapWithCountryWithStateWithDistrict.get(keyOfMap).containsKey(state)) {
                        mapWithCountryWithStateWithDistrict.get(keyOfMap).get(state).addAll(mapDistrictWithState.get(state));
                    }
                }
            }
        }

        //System.debug(mapWithCountryWithStateWithDistrict);
        for(String key : mapWithCountryWithStateWithDistrict.keySet()) {
            System.debug(key + mapWithCountryWithStateWithDistrict.get(key));
        }        
    }
}