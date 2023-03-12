public class TimeZoneCallout {
 // Pass in the URL for the request
    // For the purposes of this sample,assume that the URL
    // returns the XML shown above in the response body
    public static 
        void parseResponseDom(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        // url that returns the XML in the response body
        req.setEndpoint('http://api.timezonedb.com/v2.1/get-time-zone?key=HAZ3CPARR05I&format=xml&by=position&lat=40.689247&lng=-74.044502');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        Dom.Document doc = res.getBodyDocument();
        
        //Retrieve the root element for this document.
        Dom.XMLNode address = doc.getRootElement();
        
        String countryName = address.getChildElement('countryName', null).getText();
        String regionName = address.getChildElement('regionName', null).getText();
        // print out specific elements
        System.debug('countryName: ' + countryName);
        System.debug('regionName: ' + regionName);
        
        // Alternatively, loop through the child elements.
        // This prints out all the elements of the address
        for(Dom.XMLNode child : address.getChildElements()) {
           System.debug(child.getText());
        }
    }}