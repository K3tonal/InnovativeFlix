import SAMPLEMC from "@salesforce/messageChannel/tvSeriesMessageChannel__c";
import { subscribe, MessageContext, RECORD_SCOPE } from 'lightning/messageService';
import getEpisodeList from "@salesforce/apex/TvSeriesSeasonsEpisodesLwcController.getEpisodeList";
import { LightningElement, wire, api } from 'lwc';

const COLUMNS = [
    {label:'Episode Number', fieldName:'Episode_No__c'},
    {label:'Title', fieldName:'Title__c'}
]

export default class DisplayEpisodes extends LightningElement {
    receivedMessage
    @wire(MessageContext)
    context
    @api seasonId
    errorMsg
    columns = COLUMNS;
    


    connectedCallback(){
        this.subscribeMessage();
    }

    subscribeMessage(){
        subscribe(this.context, SAMPLEMC, (message) => this.handleMessage(message), {scope:RECORD_SCOPE});
    }

    handleMessage(message){
        console.log(message.myData.value);
        this.receivedMessage = message.myData.value;
        console.log(this.receivedMessage);
        this.seasonId = this.receivedMessage;
    }

    @wire(getEpisodeList, {seasonId:'$seasonId'})
    handleEpisodes({data,error}){
        if(data){
            this.records = data;
            this.errorMsg = undefined;
        }if(error){
            this.errorMsg = error;
            this.records = undefined;
        }
    }
}