import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import LOGO_FIELD from '@salesforce/schema/Tv_series__c.Poster_URL__c';
import TITLE_FIELD from '@salesforce/schema/Tv_series__c.Title__c';

export default class DisplayLogo extends LightningElement {
    @api recordId
    @track record
    errorMsg

    @wire(getRecord, {recordId:'$recordId', fields:[LOGO_FIELD,TITLE_FIELD]})
    handleRecord({error, data}){
        if(data){
            this.record = data
        }if(error){
            this.errorMsg = undefined;
        }
    }
}