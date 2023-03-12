public class CustomProductClass implements Database.Batchable<sObject> {
 public Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator([SELECT Id,Expiry_Date_Custom__c,Prod_Customer_Quantity__c,Product_Code__c 
                                         FROM Custom_Product__c 
                                         WHERE Expiry_Date_Custom__c < Today]);
    }
    public void execute(Database.BatchableContext BC,List<Custom_Product__c> scope){
        Map<String, Product2> stProdCodeMap  = new Map<String, Product2>();
        List<Product2> stProdToUpdateList = new List<Product2>();
        for(Product2 stProd : [SELECT Id, ProductCode,Prod_Standard_Quantity__c FROM Product2]){
            stProdCodeMap.put(stProd.ProductCode,stProd);
        }
        Map<String, Custom_Product__c> custProdCodeMap  = new Map<String, Custom_Product__c>();
        for(Custom_Product__c cp:scope){
            custProdCodeMap.put(cp.Product_Code__c, cp);
        }
        for(String custProdCode: custProdCodeMap.keySet()){
            System.debug(custProdCode);
            stProdCodeMap.get(custProdCode).Prod_Standard_Quantity__c += custProdCodeMap.get(custProdCode).Prod_Customer_Quantity__c;
            stProdToUpdateList.add(stProdCodeMap.get(custProdCode));
        }
        update stProdToUpdateList;
        delete scope;
    }
    public void finish(Database.BatchableContext BC){
       
    }
}