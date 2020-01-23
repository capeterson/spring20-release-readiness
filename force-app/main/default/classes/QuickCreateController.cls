/**
 * Copyright (c) 2019 Salesforce
 * @author chris.peterson@salesforce.com
 */

public with sharing class QuickCreateController {

    @AuraEnabled
    public static List<Opportunity> fetchOpportunities(){
        //note: despite the standard user not having access to Manager_Approved__c this query will run
        //WITH SECURITY_ENFORCED only appllies to the selected fields/objects, not the WHERE or ORDER BY clauses
        try{
            return [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Manager_Approved__c = true WITH SECURITY_ENFORCED];
        }catch(System.QueryException e){
            //surface the QueryException from WITH SECURITY_ENFORCED as handleable client side
            throw new AuraHandledException(e.getMessage()); 
        }

    }

    @AuraEnabled
    public static Opportunity create(Opportunity opp){
        System.debug(opp);
        if(!SObjectType.Opportunity.createable
            || !SObjectType.Opportunity.fields.Name.isCreateable()
            || !SObjectType.Opportunity.fields.Amount.isCreateable()
            || !SObjectType.Opportunity.fields.CloseDate.isCreateable()){
            throw new AuraHandledException('Error: insufficient access to create opportunity record');
        }
        SObjectAccessDecision result = Security.stripInaccessible(AccessType.CREATABLE, new List<Opportunity>{opp});
        //we want all-or-none logic, so we detect if anything was stripped and throw an exception
        if(!result.getModifiedIndexes().isEmpty()){
            throw new AuraHandledException('Stopped field injection attempt with stripInaccessible');
        }
        insert opp;
        return opp;
    }
}