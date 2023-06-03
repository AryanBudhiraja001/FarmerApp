import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class CompleteDetailsScreen extends GetView<CompleteDetailsScreensController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<CompleteDetailsScreensController>(
      init:CompleteDetailsScreensController(),
      builder: (controller){
        return Scaffold(
          appBar: customAppBar(
            title: completeDetailsStr.tr,
          ),
           body:WillPopScope(
             onWillPop: (){
              return  Get.delete<CompleteDetailsScreensController>();

             },
             child: FutureBuilder(
               future: Future.delayed(const Duration(milliseconds: 500)),
               builder: (_,data){
                 if(data.connectionState==ConnectionState.done){
                   return    Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(child:
                       setPaddingAll(
                           margin: margin_20,
                           widget:Column(children: [
                             sizedBox(height: margin_20),
                             _heading(),
                             controller.enableApplySchemesButton.value?Container(): sizedBox(height: margin_30),
                             _itemList(),
                           ],)
                       ),
                       ),

                       _applySchemesButton(),
                     ],);
                 }
                 return circularIndicator();


               },
             ),
           )




        );
      }

      )

    );
  }




  _heading(){

  return controller.enableApplySchemesButton.value?Container(): Column(
    children: [
      Row(
          children: [
            const Icon(Icons.warning,color: warningIconColor,size: 24,),
            sizedBox(width: margin_10),
            commonText(incompleteDetailsStr.tr,color: headingColor,fontSize: font_20),
          ],
        ),
      sizedBox(height: margin_16),
      subHeadingDetails(),
    ],
  );
 }

 subHeadingDetails(){
  return commonText(subDetailsStr.tr,color: subtitleColor,fontSize: font_14,maxLines: 3,textHeight: 1.4);
  }

     _itemList(){
      return ListView.builder(
          itemCount:controller.items.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return  _item(index);
      });

     }
     _item(index){
      return
        getInkWell(
          ontap: (){
            if(index==0){
              Get.toNamed(Routes().bankDetailsScreen)!.then((value){
                controller.fetchBankDetails();
                controller.refreshScreen();
                // Get.delete<CompleteDetailsScreensController>();
                // controller.bankDetailsFilled.value=value;
              //  controller.getDocumentFilledDetails();
              //  controller.enableButton();
              //  controller.refreshScreen();
              }

              );
            }
            else{
              Get.toNamed(Routes().landDetailsScreen)!.then((value) {
                  controller.fetchLandDetails();
                  controller.refreshScreen();
                // Get.delete<CompleteDetailsScreensController>();
                // controller.landDetailsFilled.value=value;
             //   controller.getDocumentFilledDetails();
            //    controller.enableButton();
             //   controller.refreshScreen();
              });
            }
            },
          widget: Container(
          margin: EdgeInsets.only(bottom: margin_16),
          padding: EdgeInsets.symmetric(vertical: margin_20,horizontal: margin_10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_4),
            border: Border.all(color: borderColor),
          ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                index==0?
                controller.bankDetailsFilled.value?const Icon(Icons.check_circle,color: primaryColor,size: 24,):const Icon(Icons.warning,color: warningIconColor,size: 24,):
                controller.landDetailsFilled.value?const Icon(Icons.check_circle,color: primaryColor,size: 24,):const Icon(Icons.warning,color: warningIconColor,size: 24,),
                sizedBox(width: margin_10),
                commonText(controller.items[index],color: subtitleColor,fontSize: font_16),
              ],
            ),
            const Icon(Icons.arrow_forward_ios,color: videoTitleColor,size: 16,),
          ],
      ),
      ),
        );}


  _applySchemesButton(){
      return Container(
        width: double.infinity,
        padding:EdgeInsets.symmetric(vertical: margin_20) ,
        decoration: BoxDecoration(
          color: white,
            border: const Border(
            top: BorderSide(color: borderColor)
          )
        ),
            child:setPadding(
        leftPadding: margin_20,
              rightPadding: margin_20,
        widget:
            ElevatedButton(onPressed: (){
             if(controller.enableApplySchemesButton.value){
               Get.delete<UploadDocumentController>();
               Get.toNamed(Routes().uploadDocumentScreen,arguments:{"scheme":controller.scheme,"isSchemeReApplied":controller.schemesResubmit,"appliedScheme":controller.schemesStatusData} );
             }
             else{
               toast(completeDocStr.tr);
             }
              },
              style:ElevatedButton.styleFrom(
                  backgroundColor: controller.enableApplySchemesButton.value?primaryColor:disableButtonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(margin_25)
                  ),
                  padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
              ),

            child: commonText(proceedstr.tr.toUpperCase(),color: controller.enableApplySchemesButton.value?white:disableButtonTextColor,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
            )
            ),
      );

  }

 }
