/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Test class fro TvSeries
* *  @Task: POX-1 
* */
@isTest
public with sharing class TvSeriesTest {
    
     /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * *  @description Method test case deletion after TvSeries removal
     * *  @Task: POX-1 
     * */
    @isTest
    public static void testViolationCaseDelete() {

        Tv_Series__c newTvSerie = new Tv_Series__c(Title__c='Test title', Storyline__c='Description', Genre__c='Action');
        insert newTvSerie;

        List<Case> violationCase = new List<Case>();
        for(Integer i = 0; i < 10; i++){
            violationCase.add(new Case(Origin='web', Type='Other', Tv_Series_Reason__c='Harmful or hateful content',Tv_Series__C=newTvSerie.Id));
        }
        insert violationCase;

        test.startTest();
        System.assertEquals(10, [SELECT COUNT() from Case where Tv_Series__c =:newTvSerie.Id]);
        delete newTvSerie;
        System.assertEquals(0, [SELECT COUNT() from Case where Tv_Series__c =:newTvSerie.Id]);
        test.stopTest();
    }
}