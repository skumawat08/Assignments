public class ContactRelationShipHandler {
	 public static void BEFORE_UPDATE(List<Contact_Relationship__c> newCrList, Map<Id, Contact_Relationship__c> oldMap){
        updateContactRelationshipOwner(newCrList,oldMap);
    }
    //problem set 2 Trigger Scenario 4
    public static void updateContactRelationshipOwner(List<Contact_Relationship__c> newCrList, Map<Id, Contact_Relationship__c> oldMap){
        Set<Id> userIdset = new Set<Id>();
        List<Contact_Relationship__c> crListToUpdate = new List<Contact_Relationship__c>();
        for(Contact_Relationship__c cr: newCrList){
            userIdset.add(cr.OwnerId);
        }
        Map<Id,User> userMap =new Map<Id,User>([SELECT name FROM User WHERE Id IN:userIdset]);
        for(Contact_Relationship__c cr:newCrList ){
            if(cr.OwnerId!=oldMap.get(cr.Id)?.OwnerId){
                cr.Name= userMap.get(cr.OwnerId)?.name;
                crListToUpdate.add(cr);
            }
        }
        
        
    }
}