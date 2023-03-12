public class session2ApexClass {
    public static void main(){
        /* List<String> list1 = new List<String>{'Sachin','Harsh'};
Set<String> stringSet = new Set<String>();
Set<String> stringSet1 = new Set<String>{'Mayank','Mehul'};
stringSet.add('Akshay');
stringSet.add('Ankit');
stringSet.add('Arun');
System.debug(stringSet);
stringSet.addAll(list1);
System.debug(stringSet);
// stringSet = new Set<String>(stringSet1);
stringSet.addAll(stringSet1);
System.debug(stringSet);*/
        
        List<Account> accountList = new List<Account>{new Account(name='Saransh'),new Account(name='Sachin'),new Account(name='Ankit'),new Account(name='Aman')};
            Set<Account> accountSet = new Set<Account>();
        accountSet.add(new Account(name='Aman',rating='Hot'));
        accountSet.add(new Account(name='Mehul'));
        accountSet.add(new Account(name='Harsh'));
        accountSet.addAll(accountList);
        System.debug(accountSet);
        Set<Account> accountSet1 = new Set<Account>();
        accountSet = accountSet1.clone();
        System.debug(accountSet);
        // insert new List<Account>(accountSet); // type cast because set can't be insert,update and delete by DML. It is not a good way to do this 
        // its better way is Map.
        
    }
    public static void accountMap(){
        Map<Id,Account> accMap1 = new Map<Id,Account>([SELECT ID, name FROM Account WHERE name='Burlington Textiles Corp of America']);
        Map<Id,Account> accMap2 = new Map<Id,Account>([SELECT ID FROM Account WHERE name='Burlington Textiles Corp of America']);
        System.debug(accMap1);
        System.debug(accMap2);
        System.debug(accMap1.keyset()==accMap2.keySet()); //this is the right way to compare two account 
       // System.debug(accMap1.equals(accMap2)); It will return false 
       System.debug(accMap1.toString()); //it will convert the entire set into string
        
    }  
    
}