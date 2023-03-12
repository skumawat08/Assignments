public class propertyClass {
   /* public static void methodOne(){
        //List<RealEstate__c> rStateList = [SELECT name FROM RealEstate__c];
        //System.debug(rStateList);
        //List<sCar__c> sCarList = [SELECT name FROM sCar__c];
        // System.debug(sCarList);
        // 
        // 
        List<Contact> conList = New List<Contact>();
        conList = [SELECT Id, Name, (SELECT Id,name FROM RealEstates__r) FROM Contact];
        System.debug(conList);
        //List<RealEstate__c> rEstateList = [SELECT Id, name FROM RealEstate__c WHERE Contact__c!=null];
        /*for(RealEstate__c c : rEstateList){
            
            System.debug(c);
        
        
    }*/
}