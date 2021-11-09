/*   @author name <wojciech.krasowski@accenture.com> * @date 08/11/2021 * 
* *  @description 
* *  @Task: POX-1 
* */
public with sharing class CreateRaport {
    
    /*   @author name <wojciech.krasowski@accenture.com> * @date 08/11/2021 * 
    * *  @description Method to expose CreateRaportQue to flow builder
    * *  @Task: POX-1 
    * */
    @InvocableMethod(label='Create_Raport')
    public static void invokeCreateRaportQue() {
        CreateRaportQue createRaportQue = new CreateRaportQue();
        System.enqueueJob(createRaportQue);
    }
}
