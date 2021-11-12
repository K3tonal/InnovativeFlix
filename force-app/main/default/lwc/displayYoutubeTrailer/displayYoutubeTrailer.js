import { LightningElement,api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import TRAILER_FIELD from '@salesforce/schema/Tv_series__c.Trailer_URL__c';
                           
export default class DisplayYoutubeTrailer extends LightningElement {

    @api recordId
    @track record
    errorMsg

    @wire(getRecord, {recordId:'$recordId', fields:[TRAILER_FIELD]})
    handleRecord({error, data}){
        if(data){
            this.record = data
        }if(error){
            this.errorMsg = undefined;
        }
    }

    
}