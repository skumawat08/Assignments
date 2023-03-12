public class CustomerHandler {
    public static void AFTER_INSERT(List<Customer__c> custList){
        insertCustomer(custList);
    }
    //problem set 2 trigger scenario 8
    public static void insertCustomer(List<Customer__c> custList){
        Map<Id, List<Customer__c>> accIdCustomerMap = new Map<Id, List<Customer__c>>();
        List<AccountTeamMember> atmListToInsert = new List<AccountTeamMember>();
        Set<Id> accIdSet = new Set<Id>();
        for(Customer__c cust: custList){
            accIdSet.add(cust.Account__c);
            accIdCustomerMap.put(cust.Account__c, new List<Customer__c>());
        }
        for(Customer__c cust: [SELECT Id,Account_Manager__c, Account__c FROM Customer__c WHERE 	Account__c IN : accIdSet]){
            
            accIdCustomerMap.get(cust.Account__c).add(cust); 
        }
        for(Id accId : accIdCustomerMap.keySet()){
           // atmListToUpdate.add(new AccountTeamMember(AccountId=accId));
            for(Customer__c cust : accIdCustomerMap.get(accId)){
                atmListToInsert.add(new AccountTeamMember(AccountId=accId, UserId=cust.Account_Manager__c));
            }
        }
        insert atmListToInsert;
    }
}