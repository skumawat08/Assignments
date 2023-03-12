@isTest
public class UndeleteContactClass_test {
	@isTest
    public static void undeleteDeletedContactsSingleTest(){
        Account acc = new Account(name='TestAcc');
        insert acc;
        contact con1 = new Contact(LastName='testCon1', AccountId=acc.Id);
        insert con1;
         contact con2 = new Contact(LastName='testCon2', AccountId=acc.Id);
        insert con2;
        
        delete con1;
        delete con2;
        update acc;
       
       test.startTest();
        UndeleteContactClass.undeleteDeletedContactsSingle(acc.Id);
        test.stopTest();
        Account acc2 = [SELECT deletedContacts__c FROM Account];
        System.assertEquals(Null, acc.deletedContacts__c, 'Test class failed acc1');
        
       
    }
    @isTest
    public static void undeleteDeletedContactsBulkTest(){
        Account acc2 = new Account(name='testAcc2');
        insert acc2;
        Account acc3 = new Account(name='testAcc3');
        insert acc3;
        List<Id> accIdList = new List<Id>();
        accIdList.add(acc2.id);
        accIdList.add(acc3.id);
         contact con1 = new Contact(LastName='testCon1', AccountId=acc2.Id);
        insert con1;
         contact con2 = new Contact(LastName='testCon2', AccountId=acc2.Id);
        insert con2;
         contact con3 = new Contact(LastName='testCon1', AccountId=acc3.Id);
        insert con3;
         contact con4 = new Contact(LastName='testCon2', AccountId=acc3.Id);
        insert con4;
        //delete the con1 of account 2
        delete con1;
        delete con2;
        //update acc2;
        
        test.startTest();
        UndeleteContactClass.undeleteDeletedContactsBulk(accIdList);
        test.stopTest();
        Account acc2Field1 = [SELECT deletedContacts__c FROM Account WHERE Id=:acc2.Id];
        System.assertEquals(Null,acc2Field1.deletedContacts__c,'test class failed acc2Field');
     
        
    }
}