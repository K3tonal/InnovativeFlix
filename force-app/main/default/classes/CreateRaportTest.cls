/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Test class fro CreateReportQue
* *  @Task: POX-1 
* */
@isTest
public with sharing class CreateRaportTest {
    
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
     * *  @description Testing job enqueue
     * *  @Task: POX-1 
     * */
    @isTest
    public static void testEmailRaport(){
        CreateRaportQue createRaportQue = new CreateRaportQue();
        Id jobId = System.enqueueJob(createRaportQue);
        System.debug('queuableTestWithoutStartStop [jobId]: ' + jobId);
        System.assertNotEquals('Completed' , [SELECT Id , Status FROM AsyncApexJob WHERE Id=:jobId][0].Status);
    }
}