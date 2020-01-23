import { LightningElement, api } from 'lwc';
import create from '@salesforce/apex/QuickCreateController.create';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Quickcreate extends LightningElement {
    opp;
    error;

    constructor(){
        super();
        this.opp = {
            'sobjectType' : 'Opportunity',
            'StageName': 'Prospecting'
        };
    }

    handleFieldChange(event){
        let field = event.target.name;
        if(field === 'CloseDate'){
            this.opp[field] = new Date(event.target.value);
        }else{
            this.opp[field] = event.target.value;
        }
    }

    saveRecord(event) {
        //let's pretend an attacker set a javascript breakpoint here, and then tried to inject a custom field our controller didn't expect
        this.opp.Manager_Approved__c = true;
        //end injection attack
        create({opp: this.opp})
            .then(result => {
                this.opp = result;
                let evt = new ShowToastEvent({
                    title: 'Saved',
                    message: 'Data saved successfully',
                    variant: {label: 'success', value: 'success'},
                });
                this.dispatchEvent(evt);
                event.target.disabled = true;
            })
            .catch(error => {
                this.error = error;
                let evt = new ShowToastEvent({
                    title: 'Error Saving Data',
                    message: this.error.body.message,
                    variant: {label: 'error', value: 'error'},
                });
                this.dispatchEvent(evt);
            });
    }

}