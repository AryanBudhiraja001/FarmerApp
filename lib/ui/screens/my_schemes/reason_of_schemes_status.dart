import 'package:flutter/material.dart';

import '../../constants/exports.dart';


class ReasonOfSchemesStatus extends GetView<ReasonOfSchemesController> {
  const ReasonOfSchemesStatus({super.key});



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<ReasonOfSchemesController>(
      init: ReasonOfSchemesController(),
      builder: (_) {
        return
          Scaffold(
              appBar: customAppBar(
                  title: controller.appBarTitle.tr),
              body:
              Column(
                children: [
                  sizedBox(height: margin_20),
                  _reasonList(),
                  controller.appBarTitle==checkReasonButtonStr?Container():
                  _reApplySchemesButton(),
                ],
              )


          );
      }
         )
    );
  }

     _reasonList(){
    return
      Expanded(
        child:
        controller.reasonList.isEmpty?noDataAvailable(title: noDataAvailStr):
        ListView.builder(
        shrinkWrap: true,
          itemCount: controller.reasonList.length,
          itemBuilder: (_,index){
        return _reasonOfRejectItem(index);
           }),
      );

  }
  _reApplySchemesButton(){
    return GetBuilder<ReasonOfSchemesController>(
       init: ReasonOfSchemesController(),
      builder: (_){
        return   Container(
          width: double.infinity,
          padding:EdgeInsets.symmetric(vertical: margin_20) ,
          decoration: BoxDecoration(
              color: white,
              border: Border(
                  top: BorderSide(color: borderColor)
              )
          ),
          child:setPadding(
              leftPadding: margin_20,
              rightPadding: margin_20,
              widget:
              ElevatedButton(onPressed: (){
                Get.delete<CompleteDetailsScreensController>();
                Get.toNamed(Routes().completeDetailsScreen,arguments: {"appliedScheme":controller.schemesStatusData,"isSchemeResubmit":SCHEMES_STATUS_RESUBMIT});

              },
                style:ElevatedButton.styleFrom(
                    backgroundColor:primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(margin_25)
                    ),
                    padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
                ),
                child: commonText(reApplyStr.tr.toUpperCase(),color:white,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
              )
          ),
        );
      },

    );

  }


  _reasonOfRejectItem(index){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  sizedBox(height: margin_10),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle
                    ),
                  ),
                ],
              ),
              sizedBox(width: margin_16),
              Expanded(child: commonText(controller.reasonList[index],fontSize: font_16,color:subtitleColor,fontWeight: FontWeight.w400,textHeight: 1.5))
            ],
          ),
        ],
      ),
    );

  }
}
