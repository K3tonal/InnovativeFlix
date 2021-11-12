/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Queueable class for report creation
* *  @Task: POX-1 
* */
public with sharing class CreateRaportQue implements Queueable {
    
    Integer interval;
    Date startDate;

    public CreateRaportQue(){
        this.interval = 1;
        this.startDate = Date.today().addDays(-interval);
    }

    /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * *  @description Execute method of Queueable prepare data and send email
     * *  @Task: POX-1 
     * *  @param context QueueableContext
     * */
    public void execute(QueueableContext context){
        
        List<Episode__c> episodeList = [SELECT Title__c FROM Episode__c WHERE CreatedDate >= :startDate];
        
        Integer episodeCount = episodeList.size();
        List<String> episodesTitle = new List<String>();
        for(Episode__c episode: episodeList){
            
            if(episode.Title__c != null){
                episodesTitle.add(episode.Title__c);
            }                        
        }

        List<Tv_Series__c> tvSeriesList = [SELECT Title__c FROM Tv_Series__c WHERE CreatedDate >= :startDate];
        Integer tvSeriesCount = tvSeriesList.size();
        List<String> tvSeriesTitle = new List<String>();
        for(Tv_Series__c serie : tvSeriesList){
            tvSeriesTitle.add(serie.Title__c);
        }
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {'vojepa8969@datakop.com'}; 
        message.subject = System.label.RAPORT_FOR_LAST +' ' +interval + ' ' + System.label.DAYS;
        message.plainTextBody = System.label.NUMBER_OF_TV_SERIES_ADDED_DURING_LAST +' ' +interval + ' '+ System.label.DAYS +': ' + tvSeriesCount
                                + '\n'+ System.label.LIST_OF_NEW_SERIES + ': ' + tvSeriesTitle
                                + '\n'+ System.label.NUMBER_OF_EPISODE_ADDED_DURING_LAST + ' '  + interval + ' '+ System.label.DAYS + ' ' + episodeCount
                                +'\n' + System.label.LIST_OF_EPISODES + ': '+ episodesTitle;

        
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};        

        try{
            Messaging.sendEmail(messages);
    
        } catch (EmailException ex){
            System.debug('System.label.ENCOUNTERED_AN_ERROR' + ex);
        } 

    }

}