/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Episode Utility class
* *  @Task: POX-1 
* */
public with sharing class EpisodeUtility {
    
    /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * * @description Method calculate new Episode Number
     * * @Task: POX-1 
     * * @para episodesFromTrigger Episode List from trigger
     * */
    public void calculateEpisodeNumber(List<Episode__c> episodesFromTrigger){   
    
        Set<Id> seasonIdSet = getSeasonIdFromEpisodeList(episodesFromTrigger);
        
        List<Season__c> seasonList = [SELECT (SELECT Id, Episode_No__c FROM Episodes__r) FROM Season__c where Id IN :seasonIdSet];
           
        for(Season__c season : seasonList){
            Integer numberOfEpisodes = season.Episodes__r.size();
            for(Episode__c episode : episodesFromTrigger){
                if(episode.Season__c == season.Id){}               
                episode.Episode_No__c = numberOfEpisodes + 1;
                numberOfEpisodes ++;
            }
        }
    }
    /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * * @description Method calculate new Episode Number
     * * @Task: POX-1 
     * * @para episodeList 
     * * @return  Set of episodeId
     * */
    public Set<Id> getSeasonIdFromEpisodeList(List<Episode__c> episodeList){
        Set<Id> seasonIdSet = new Set<Id>();
        
        for(Episode__c episode : episodeList){
            seasonIdSet.add(episode.Season__c);
        }
       
        return seasonIdSet;
    }

}
