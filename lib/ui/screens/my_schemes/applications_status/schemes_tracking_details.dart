
import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

import 'package:url_launcher/url_launcher.dart';

class SchemesTrackingScreen extends GetView<SchemeSTrackingController> {
  const SchemesTrackingScreen({super.key});


  @override
  Widget build(BuildContext context){
    return SafeArea(
        child:Scaffold(
        appBar: customAppBar(
          title: applicationStatusStr.tr,
        ),
          body: GetBuilder<SchemeSTrackingController>(
            init: SchemeSTrackingController(),
        builder: (_){
    return

    SingleChildScrollView(
    child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    setPaddingAll(
    margin: margin_30,
    widget:Column(children: [
    sizedBox(height: margin_10),
    _applicationStatus(),
    ],)
    ) ,
    sizedBox(height: margin_10),
    divider(height: 8.0,color: disableButtonColor),
    sizedBox(height: margin_10),
    _applicationInformationsContainer(),
    divider(height: 8.0,color: disableButtonColor),
    sizedBox(height: margin_20),
    _currentlyReviewedBy(),
    ],
    )
    );
    }

    )
        )
    );
  }
  _applicationStatus(){
    return

      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(applicationStatusStr.tr,color: headingColor,fontSize: font_18),
        sizedBox(height: margin_20),
          _statusItem(status: controller.tehsilStatus.value==SCHMES_STATUS_AUTO_APPROVED||controller.tehsilStatus.value==SCHMES_STATUS_APPROVED||controller.tehsilStatus.value==SCHEMES_STATUS_PROGRESS||controller.tehsilStatus.value==SCHEMES_STATUS_REJECTED,statusDes:controller.tehsilStatus.value,title: controller.departmentList[0],date: controller.tehsilStatusDate.value,officerStatus: controller.tehsilStatus.value),
          controller.tehsilStatus.value==SCHEMES_STATUS_REJECTED?_checkReasonButton():
          controller.tehsilStatus.value==SCHEMES_STATUS_RESUBMIT?_reSubmitView():



          _statusItem(status: controller.districtStatus.value==SCHMES_STATUS_AUTO_APPROVED||controller.districtStatus.value==SCHMES_STATUS_APPROVED||controller.districtStatus.value==SCHEMES_STATUS_PROGRESS||controller.districtStatus.value==SCHEMES_STATUS_REJECTED,statusDes:controller.districtStatus.value,
              title: controller.departmentList[1],
              date: controller.districtStatusDate.value,
              officerStatus:controller.districtStatus.value,
            visibleline:controller.stage==STATE_STAGE?true:false
          ),

          controller.tehsilStatus.value==SCHEMES_STATUS_REJECTED|| controller.tehsilStatus.value==SCHEMES_STATUS_RESUBMIT?Container():
          controller.districtStatus.value==SCHEMES_STATUS_REJECTED?_checkReasonButton():
              controller.districtStatus.value==SCHEMES_STATUS_RESUBMIT?_reSubmitView():
       controller.stage==STATE_STAGE?
        _statusItem(status: false,statusDes:controller.stateStatus.value,title: controller.departmentList[2],date: controller.approvedStatusDate.value,visibleline: false,officerStatus: controller.districtStatus.value,size: 24.0):Container(),
      ],
    );
  }

  _statusItem({status,statusDes,title,date,visibleline,officerStatus,size}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            officerStatus==SCHEMES_STATUS_REJECTED?_closeIconView():
            officerStatus==SCHEMES_STATUS_PROGRESS?Icon(Icons.circle,color:primaryColor,size: 16,):
            officerStatus==SCHEMES_STATUS_RESUBMIT?_recheckIconView():
            officerStatus==SCHMES_STATUS_AUTO_APPROVED||officerStatus==SCHMES_STATUS_APPROVED?
              Icon(Icons.check_circle,color: primaryColor,size: size??20,)
                :Icon(Icons.circle_outlined,color:primaryColor,size: 14,)
            ,
            visibleline??

                officerStatus==SCHMES_STATUS_AUTO_APPROVED||officerStatus==SCHMES_STATUS_APPROVED||officerStatus==SCHEMES_STATUS_PROGRESS||officerStatus==""?Container(
              width: 2.0,
              height: 50,
              color:  status==true?primaryColor:verticalDividerColor,
            ):Container()
          ],
        ),
        sizedBox(width: margin_16),
        Expanded(
          child: Column(
            // mainAxisAlignment: ,
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           commonText(title,fontSize: font_16,color: paragraphColor) ,
              sizedBox(height: margin_10),
              status==true?
              Row(
                 children: [
                   commonText(applicationsStr.tr,fontSize: font_13,color: subtitleColor,maxLines: 2,textHeight: 1.4,fontWeight: FontWeight.w400),
                   commonText("$statusDes ",fontSize: font_13,color:officerStatus==SCHEMES_STATUS_REJECTED?deleteColor:primaryColor,maxLines: 2,textHeight: 1.4,fontWeight: FontWeight.w600),
                   commonText("$date",fontSize: font_13,color: subtitleColor,maxLines: 2,textHeight: 1.4,fontWeight: FontWeight.w400)
                 ],
               )
              :Container()
            ],
          ),
        )
      ],
    );

  }



     _closeIconView(){
    return Container(
      height: 28,
        width: 28,
      alignment: Alignment.center,
          padding: EdgeInsets.all(margin_3),
      decoration: BoxDecoration(
        color: redLightColor,
        shape: BoxShape.circle
      ),
      child:
      Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        decoration:BoxDecoration(
          shape: BoxShape.circle,
        color: deleteColor,
        ),
        child: Icon(Icons.close,color: white,size: 16,),
      ),
    );


     }


  _recheckIconView(){
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      padding: EdgeInsets.all(margin_3),
      decoration: BoxDecoration(
          color: warningIconColor,
          shape: BoxShape.circle
      ),
      child:
      Icon(Icons.warning,color: white,size: 16,),
    );


  }


       _reSubmitView(){
               return setPadding(
                 leftPadding: margin_36,
                 widget: Column(
                   children: [
                     commonText(issuesDesStr.tr,fontSize: font_13,color: subtitleColor,maxLines: 2,textHeight: 1.4,fontWeight: FontWeight.w400),

                   sizedBox(height: margin_30),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  CustomButton(verticalPadding: margin_16,
                    horizontalPadding: margin_20,
                    buttonText: checkIssuesStr.tr.toUpperCase(),
                    buttonColor: primaryColor,
                    textColor: white,
                    onClick: (){
                      Get.toNamed(Routes().reason,arguments:{"title":checkIssuesStr,"reason": controller.reasonOfRejection,"scheme":controller.schemesStatusData});
                    },
                  ),
                    Row(
                    children: [
                      Icon(Icons.timer_outlined,color: deleteColor,size: 24,),
                      sizedBox(width: margin_5),
                      commonText("${controller.timeLeft.value} ${daysStr.tr}",fontSize: font_16,color: paragraphColor,maxLines: 2,textHeight: 1.4,fontWeight: FontWeight.w400),

                    ],
                  )
              ],
            ),


                   ],
                 ),
               );

            }

     _checkReasonButton(){
         return
          controller.reasonOfRejection.isEmpty?Container():
           Container(
           margin: EdgeInsets.only(top: margin_30),
           width: fullWidth(),
           child: CustomButton(verticalPadding: margin_20,
             buttonText: checkReasonButtonStr.tr.toUpperCase(),
             buttonColor: primaryColor,
             textColor: white,
             onClick: (){
             Get.toNamed(Routes().reason,arguments: {"title":checkReasonButtonStr,"reason":controller.reasonOfRejection,"scheme":controller.schemesStatusData});
             },
           ),
         );
      }


  _applicationInformationsContainer(){
    return
    setPaddingAll(
      margin: margin_30,
      widget:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(applicationsInformationStr.tr,color: headingColor,fontSize: font_18),
          sizedBox(height: margin_16),
          commonText(landAddressStr.tr,color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400),
          sizedBox(height: margin_8),
          commonText(controller.schemesStatusData!.landAddress,color: subtitleColor,fontSize: font_16),
          sizedBox(height: margin_30),
          _informartionList(),
        ],
      )
    )
    ;


  }


      _informartionList(){
       return Container(
         height: 80.0,
         child: ListView.separated(
             separatorBuilder: (context, index) =>
                 VerticalDivider(color: dividerColor2,thickness: 2,
                     endIndent: 30.0,),
             itemCount: 4,
             scrollDirection: Axis.horizontal,
             itemBuilder: (context,index){
           return _informationItem(index,title:controller.applicationInformationTitleList[index],
             value:controller.applicationInformationValueList[index]);

         }),
       );


      }

  _informationItem(index,{title,value}){
    return
      setPadding(
        leftPadding: index==0?margin_0:margin_8,
        rightPadding: margin_8,
        widget: Column(
        children: [
          commonText(title,color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400),
         sizedBox(height: margin_16),
          commonText(value,color: paragraphColor,fontSize: font_14),
        ],
        ),
      );
    }

  _currentlyReviewedBy(){
    return
    controller.schemesStatusData!.officerDetails!=null?
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          setPadding(
            topPadding: margin_20,
            leftPadding: margin_30,
            widget:    commonText(currentlyReviewingByStr.tr.toUpperCase(),fontSize: font_12,color: headingColor),
          ),
            setPadding(
              rightPadding: margin_10,
              widget:   ListTile(
                title:  commonText(  controller.schemesStatusData!.officerDetails!.name!,fontSize: font_14,color: paragraphColor),
                subtitle: commonText(controller.schemesStatusData!.officerDetails!.designation!,fontSize: font_12,color: subtitleColor,fontWeight: FontWeight.w400),
              //  leading:  assetImage(image: ic_user,height: 100.0,width: 100.0),
                  leading: networkImages("$image_url${controller.mediaUrl}${controller.schemesStatusData!.officerDetails!.avatar}",height: 100.0,width: 100.0),
                trailing:
                controller.schemesStatusData!.officerDetails!.phoneNumber!=null?
                getInkWell(
                  ontap: (){

                    controller.makePhoneCall(controller.schemesStatusData!.officerDetails!.phoneNumber!);
                  },
              widget:

              assetImage(image: img_call,height: 40.0,width: 40.0),
          ):Container()


              ),
            ),

          setPadding(
            leftPadding: margin_30,
            widget: Row(
              children: [
               commonText(ihrmStr.tr,fontSize: font_13,fontWeight: FontWeight.w400),
                sizedBox(width: margin_5),
                commonText(controller.schemesStatusData!.officerDetails!.ihrm!,fontSize: font_12,color: paragraphColor,fontWeight: FontWeight.w400),
              ],
            ),
          ),
        ],

    ):Container();

  }



}
