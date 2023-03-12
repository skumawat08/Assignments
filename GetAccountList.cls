public class GetAccountList {
@AuraEnabled
public static List<Account> GetAccount()
{
List<Account> lstAccount=[Select Id,Name,Phone FROM Account];
return lstAccount;
} 
}