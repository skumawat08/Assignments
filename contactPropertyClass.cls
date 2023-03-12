@TestVisible
public class contactPropertyClass {
   // @TestVisible
    public class propWrapper{
       // @TestVisible
        List<sCar__c> sCarList;
       // @TestVisible
        List<realEstate__c> realEstateList;
        
        public propWrapper(){
            sCarList= new List<sCar__c>();
            realEstateList = new List<realEstate__c>();
        }
    }
    
    public static Map<String,propWrapper> listToMap(){
        Map<String, propWrapper> propMap = new Map<String,propWrapper>();
        for(Contact con:[SELECT Id, Name, (SELECT Name FROM sCars__r), (SELECT Name FROM realEstates__r) FROM Contact]){
            propWrapper pw = new propWrapper();
            for(sCar__c sc : con.sCars__r){
                pw.sCarList.add(sc);
            }
            for(realEstate__c re : con.realEstates__r){
                pw.realEstateList.add(re);
            }


            propMap.put(con.Id, pw);
        }
      
        //Integer result = propMap.size();
        return propMap; 
    }
    
}