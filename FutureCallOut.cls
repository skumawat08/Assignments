public class FutureCallOut {
    @future (callout=true)
    public static void future(){
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('http://api.timezonedb.com/v2.1/get-time-zone?key=HAZ3CPARR05I&format=xml&by=position&lat=40.689247&lng=-74.044502');  /*https://type.fit/api/quotes*/
        httpRequest.setMethod('GET');
        HttpResponse response = http.send(httpRequest);
        System.debug(response);
        if(response.getStatusCode() == 200){
            // Object results = (Object) JSON.deserializeUntyped(response.getBody());
            //System.debug(results);
            //system.debug('Body ---->'+response1.getbody());  
            DOM.Document doc = response.getBodyDocument();
            //DOM.XmlNode rootNode = doc.getRootElement();
            //parseXML(rootNode);
            list<string> urls=new list<string>();
            
            for (Dom.XmlNode node : doc.getRootElement().getChildElements()) {
                String url = node.getAttributeValue('url', '');
                //Integer score = Integer.valueOf(node.getAttributeValue('_CreditScore', ''));
                urls.add(url);
            }
            
            for(String url:urls){
                System.debug(url);
            }
            system.debug('urls.size--->'+urls.size());
            
            
        }
        else{
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
            System.debug(response.getBody());
        }
    }
    
}