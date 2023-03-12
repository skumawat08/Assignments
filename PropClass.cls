public class PropClass {
     class PropWrapper{
        List<sCar__c> sCarList;// =  [SELECT name FROM sCar__c];
        List<RealEstate__c> realEstateList; //=[SELECT name FROM RealEstate__c];
       public PropWrapper(){
          sCarList=new List<sCar__c>();
           realEstateList= new List<RealEstate__c>();
        }
        
       
        
    }

     public static void mapMethod(){
        // System.debug(sCarList);
        Map<String, PropWrapper> propMap = new Map<String, PropWrapper>();
       // List<Contact> conList = [SELECT Id, name, (SELECT name FROM sCars__r), (SELECT name FROM RealEstates__r) FROM Contact];
       		
         	
           for(Contact con :[SELECT Id, name, (SELECT name FROM sCars__r), (SELECT name FROM RealEstates__r) FROM Contact]){
              
               PropWrapper pw = new PropWrapper();
               for(RealEstate__c re:con.RealEstates__r){
                   pw.realEstateList.add(re);
               }
               for(sCar__c sc:con.sCars__r){
                   pw.sCarList.add(sc);
               }
             
           
            propMap.put(con.Id, pw);
            System.debug(con.Id+'_________'+pw);
            
        }
         
        // System.debug(propMap);
         
         for(Id n:propMap.keySet()){
             System.debug(n+'__________'+propMap.get(n));
             
        
        
    }
    }  
}