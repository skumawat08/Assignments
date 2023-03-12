//Problem set 2 Trigger Scenario 2
public class CustomerProjectHandler {
    public static void AFTER_INSERT(List<Customer_Project__c> newList){
        insertCustomerProject(newList,null);
    }
    public static void AFTER_UPDATE(List<Customer_Project__c> newList,Map<Id, Customer_Project__c> oldMap){
        insertCustomerProject(newList,oldMap);
    }
    //method for insert and update customer project
    public static void insertCustomerProject(List<Customer_Project__c> cpList, Map<Id, Customer_Project__c> oldMap){
        Map<String, List<Customer_Project__c>> mapOppIdCustomerProject = new Map<String, List<Customer_Project__c>>();
         Map<String, Opportunity> oppToUpdateMap = new Map<String, Opportunity>();
        Boolean isInsert = (oldMap==Null);
        for(Customer_Project__c cp : cpList){
            if(isInsert||cp.Status__c!=oldMap.get(cp.Id)?.Status__c){
                if(!mapOppIdCustomerProject.containsKey(cp.Opportunity__c)){
                    mapOppIdCustomerProject.put(cp.Opportunity__c, new List<Customer_Project__c>());
                   // oppToUpdateMap.put(cp.Opportunity__c, new Opportunity());
                }
            }
        }
        List<Customer_Project__c> cpLists =  [SELECT Id,name,Status__c, Opportunity__r.Active_Customer_project__c 
                                       from Customer_Project__c 
                                       where Opportunity__c IN:mapOppIdCustomerProject.keySet()];
        System.debug(cpLists);
        for(Customer_Project__c cp : cpLists){
            Boolean con1 = (cp.Status__c=='Active');
            Boolean con2 = (oppToUpdateMap.containsKey(cp.Opportunity__c));
            Boolean con3 = (oppToUpdateMap.get(cp.Opportunity__c)?.Active_Customer_project__c == True);
            if(con1 && ((con2 && con3) || !con2)){
                System.debug('in if');
                oppToUpdateMap.put(cp.Opportunity__c, new Opportunity(Id=cp.Opportunity__c,Active_Customer_project__c=True));
            }
            else{
                System.debug('in else');
                 oppToUpdateMap.put(cp.Opportunity__c, new Opportunity(Id=cp.Opportunity__c,Active_Customer_project__c=False));
            }
        }
        
        if(oppToUpdateMap.size()>0){
            update oppToUpdateMap.values();
        }
    }
}