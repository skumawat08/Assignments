public class session4ApexClass {
    public static void conBirth(){
        List<Contact> conList = new List<Contact>([SELECT Id, Name, BirthDate FROM Contact ]);
        System.debug(conList);
        Map<Date, List<Contact>> dobToConListMap = new Map<Date, List<Contact>>();
        for(Contact con : conList){
            if(!dobToConListMap.containsKey(con.BirthDate)){
                dobToConListMap.put(con.BirthDate, new List<Contact>());
            }
            dobToConListMap.get(con.Birthdate).add(con);
        }
        System.debug(dobToConListMap);
        for(Date d :dobToConListMap.keySet()){
            System.debug(d+'_________'+dobToConListMap.get(d));
        }
    }

}