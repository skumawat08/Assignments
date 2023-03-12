public class GetContactList {
    @AuraEnabled
    public static List<Contact> GetContact()
    {
        List<Contact> lstContact=[SELECT Id,Name,Phone FROM Contact];
        return lstContact;
    } 
}