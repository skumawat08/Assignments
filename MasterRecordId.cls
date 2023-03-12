public class MasterRecordId {
    public static void mrId(){
        List<Account> mrId =[SELECT MasterRecordId FROM Account WHERE MasterRecordId != null ALL ROWS];
        System.debug(mrId);
    }
}