@isTest
public class ContactRelationship_tgr_Test {
    @isTest
    public static void updateContactRelationshipOwner_Test(){
       Contact_Relationship__c crNew = new Contact_Relationship__c();
        crNew.Name='test cr';
        insert crNew;
       
        Contact_Relationship__c cr = [SELECT name, OwnerId FROM Contact_Relationship__c];
        cr.OwnerId= '0055i000004nBIsAAM';
        update cr;
       
        
        Contact_Relationship__c cr1 = [SELECT name, OwnerId FROM Contact_Relationship__c];
        User user = [SELECT name FROM User WHERE Id='0055i000004nBIsAAM'];
        System.assertEquals(user.Name, cr1.Name, 'test class failed');
    }

}