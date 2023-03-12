public class ContactHandler {
    public static void AFTER_INSERT(List<Contact> conList){
        insertContact(conList);
        //contactsOnAccount(conList);
    }
    public static void AFTER_UNDELETE(Map<Id,Contact> conMap){
        undeleteCrWithContact(conMap);
        
    }
    /* public static void AFTER_UPDATE(List<Contact> conList, Map<Id,Contact> oldMap){
updateContactOwner(conList, oldMap);
} */
    public static void BEFORE_DELETE(Map<Id,Contact> oldMap){
        deleteCrWithContact(oldMap);
    }
    public static void AFTER_DELETE(Map<Id,Contact> oldMap){
        deleteContact(oldMap);
    }
    //problem set 2  Trigger Scenario 3, 7
    //for insert and undelete child records also
    public static void insertContact(List<Contact> conList){
        List<Id> conIdList1 = new List<Id>();
        List<Contact_Relationship__c> crList = new List<Contact_Relationship__c>();
        Map<Id, List<Contact>> accIdContactMap = new Map<Id, List<Contact>>();
        List<Account> accListToUpdate = new List<Account>();
        //problem set 2 Trigger Scenario 3
        for(Contact con :conList){
            conIdList1.add(con.Id);
            if(con.AccountId!=Null){
                accIdContactMap.put(con.AccountId, new List<Contact>());
            }
            if(con.Contact_Relationship__c==true){
                Contact_Relationship__c cr = new Contact_Relationship__c();
                cr.Name = con.LastName+' cr';
                cr.Contact__c= con.Id;
                crList.add(cr);
            }
            
        }
         Util.insertContactRelationshipList(crList);
       
       
        //problem set 2 Trigger Scenario 7 (for undelete or insert)
        for(Contact con: [SELECT Id, name, AccountId  FROM Contact WHERE AccountId IN : accIdContactMap.keySet()]){
            accIdContactMap.get(con.AccountId).add(con);
        }
        for(Id accId : accIdContactMap.keySet()){
            accListToUpdate.add(new Account(Id = accId, Count_of_Contacts__c=accIdContactMap.get(accId).size()));
        }
        update accListToUpdate;
    }
    
    //problem set 2 Trigger Scenario  7
    public static void deleteContact(Map<Id,Contact> oldMap){
        Map<Id, List<Contact>> accIdContactMap = new Map<Id, List<Contact>>();
        Set<Id> accIdSet = new Set<Id>();
        List<Account> accListToUpdate = new List<Account>();
        
        for(Id conId : oldMap.keySet()){
            Contact con = oldMap.get(conId);
            if(con.AccountId!=Null){
                accIdSet.add(con.AccountId);
                accIdContactMap.put(con.AccountId, new List<Contact>());
            }
        }
        
       
        for(Contact con: [SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN:accIdSet]){
            accIdContactMap.get(con.AccountId).add(con);
        }
        for(Id accId : accIdContactMap.keySet()){
            accListToUpdate.add(new Account(Id = accId, Count_of_Contacts__c=accIdContactMap.get(accId).size()));
        }
        if(accListToUpdate.size()>0){
            update accListToUpdate;
        }
    }
    //problem set 2 Trigger Scenario 5
    public static void deleteCrWithContact(Map<Id, Contact> conOldMap){
        Set<Id> conIdSet = new Set<Id>(); 
        for(Id conId : conOldMap.keySet()){
            if(conOldMap.get(conId).Contact_Relationship__c){
                conIdSet.add(conId);
            }
        }
        List<Contact_Relationship__c> noOfCrOnDeletedCon = [SELECT Id, name FROM Contact_Relationship__c WHERE Contact__c IN: conIdSet];
        Integer noOfCr = noOfCrOnDeletedCon.size();
        System.debug(conIdSet);
        if(conOldMap.values().Contact_Relationship__c!=False &&(noOfCr>0)){
             Contact_Relationship__c crListToDelete = [SELECT Id, name FROM Contact_Relationship__c WHERE Contact__c IN: conIdSet];
        System.debug(crListToDelete);
        delete crListToDelete;
        }
       
    } 
    //problem set 2 trigger scenario 6
    public static void undeleteCrWithContact(Map<Id,Contact> conMap){
       List<Contact_Relationship__c> crToUndeleteList = [SELECT Id, Contact__c FROM Contact_Relationship__c WHERE isDeleted=True AND Contact__c IN:conMap.keySet() All Rows];
      	undelete crToUndeleteList;
    }
}