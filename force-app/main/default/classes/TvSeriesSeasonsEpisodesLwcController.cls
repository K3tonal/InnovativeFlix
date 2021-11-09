public with sharing class TvSeriesSeasonsEpisodesLwcController {
    
    @AuraEnabled(cacheable = true)
    public static List<Season__c> getSeasonList(String seriesId){
        //Id serId = seriesId;
        List<Season__c> seasonList = [SELECT Id, Season_No__c FROM Season__c where Tv_Series__c IN ( SELECT Id FROM Tv_Series__c WHERE Id =:seriesId) ORDER BY Season_No__c];
        return seasonList;
    }

    @AuraEnabled(cacheable = true)
    public static List<Episode__c> getEpisodeList(String seasonId){
        List<Episode__c> episodeList = [SELECT Id, Episode_No__c, Title__c FROM Episode__c where Season__c IN ( SELECT Id FROM Season__c WHERE Id =:seasonId) ORDER BY Episode_No__c];
        return episodeList;
    }
}
