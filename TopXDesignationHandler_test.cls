@isTest
public class TopXDesignationHandler_test {
    
    
    @isTest
    public static void insertAndUpdateTest(){
        List<String> oppIdList = new List<String>();
        Opportunity opp = new Opportunity(name='testOpp', StageName='Qualification', CloseDate=System.today()+3);
        insert opp;
        oppIdList.add(opp.Id);
        Top_X_Designation__c topX1 = new Top_X_Designation__c(name='top1',Type__c = 'Construct flow down',Document_Attached__c= True, Opportunity__c=opp.Id);
        Top_X_Designation__c topX2 = new Top_X_Designation__c(name='top2',Type__c = 'Construct flow down',Document_Attached__c= True, Opportunity__c=opp.Id);
        Top_X_Designation__c topX3 = new Top_X_Designation__c(name='top2',Type__c = 'Construct flow down',Document_Attached__c= False, Opportunity__c=opp.Id);
        insert topX1;
        insert topX2;
        insert topX3;
        
        Opportunity getOpp = [SELECT Handoff_Attached__c FROM Opportunity WHERE Id IN :oppIdList];
        
        System.assertEquals('No',getOpp.Handoff_Attached__c, 'test class failed');
        
        topX1.Document_Attached__c=False;
        update topX1;
        Opportunity getOpp1 = [SELECT Handoff_Attached__c FROM Opportunity WHERE Id IN :oppIdList];
        System.assertEquals('No',getOpp1.Handoff_Attached__c, 'test class failed');
        
        //for delete
        delete topX1;
        Opportunity getOpp2 = [SELECT Handoff_Attached__c FROM Opportunity WHERE Id IN :oppIdList];
        System.assertEquals('No',getOpp2.Handoff_Attached__c, 'test class failed');
        
        //for undelete
        undelete topx1;
        Opportunity getOpp3 = [SELECT Handoff_Attached__c FROM Opportunity WHERE Id IN :oppIdList];
        System.assertEquals('No',getOpp3.Handoff_Attached__c, 'test class failed');
        
    }
}