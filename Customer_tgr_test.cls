@isTest
public class Customer_tgr_test {
    @isTest
    public static void insertCustomer_test(){
        Account acc = new Account();
        acc.name ='Test acc';
        insert acc;
        Account acc2 = new Account();
        acc2.name ='Test acc2';
        insert acc2;
        Customer__c cust = new Customer__c();
        cust.Name= 'cust1';
        cust.Account__c = acc.Id;
        cust.Account_Manager__c = '0055i000004nBIsAAM';
        insert cust;
      /*  Customer__c cust2 = new Customer__c();
        cust2.Name= 'cust2';
        cust2.Account__c = acc2.Id;
        //cust.Account_Manager__c = '0055i000004nBIsAAM';
        insert cust2; */
        test.startTest();
        Customer__c cust1 = [SELECT Id,Account_Manager__c FROM Customer__c WHERE Account__c =: acc.Id];
        AccountTeamMember atm = [SELECT Id, UserId FROM AccountTeamMember WHERE AccountId =:acc.Id];
        System.assertEquals(cust1.Account_Manager__c,atm.UserId ,'test class failed');
        
        //UserId field  cannot be null on AccountTeamMember object because this field is required 
       /* Customer__c cust3 = [SELECT Id,Account_Manager__c FROM Customer__c WHERE Account__c =: acc2.Id];
        AccountTeamMember atm2 = [SELECT Id, UserId FROM AccountTeamMember WHERE AccountId =:acc2.Id];
		System.assertEquals(Null,atm2.UserId , 'test class fail');        */
        test.stopTest();
    }
}