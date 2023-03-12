public class accountNameSuffixHandler {
    public static void BEFORE_INSERT(List<Account> newList){
        insertAccount(newList);
    }
    
    public static void BEFORE_UPDATE(List<Account> newList, Map<Id, Account> oldMap){
        updateAccount(newList,  oldMap );
    }
    
    public static void AFTER_INSERT(List<Account> newList){
        createContacts(newList);
    }
    //Problem set 1 assignment 1
    //create contact on account equal to number of locations field value on account
    public static void createContacts(List<Account> newList){
        List<Contact> conList = new List<Contact>();
        for(Account acc: newList){
            
            for(Integer i=1;i<=acc.Number_of_Locations__c;i++){
                Contact con = new Contact();
                con.LastName = acc.name+' con'+i;
                con.AccountId= acc.Id;
                conList.add(con); 
                // conList.add(new Contact(LastName=acc.Name+' con'+i,AccountId= acc.Id));
            }
            
        }
        insert conList;
    }
    
    public static void insertAccount(List<Account> accList){
        Set<Id> userId = new Set<Id>();
        for(Account acc : accList){
            if(acc.Industry=='Media'){
                acc.Name= acc.Name+'_new';
            } 
            userId.add(acc.OwnerId);
        }
        //problem set 1 assignment 2
        //When we create the Account record, the Account Owner will be automatically added to the Sales Rep field.
        Map<Id, User> userMap = new Map<Id,User>([SELECT Id,name FROM User  WHERE Id IN:userId]);
        for(Account acc: accList){
            acc.Sales_Repr__c = userMap?.get(acc.OwnerId).name;
        }
    }
    
    public static void updateAccount(List<Account> accList, Map<Id, Account> accOldMap ){
        // List<Account> accList1 = [SELECT Id, name, Industry, Owner.name FROM Account WHERE Id IN : trigger.new];
        Set<Id> userId = new Set<Id>();
        for(Account acc: accList){
            userId.add(acc.OwnerId);
            if(acc.Industry=='Media' && acc.Industry!=accOldMap.get(acc.Id).Industry){
                acc.Name= acc.Name+'_new';
            }
            if(acc.Industry!='Media' && acc.Industry!=accOldMap.get(acc.Id).Industry){
                acc.Name= acc.Name.split('_')[0];
            }   
        }
        //problem set 1 assignment 2
        //When we update the Account owner of the record, then also the Sales Rep will be automatically updated.

        Map<Id, User> userMap = new Map<Id,User>([SELECT Id,name FROM User  WHERE Id IN:userId]);
        for(Account acc:accList){
            if(acc.OwnerId!=accOldMap.get(acc.Id).OwnerId){
                acc.Sales_Repr__c = userMap?.get(acc.OwnerId).name;
            }
        }
    }
}