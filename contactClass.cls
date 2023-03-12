public class contactClass {
    public static void contactList(){
        List<Contact> conList = new List<Contact>([SELECT ID, name FROM Contact Where Contact.Email=null]);
        System.debug(conList);
        delete conList;
    }

}