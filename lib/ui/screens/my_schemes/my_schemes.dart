import 'dart:io';

import 'package:flutter/material.dart';


import '../../constants/exports.dart';
import '../../shimmer_effect/shimmerWidget.dart';

class MySchemes extends GetView<MySchemesController> {
   MySchemes({super.key});

   @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar(
          title: mySchemesStr.tr,
          ),

      body:WillPopScope(
        onWillPop: ()async{
            Get.delete<MySchemesController>();
        return true;
        },
        child:  GetBuilder<MySchemesController>(
          init:MySchemesController(),
          builder: (_){
            return _schemesStatusView();
          },
        ) ,
      )


    ));
  }



       _schemesStatusView(){
         return FutureBuilder(
             future:controller.futureSchemesStatus,
             builder: (_,data){
                if(data.connectionState==ConnectionState.done){
                 if(data.hasData){
                   return controller.schemesDataList!.isEmpty?noDataAvailable(title:noSchemesAppliedStr.tr):_schemesStatusList();
                 }
                 if(data.hasError){
                   return noDataAvailable(title:noDataAvailStr);
                 }
               }
                if(data.connectionState==ConnectionState.waiting){
                  return _shimmerView();
                }

                return noDataAvailable(title:noDataAvailStr);


         });
       }


     _schemesStatusList(){
       return ListView.builder(
           itemCount:controller.schemesDataList!.length ,
           shrinkWrap: true,
           itemBuilder: (_,index){
         return _schemesItem(index);
       });

     }

     _schemesItem(index){
       return setPaddingAll(
         margin: margin_20,
         widget: Column(
           children: [
             _dateContainer(index),
             sizedBox(height: margin_16),
             _schemesContainer(index),
           ],
         ),
       );
     }
     
     _dateContainer(index){
    return Row(
      children: [
         Expanded(child: Container(
             height: 1,
             decoration: BoxDecoration(
                 color: borderColor
             )
         ),),
        sizedBox(width: margin_8),
        commonText(controller.appliedSchemesData[index],color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400),
        sizedBox(width: margin_8),
        Expanded(child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: borderColor
            )
        ),),
      ],
    );
    
     }

  _schemesContainer(index){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_20),
          border: Border.all(color: borderColor)
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: margin_20,horizontal: margin_20),
                  decoration: BoxDecoration(
                      color: subsidyBgColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius_20),
                          topRight: Radius.circular(radius_20)
                      )
                  ),
                  child: commonText(controller.schemesDataList![index].schemeName,fontSize: font_18,color: white),
                ),
              ),
            ],
          ),
          sizedBox(height: margin_20),
         setPadding(
           leftPadding: margin_16,
           rightPadding: margin_16,
           widget: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   commonText(applicationNoStr.tr,fontSize: font_12,color: subtitleColor,fontWeight: FontWeight.w400),
                   commonText(controller.schemesDataList![index].applicationNumber!.toUpperCase(),fontSize: font_12,color: subtitleColor,fontWeight: FontWeight.w400),

                 ],
               ),
               sizedBox(height: margin_20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       const  Icon(Icons.trending_up,size: 24,color: paragraphColor,),
                       sizedBox(width: margin_8),
                       commonText(statusOfSchemesStr.tr,fontSize: font_12,color: subtitleColor,fontWeight: FontWeight.w400),

                     ],
                   ),
                   commonText(controller.applicationsStatus[index],fontSize: font_14,color: paragraphColor),
                 ],
               ),
               sizedBox(height: margin_8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       const  Icon(Icons.location_on_outlined,size: 24,color: paragraphColor,),
                       sizedBox(width: margin_8),
                       commonText(stageStr.tr,fontSize: font_12,color: subtitleColor,fontWeight: FontWeight.w400),

                     ],
                   ),
                   commonText(controller.schemesDataList![index].stage,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w700),
                 ],
               ),
               sizedBox(height: margin_24),
              _knowMoreButton(index),
               sizedBox(height: margin_16),
             ],
           ),
         ),

        ],
      ),
    );
  }


  _knowMoreButton(index){
    return getInkWell(
      ontap: () {
        Get.toNamed(Routes().schemesTrackingScreen,
            arguments: controller.schemesDataList![index]);
      },

      widget: Container(
        padding: EdgeInsets.symmetric(vertical: margin_10,horizontal: margin_20),
        decoration: BoxDecoration(
            border: Border.all(color:knowMoreBorderColor),
            borderRadius: BorderRadius.circular(radius_24)

        ),
        child:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonText(knowMoreStr.tr,fontSize: font_12,color:knowMoreBorderColor),
            sizedBox(width: width_15),
            Icon(Icons.arrow_forward,color: knowMoreBorderColor,)
          ],
        ) ,
      ),
    );


  }

  _shimmerView(){

  return  ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (_,index){
    return   setPaddingAll(
      margin: margin_20,
      widget: Container(
        height: 240,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_20),
            border: Border.all(color: borderColor)
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: margin_20,horizontal: margin_20),
                      decoration: BoxDecoration(
                          color: subsidyBgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius_20),
                              topRight: Radius.circular(radius_20)
                          )
                      ),
                      child: ShimmerWidget.rectangular(height: 20.0,width: 100,)
                  ),
                ),
              ],
            ),
            sizedBox(height: margin_20),
            setPadding(
              leftPadding: margin_16,
              rightPadding: margin_16,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerWidget.rectangular(height: 10.0,width: 40,),
                      ShimmerWidget.rectangular(height: 10.0,width: 40,),
                    ],
                  ),
                  sizedBox(height: margin_20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ShimmerWidget.rectangular(height: 10.0,width: 20,),
                          sizedBox(width: margin_8),
                          ShimmerWidget.rectangular(height: 10.0,width: 40,),


                        ],
                      ),
                      ShimmerWidget.rectangular(height: 10.0,width: 40,),                ],
                  ),
                  sizedBox(height: margin_8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ShimmerWidget.rectangular(height: 10.0,width: 20,),
                          sizedBox(width: margin_8),
                          ShimmerWidget.rectangular(height: 10.0,width: 40,),

                        ],
                      ),
                      ShimmerWidget.rectangular(height: 10.0,width: 40,),
                    ],
                  ),
                  sizedBox(height: margin_24),
                  ShimmerWidget.rectangular(height: 50.0,width: 160,),
                  sizedBox(height: margin_16),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  });

  ;


  }

}
