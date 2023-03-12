public class propertyClass1 {
    public propertyClass1(){
	List<sCar__c> sCarList = [SELECT name FROM sCar__c];
    List<RealEstate__c> realEstateList = [SELECT name FROM RealEstate__c];
    }
    public static void mapMethod(){
        List<Contact> conList = [SELECT name, (SELECT name FROM sCars__r), (SELECT name FROM RealEstates__r) FROM Contact];
        Map<String,propertyClass1> propMap = new Map<String,propertyClass1>();
        
        for(Contact con: conList){
            if(!propMap.containsKey(con.name)){
                propMap.put(con.name, new propertyClass1());
            }
           // propMap.get(con.name).add();
        }
        System.debug(propMap);
    }

}