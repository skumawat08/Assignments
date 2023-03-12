public class TopXDesignationHandler {
    public static void AFTER_INSERT(List<Top_X_Designation__c> newList){
        // updateOpportunity(newList,null);
        updateOpporunities(newList, null);       
    }
    public static void AFTER_UPDATE(List<Top_X_Designation__c> newList, Map<Id, Top_X_Designation__c> oldMap){
        // updateOpportunity(newList, oldMap);
        updateOpporunities(newList, oldMap);
    }
    public static void AFTER_UNDELETE(List<Top_X_Designation__c> newList){
        // updateOpportunity(newList,null);
        updateOpporunities(newList, null);       
    }
    public static void AFTER_DELETE(Map<Id, Top_X_Designation__c> oldMap){
        deleteTopx(true,oldMap);
    }
    
    public static void updateOpporunities(List<Top_X_Designation__c> newList, Map<Id,Top_X_Designation__c> oldMap){
        Map<String, List<Top_X_Designation__c>> mapOppIdTopXDesignations  = new  Map<String, List<Top_X_Designation__c>>();
        List<Opportunity> listOpportunityToUpdate = new List<Opportunity>();
        Boolean isInsert = (oldMap==NUll);
        Boolean isUndelete= (oldMap==Null);
        for(Top_X_Designation__c topX : newList){
            if(isInsert || ((topX.Type__c != oldMap.get(topX.Id)?.Type__c) || (topX.Document_Attached__c != oldMap.get(topX.Id)?.Document_Attached__c) )){
                if(!mapOppIdTopXDesignations.containskey(topX.Opportunity__c)){
                    mapOppIdTopXDesignations.put(topX.Opportunity__c, new List<Top_X_Designation__c>());
                }
                // mapOppIdTopXDesignations.get(topX.Opportunity__c).add(topX);    
            }
        }
        for(Top_X_Designation__c topX :  [SELECT Id,Type__c, Document_Attached__c, Opportunity__r.Handoff_Attached__c 
                                          from Top_X_Designation__c 
                                          where Opportunity__c IN:mapOppIdTopXDesignations.keySet()])
        {
            mapOppIdTopXDesignations.get(topX.Opportunity__c).add(topX);    
        }
        for(String oppId : mapOppIdTopXDesignations.keySet()){
            String handOffUpdate = 'Yes';
            for(Top_X_Designation__c topX : mapOppIdTopXDesignations.get(oppId)){
                if(isInsert || ((topX.Type__c != oldMap.get(topX.Id)?.Type__c) || (topX.Document_Attached__c != oldMap.get(topX.Id)?.Document_Attached__c) )){
                    Boolean con1 = (topX.Type__c == 'Construct flow down');
                    Boolean con2 = topX.Document_Attached__c;
                    if(!con1||!con2){
                        handOffUpdate='No';
                    }
                } 
            }
            listOpportunityToUpdate.add(new Opportunity(Id = oppId, handoff_attached__c = handOffUpdate));
        }
        update listOpportunityToUpdate;
    }
    
    public static void deleteTopx(Boolean isDelete,Map<Id,Top_X_Designation__c> oldMap){
        Map<String, List<Top_X_Designation__c>> mapOppIdTopXDesignations  = new  Map<String, List<Top_X_Designation__c>>();
        List<Opportunity> listOpportunityToUpdate = new List<Opportunity>();
        Set<String> oppIdSet = new Set<String>();
        Boolean topxState = true;
        for(String topXId: oldMap.keySet()){
            Top_X_Designation__c topX  = oldMap.get(topXId);
            oppIdSet.add(topX.Opportunity__c);
            if(!(topX.Type__c == 'Construct flow down')||!(topX.Document_Attached__c)){
                topxState = false;
            }
        }
        if(topxState==False){
            for(Top_X_Designation__c topX1 :  [SELECT Id,Type__c, Document_Attached__c, Opportunity__r.Handoff_Attached__c from Top_X_Designation__c 
                                               where Opportunity__c IN:oppIdSet])
            {
                mapOppIdTopXDesignations.put(topX1.Opportunity__c, new List<Top_X_Designation__c>{topX1} );  
            }
        }
        for(String oppId : mapOppIdTopXDesignations.keySet()){
            String handOffUpdate = 'Yes';
            for(Top_X_Designation__c topX : mapOppIdTopXDesignations.get(oppId)){
                if(isDelete){
                    Boolean con1 = (topX.Type__c == 'Construct flow down');
                    Boolean con2 = topX.Document_Attached__c;
                    if(!con1||!con2){
                     
                        handOffUpdate='No';
                    }
                } 
            }
            listOpportunityToUpdate.add(new Opportunity(Id = oppId, handoff_attached__c = handOffUpdate));
        }
        update  listOpportunityToUpdate;
        
    }
}
    
  /*  public static void updateOpportunity(List<Top_X_Designation__c> newList, Map<Id,Top_X_Designation__c> oldMap){
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        
        Boolean isInsert = oldMap ==  null;
        for(Top_X_Designation__c topX : newList){
            
            if(isInsert || ((topX.Type__c != oldMap.get(topX.Id)?.Type__c) || (topX.Document_Attached__c != oldMap.get(topX.Id)?.Document_Attached__c) )){
                Boolean con1 = (topX.Type__c == 'Construct flow down');
                Boolean con2 = topX.Document_Attached__c;
                
                Boolean con3 = oppMap.containsKey(topX.Opportunity__c);
                Boolean con4 = (oppMap.get(topX.Opportunity__c)?.handoff_attached__c == 'Yes');
                if(con1 && con2 && ((con3 && con4) || !con3)){
                    oppMap.put(topX.Opportunity__c,new Opportunity(id=topX.Opportunity__c,handoff_attached__c='Yes'));
                }else{
                    oppMap.put(topX.Opportunity__c,new Opportunity(id=topX.Opportunity__c,handoff_attached__c='No'));
                }
            }
        }
        
		List<Top_X_Designation__c> topXList = [SELECT Id,Type__c, Document_Attached__c, 
                                               Opportunity__r.Handoff_Attached__c from Top_X_Designation__c 
                                               where Opportunity__c IN:oppMap.keySet() ];
        System.debug(topXList);
        for(Top_X_Designation__c topX : topXList){
            if(oppMap.get(topX.Opportunity__c).handoff_attached__c=='Yes'){
				if(isInsert || ((topX.Type__c != oldMap.get(topX.Id)?.Type__c) || (topX.Document_Attached__c != oldMap.get(topX.Id)?.Document_Attached__c) )){
                Boolean con1 = (topX.Type__c == 'Construct flow down');
                Boolean con2 = topX.Document_Attached__c;
                Boolean con3 = oppMap.containsKey(topX.Opportunity__c);
                Boolean con4 = (oppMap.get(topX.Opportunity__c)?.handoff_attached__c == 'Yes');
                if(con1 && con2 && ((con3 && con4) || !con3)){
                    oppMap.put(topX.Opportunity__c,new Opportunity(id=topX.Opportunity__c,handoff_attached__c='Yes'));
                }else{
                    oppMap.put(topX.Opportunity__c,new Opportunity(id=topX.Opportunity__c,handoff_attached__c='No'));
                }
            }
            }
        }
        if(oppMap.size()>0){
            update oppMap.values();
        } 
        
        
        
    }  */