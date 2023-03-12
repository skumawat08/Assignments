public class getAllCustomSObjects {
    /* @AuraEnabled
public static List<String> AllCustomSObjects(){
List<String> sObjectList = new List<String>();
for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
{
Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();

if(describeSObjectResultObj.isCustom())
{
System.debug(describeSObjectResultObj.isCustom());
String name = objTyp.getDescribe().getName();
// Exclude all the unwanted Sobjects e.g. History, Share etc.

SobjectList.add(name);

}
}
system.debug('SObjectList****' + SObjectList);
return sObjectList;
} */
    @AuraEnabled(cacheable=true)
    public static List<SelectOptionWrapper> getAllObjects(){
        List<Schema.SObjectType> objList = Schema.getGlobalDescribe().Values();
        System.debug(Schema.getGlobalDescribe().Values());
        List<SelectOptionWrapper> objNames = new List<SelectOptionWrapper>();
        objNames.add((new SelectOptionWrapper('','-- Select --')));
        for (Schema.SObjectType obj : objList) {
            if(obj.getDescribe().isAccessible() &&
               obj.getDescribe().isCreateable() &&
               obj.getDescribe().isCustom()&&
               !obj.getDescribe().isDeprecatedAndHidden())
                objNames.add(new SelectOptionWrapper(obj.getDescribe().getName(),obj.getDescribe().getLabel()));
        }
        System.debug(objNames);
        return objNames;
    }
    @AuraEnabled(cacheable = true)
    public static List<String> getFields(String objApiName) {
        if(objApiName != NULL && objApiName != '' && objApiName != ' ') {
            List<Schema.SObjectField> sObjectFields = Schema.describeSObjects(new List<String>{objApiName})[0].fields.getMap().values();
            List<String> objFields = new List<String>();
            for ( Schema.SObjectField field:sObjectFields ) {
                objFields.add(field.getDescribe().getName());
            }
            return objFields;
        }
        return new List<String>();
    }
    @AuraEnabled(cacheable = true)
    public static List<sObject> getObjRecords(String objApiName){
       String query= 'Select Id,Name FROM ' +objApiName;
        System.debug(Database.query(query));
       return Database.query(query);
    } 
    @AuraEnabled
    public static void deleteSelectedRows(String objApiName , List<String> selectedRecords){
        String query= 'Select Id,Name FROM ' +objApiName+ ' where Id IN: selectedRecords';
        //List<sObject> l= Database.query(query);
        delete Database.query(query);
    }
    class SelectOptionWrapper {
        @AuraEnabled
        public String value;
        @AuraEnabled
        public String label;
        @AuraEnabled
        public Boolean disabled;
        public SelectOptionWrapper (String value, String label) {
            this.value = value;
            this.label = label;
            this.disabled = false;
        }
        public SelectOptionWrapper (String value, String label, Boolean disabled ) {
            this.value = value;
            this.label = label;
            this.disabled = disabled;
        }
    }
}