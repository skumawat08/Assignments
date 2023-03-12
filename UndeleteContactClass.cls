public class UndeleteContactClass {
    public static void undeleteDeletedContactsSingle(Id accId){
        Account accountRecords = [SELECT  deletedContacts__c FROM Account WHERE Id=:accId];
        List<String> deletedContactIdList = accountRecords.deletedContacts__c.split(',');
        // System.debug(deletedContactIdList);
        List<Contact> contactsForUndeleteList;
        contactsForUndeleteList = new List<Contact>([SELECT Id, name FROM Contact WHERE Id=:deletedContactIdList All Rows]);
      //  System.debug(contactsForUndeleteList);
        Undelete  contactsForUndeleteList;
        accountRecords.deletedContacts__c = Null;
       // System.debug(accountRecords);
        /* Update accountRecords.deletedContacts__c; 
* can't do this  because DML requires SObject or SObject List type and here I use "accountRecords.deletedContacts__c" that is string value field
*/
        Update accountRecords;
    }
    
    
    
    public static void undeleteDeletedContactsBulk(List<Id> accIdList){
         List<Account> accountRecordsList = [SELECT  deletedContacts__c FROM Account WHERE Id IN:accIdList];
        List<String> deletedContactIdList=new List<String>();
        for(Account a : accountRecordsList){
            if(a.deletedContacts__c?.split(',').size()>0){
                deletedContactIdList.addAll(a.deletedContacts__c?.split(','));
            }
        }
       // System.debug(deletedContactIdList);
        List<Contact> contactForUndelete = [SELECT Id,name FROM Contact WHERE AccountId IN:accIdList AND Id IN:deletedContactIdList All Rows];
        //System.debug(contactForUndelete);
        Undelete contactForUndelete;
        
        for(Account a:accountRecordsList ){
			a.deletedContacts__c = Null;
          
        }
        Update accountRecordsList;
    }
    
}