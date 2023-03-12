@isTest
public class accountNameSuffix_tgr_test {
    //  @testSetup
    /* private static void setupData(){
Account acc = new Account(name='TestAcc', Industry='Media');
insert acc;

} */
    
    @isTest
    public static void accountNameSuffixTest(){
        test.startTest();
        Account acc = new Account(name='TestAcc', Industry='Media', Number_of_Locations__c=4);
        insert acc;
       
        
        
        //insert acc with industry is media
        Account acc1 = [SELECT name, Number_of_Locations__c FROM Account];
        /*  if(acc1.Industry==Null){
System.assertEquals('TestAcc', acc1.Name, 'test class failed acc1');
} */
        
        
        
        List<Contact> conList1 = [SELECT name FROM Contact WHERE AccountId =: acc1.Id];
        System.assertEquals('TestAcc_new', acc1.Name, 'test class failed acc1');
        System.assertEquals(4, conList1.size(),'test class failed acc1' );
        
        //update acc industry media to Insurance
        // Account accUpdate = [SELECT name FROM Account WHERE Industry='Media'];
        acc1.Industry= 'Insurance';
        update acc1;
        Account acc2 = [SELECT name,Number_of_Locations__c FROM Account];
        List<Contact> conList2 = [SELECT name FROM Contact WHERE AccountId =: acc2.Id];
        System.assertEquals('TestAcc', acc2.Name, 'test class failed acc update2');
        System.assertEquals(4, conList2.size(),'test class failed acc2' );
        
        //update amount field  and acc name is TestAcc
        acc2.Amount_Account__c= 10000;
        update acc2;
        Account acc3 = [SELECT name,Number_of_Locations__c FROM Account];
        List<Contact> conList3 = [SELECT name FROM Contact WHERE AccountId =: acc3.Id];
        System.assertEquals('TestAcc', acc3.Name, 'test class failed acc update3');
        System.assertEquals(4, conList3.size(),'test class failed acc3' );
        
        //again update acc industry insurance to media
        acc3.Industry= 'Media';
        update acc3;
        Account acc4 = [SELECT name,Number_of_Locations__c FROM Account];
        List<Contact> conList4 = [SELECT name FROM Contact WHERE AccountId =: acc4.Id];
        System.assertEquals('TestAcc_new', acc4.Name, 'test class failed acc4');
        System.assertEquals(4, conList4.size(),'test class failed acc4' );
        
        //update other any field acc name is already TestAcc_new
        acc4.AnnualRevenue= 400000;
        update acc4;
        Account acc5 = [SELECT name,Number_of_Locations__c FROM Account];
        List<Contact> conList5 = [SELECT name FROM Contact WHERE AccountId =: acc5.Id];
        System.assertEquals('TestAcc_new', acc4.Name, 'test class failed acc5');
        System.assertEquals(4, conList5.size(),'test class failed acc5' );
        test.stopTest();
        
        //updating owner of account 
        User user = [SELECT Id,name FROM User WHERE Id = '0055i000004nBIsAAM'];
        acc5.OwnerId= user.Id;
        update acc5;
        
        Account acc6 = [SELECT name,Sales_Repr__c,Number_of_Locations__c FROM Account]; 
        System.assertEquals(user.Name, acc6.Sales_Repr__c, 'test class failed');
    }
    
    
    
    
    
    /* @isTest
public static void test_accountNameSuffix_tgr(){
Account acct = new Account(name='TestAcc', Industry='Media');
insert acct;
Account accName = [SELECT name FROM Account WHERE Industry='Media'];

test.startTest();
System.assertEquals('TestAcc_new',accName.Name , 'Test class Failed');
test.stopTest();
}*/
}