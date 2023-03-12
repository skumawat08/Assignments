@isTest
public class CustomerProject_tgr_test {
	@isTest
    public static void insertCustomerProject_Test(){
        Opportunity opp = new Opportunity();
        opp.name = 'test opp';
        opp.CloseDate = System.today()+3;
        opp.StageName = 'Value Proposition';
        insert opp;
        Customer_Project__c cp = new Customer_Project__c();
        cp.name = 'cp1';
        cp.Opportunity__c= opp.Id;
        cp.Status__c = 'Active';
        insert cp;
        
        test.startTest();
        //Customer_Project__c cp1 = [SELECT Id, Status__c FROM Customer_Project__c WHERE Opportunity__c =: opp.Id];
        Opportunity opp1 = [SELECT 	Active_Customer_project__c FROM Opportunity ];
        	System.assertEquals(True,opp1.Active_Customer_project__c, 'test class Failed');
        
        cp.Status__c = 'Inactive';
        update cp;
         Opportunity opp2 = [SELECT Active_Customer_project__c FROM Opportunity ];
        	System.assertEquals(False,opp2.Active_Customer_project__c, 'test class Failed');
        test.stopTest();
    }
}