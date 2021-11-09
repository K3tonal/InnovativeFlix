/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Test class fro EpisodeUtility
* *  @Task: POX-1 
* */
@isTest
public with sharing class EpisodeTest {
    
    /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * *  @description Test method for data preparation
     * *  @Task: POX-1 
     * */
    @TestSetup
    static void setup(){
     
        Tv_Series__c newTvSerie = new Tv_Series__c(Title__c='Test title', Storyline__c='Description', Genre__c='Action');
        insert newTvSerie;
       
        Season__c season = new Season__c(Tv_Series__c = newTvSerie.Id);
        insert season;

        List<Episode__c> episodeList = new List<Episode__c>();
        for(Integer i = 0 ; i <= 5; i++){
            episodeList.add(new Episode__c(Title__c='Test Episode',Season__c =season.Id));
        }
        insert episodeList;
    }

        /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
        * *  @description Testing episode numeration
        * *  @Task: POX-1 
        * */
        @isTest()
        static void testEpisodeNumeration(){
            Episode__c lastEpisode = [SELECT Id, Episode_No__c FROM Episode__c ORDER BY Episode_No__c DESC LIMIT 1];
            System.assertEquals(6, lastEpisode.Episode_No__c, 'Episode Number Match');
        }
}

