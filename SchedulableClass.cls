global class SchedulableClass implements Schedulable {
   global void execute(SchedulableContext sc) {
        System.debug('Hi, i am schedulable');
        //calling batch class
       /* BatchClass b = new BatchClass();
        Database.executeBatch(b); */
        //calling future 
       /* FutureClass.myFutureMethod();
        FutureClass.myFutureMethod();*/
       //calling schedulable
       SchedulableClass2 sch2 = new SchedulableClass2();
        String CRON_EXP = '0 0 0 ? * * *';
        system.schedule('Every minute Schedule job', CRON_EXP, sch2);
        
    }
}