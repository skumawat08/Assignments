@isTest
private class contactPropertyClass_test {
    
    @TestSetup
    private static void setupData(){
        Contact con = new Contact();
        con.LastName = 'testCon';
        insert con;
        sCar__c car = new sCar__c(name='innova', Contact__c=con.Id);
        insert car;
        RealEstate__c re = new RealEstate__c(name='shopping mall', Contact__c=con.Id);
        insert re;
    }
    
    @isTest
    
    
    public static void listToMap_test(){
        test.startTest();
        Map<String,contactPropertyClass.propWrapper> returnedMap = contactPropertyClass.listToMap();
        test.stopTest();
        System.assertEquals(1, returnedMap.size(),'test class failed');
    	
    }
   /* @isTest
    private static void listToMap_test(){
        Contact con = [SELECT Id FROM Contact LIMIT 1];
        sCar__c car = new sCar__c();
        car.Contact__c = con.Id;
        car.Name = 'Innova';
        insert car;
        
        RealEstate__c re = new RealEstate__c();
        re.Contact__c = con.Id;
        re.Name = 'shopping mall';
        insert re;
        
        System.assertEquals(1, contactPropertyClass.listToMap(),'Test Class failed');
    } */
}