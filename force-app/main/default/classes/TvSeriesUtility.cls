/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description TvSeries Utility Class
* *  @Task: POX-1 
* */
public with sharing class TvSeriesUtility {

    /* * @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
     * *  @description Method from Trigger to delet Cases before TvSeries remvoal
     * *  @Task: POX-1 
     * */
    public void clearViolationCases(List<Tv_Series__c> tvSeriesFromTrigger ){
        List<Case> caseList = [SELECT id FROM Case WHERE Tv_Series__r.Id IN :tvSeriesFromTrigger];     
        delete caseList;    
        
    }
}
