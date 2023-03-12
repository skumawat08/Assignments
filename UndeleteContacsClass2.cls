public class UndeleteContacsClass2 {
    public static void undeleteContact(Id accId){
        List<Contact> deletedConIdList = [SELECT Id,AccountId FROM Contact WHERE AccountId=:accId AND isDeleted=True All Rows];
        System.debug(deletedConIdList);
        Account detetedContactField  = [SELECT deletedContacts__c FROM Account WHERE Id=:accId];
        System.debug(detetedContactField);
        Undelete deletedConIdList;
        detetedContactField.deletedContacts__c= Null;
        Update detetedContactField;
    }

}