@isTest
public class AssFutureCallout_Test {
    @isTest
    private static void testCallSomething(){
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        test.startTest();
        FutureCallOut.future();
        test.stopTest();
    }
    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            Map<String,String> map1 = new Map<String,String>{
                'text'=> 'jai bham bhole',
                    'author'=> 'Akshat sharma'
                    };
                        res.setBody(JSON.serialize(new List<Map<String,String>>{map1}));
            return res;
        }
    }
}