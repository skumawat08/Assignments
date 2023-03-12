public class pushTopicLwc {
    @AuraEnabled
    public static void  insertPushTopic(String objName){
       // String name= '/topic/_'+ptName;
        List<PushTopic> isExistPT = [SELECT Id FROM PushTopic WHERE Name=:objName];
        if(isExistPT.size()==0){
        PushTopic pushTopic = new PushTopic();
        pushTopic.Name = objName;
        pushTopic.Query = 'SELECT Id, Name FROM '+objName;
        pushTopic.ApiVersion = 55.0;
        pushTopic.NotifyForOperationCreate = true;
        pushTopic.NotifyForOperationUpdate = true;
        pushTopic.NotifyForOperationUndelete = true;
        pushTopic.NotifyForOperationDelete = true;
        pushTopic.NotifyForFields = 'Referenced';
        insert pushTopic;
        }
    }
}