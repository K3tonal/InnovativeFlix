/*   @author name <wojciech.krasowski@accenture.com> * @date 11/08/2021 * 
* *  @description Trigger class for Tv_Series__c
* *  @Task: POX-1 
* */
trigger TvSerieTrigger on Tv_Series__c (before delete) {
    
    TvSeriesUtility TvSeriesUtility = new TvSeriesUtility();
    
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            TvSeriesUtility.clearViolationCases(Trigger.old);
        }
    } 
}