public class AccountHelper {
 @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsList(){
        try {
            return [SELECT Id, Name, Industry FROM Account];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}