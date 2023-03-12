public class Util {
   // public static boolean checkRecursion = True;
   public static boolean runOnce =  true;
    public static boolean checkRecursion(){
        if(runOnce){
            runOnce = false;
            return true;
        }
        else return false;
    }
    public static void insertSingleAccount(Account acc){
        insert acc;
    }
    public static void insertSingleContact(Contact con){
        insert con;
    }
    public static void insertListOfContact(List<Contact> conList){
        insert conList;
    }
    public static void deleteContact(Contact con){
        delete con;
    }
     public static void deleteListOfContact(List<Contact> conList){
        delete conList;
    }
     public static void undeleteContact(Contact con){
        undelete con;
    }
    public static void insertSingleOpp(Opportunity opp){
        insert opp;
    }
    
    public static void insertListOfOpp(List<Opportunity> oppList){
        insert oppList;
    }
    public static void updateListOfOpp(List<Opportunity> oppList){
        update oppList;
    }
    public static void insertCustomerProject(Customer_Project__c cp){
        insert cp;
    }
    public static void insertListOfCustomerProject(List<Customer_Project__c> cpList){
        insert cpList;
    }
    public static void insertContactRelationship(Contact_Relationship__c cr){
        insert cr;
    }
    public static void insertContactRelationshipList(List<Contact_Relationship__c> crList){
        insert crList;
    }
    public static void updateContactRelationshipList(List<Contact_Relationship__c> crList){
        update crList;
    }
    public static void deleteContactRelationship(Contact_Relationship__c cr){
        delete cr;
    }
    public static void undeleteContactRelationshipList(List<Contact_Relationship__c> crList){
        undelete crList;
    }
}