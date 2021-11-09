/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Trigger class for Episode__c
* *  @Task: POX-1 
* */
trigger EpisodeTrigger on Episode__c (before insert) {

    EpisodeUtility episodeUtil = new EpisodeUtility();

    if(trigger.isBefore){
        if(trigger.isInsert){
            episodeUtil.calculateEpisodeNumber(Trigger.new);
        }
    }
}