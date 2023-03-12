public class BatchClass implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Hi, I am start');
        return Database.getQueryLocator('SELECT Id FROM Account');
    }
    public void execute(Database.BatchableContext BC,List<Account> scope){
        System.debug('Hi, I am execute');
        //calling schedulable
       /* SchedulableClass sch = new SchedulableClass();
        String CRON_EXP = '0 * * ? * *';
        system.schedule('Every minute Schedule job', CRON_EXP, sch); */
        
        //calling queueable only one jon at a time
      /*  QueueableClass q = new QueueableClass();
        System.enqueueJob(q); 
        QueueableClass q1 = new QueueableClass();
         System.enqueueJob(q1); */
    }
    public void finish(Database.BatchableContext BC){
        System.debug('Hi, I am finish');
    }
}