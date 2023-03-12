public class session1Calculator {
   
    public  Integer a=10, b=20;
    public Integer add(Integer l, Integer b){
        Integer c = a+b;
        a= 100;
        System.debug('>>'+this.a+'  '+this.b);
        System.debug('>>'+l+'  '+b);
       // sub(4,5);
        return c;
    }
    public static Integer sub(session1Calculator instance2){
        System.debug('static method');
       // session1Calculator n = new session1Calculator();
        instance2.add(7,3);
        Integer c;
        return c;
    }
    public static Integer mul(Integer a, Integer b){
        System.debug(b*(new session1Calculator()).a);
        Integer c;
        return c;
    }
    public static Integer div(Integer a, Integer b){
        Integer c;
        return c;
    }

}