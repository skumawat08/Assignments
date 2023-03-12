public class QueueableClass implements Queueable {
    public void execute(QueueableContext context) {
       System.debug('Hi, I am queueable');       
    }

}