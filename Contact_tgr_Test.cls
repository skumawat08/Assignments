@isTest
public class Contact_tgr_Test {
    @testSetup
    public static void dataSetup(){
        Account acc = new Account();
        acc.name = 'testAcc';
        util.insertSingleAccount(acc);
        
        contact con = new Contact();
        con.LastName= 'testCon';
        con.Contact_Relationship__c = True;
        Util.insertSingleContact(con);
        
        contact con1 = new Contact();
        con1.LastName= 'testCon1';
        con1.AccountId = acc.Id;
        Util.insertSingleContact(con1);
        
        contact con2 = new Contact();
        con2.LastName= 'testCon2';
        con2.AccountId = acc.Id;
        Util.insertSingleContact(con2);
    }
	@isTest
    public static void insertContact_Test(){
        Contact con = [SELECT Id, LastName FROM Contact WHERE Contact_Relationship__c = True];
        test.startTest();
      Contact_Relationship__c cr = [SELECT Id, name FROM Contact_Relationship__c WHERE Contact__c =: con.Id];
        System.assertEquals('testCon cr', cr.Name, 'Test class failed');
       
       
        //for number of total contacts on account
        Account acc = [SELECT Id FROM Account];
         List<Contact> conList = [SELECT Id, LastName FROM Contact WHERE AccountId =:acc.Id];
        System.assertEquals(2, conList.size(), 'Test class failed');
        //for number of contacts when we delete contact for that account
        Util.deleteContact(conList[1]);
        List<Contact> conList1 = [SELECT Id, LastName FROM Contact WHERE AccountId =:acc.Id];
        System.assertEquals(1, conList1.size(), 'Test class failed');
         test.stopTest();
    }
    @isTest
    public static void deleteCrWithContact_Test(){
        Contact con = [SELECT Id, LastName FROM Contact WHERE Contact_Relationship__c = True];
        Util.deleteContact(con);
    }
    @isTest
    public static void undeleteCrWithContact_Test(){
         Contact con = [SELECT Id, LastName FROM Contact WHERE Contact_Relationship__c = True];
         Util.deleteContact(con);
        Contact deletedCon = [SELECT Id, LastName FROM Contact WHERE Contact_Relationship__c = True AND isDeleted=True All Rows];
         Util.undeleteContact(deletedCon);
    }
   
}