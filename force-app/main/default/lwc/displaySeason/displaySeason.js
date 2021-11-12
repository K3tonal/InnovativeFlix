import getSeasonList from '@salesforce/apex/TvSeriesSeasonsEpisodesLwcController.getSeasonList';
import { LightningElement, api, wire, track } from 'lwc';
import SAMPLEMC from "@salesforce/messageChannel/tvSeriesMessageChannel__c";
import {MessageContext, publish} from 'lightning/messageService';

const COLUMNS = [
    {label:'Season', fieldName:'Season_No__c', type:'number'}
]

export default class DisplaySeason extends LightningElement {
    @api recordId;
    records;
    error;
    seasonId;
    columns=COLUMNS;
    
    @wire (getSeasonList, {seriesId:'$recordId'})
    handleSeasons({error,data}){
        if(data){
            this.records = data;
            this.errorMsg = undefined;
        }else {
            this.errorMsg = error;
            this.records = undefined;
        }
    }

    @wire(MessageContext)
    context

    handleButtonClick(event){
        this.seasonId = event.target.value;
        let message = {
            myData:{
                value:this.seasonId
            }
        }
        publish(this.context,SAMPLEMC, message)
    }
}