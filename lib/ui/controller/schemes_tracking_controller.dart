import 'dart:convert';

import 'package:farmer_app/ui/constants/exports.dart';

import 'package:url_launcher/url_launcher.dart';
import '../models/schmes_status_model.dart';
import 'package:intl/intl.dart';
class SchemeSTrackingController extends GetxController{

  var isSchemesApprovedAtTehsil=false.obs;
  var isSchemesApprovedAtDistrict=false.obs;
  var isSchemesApprovedAtState=false.obs;

  var isSchemesStatusTehsil=false.obs;
  var isSchemesStatusDistrict=false.obs;
  var isSchemesStatusState=false.obs;
  var stage;


  var isTehsilRejected=false.obs;
  var isDistrictRejected=false.obs;
  var isStateRejected=false.obs;

  var isTehsilResubmit=false.obs;
  var isDistrictResubmit=false.obs;
  var isStateResubmit=false.obs;
    List<String> reasonOfRejection=[];
   var timeLeft=7.obs;
 var currentDate=DateTime.now();
  var mediaUrl="";
  SchemesStatusData? schemesStatusData;
    var  appliedSchemesDate;
    var applicationsNumber;
    var schemesType;
    var subsidyType;
  var departmentList=[
    tehsilStr.tr,
    districtStr.tr,
    approvedStr.tr
  ];



  var applicationInformationTitleList=[
    dateAppliedStr.tr,
    applicationNoStr.tr,
    typeOFSchemesStr.tr,
    subsidyTypeStr.tr,

  ];
  var applicationInformationValueList=[
    "",
    "",
    "",
    "",
  ];


  var tehsilStatus="".obs;
  var districtStatus="".obs;
  var stateStatus="".obs;

  var tehsilStatusDate="".obs;
  var districtStatusDate="".obs;
  var committeeStatusDate="".obs;
  var approvedStatusDate="".obs;

  @override
  void onInit() {
    super.onInit();
    schemesStatusData=Get.arguments;
    setSchemesTrackingDetails();

  }
  /*===========================code to find remaining days================*/
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }



    setSchemesTrackingDetails(){
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      debugPrint("date is  api${schemesStatusData!.createdAt}");
      var date=  DateTime.parse("${schemesStatusData!.createdAt}");
      appliedSchemesDate = formatter.format(date);
      applicationsNumber=schemesStatusData!.applicationNumber;
      schemesType=schemesStatusData!.nonProjectBased;
      mediaUrl=Get.find<MySchemesController>().mediaUrl;
      if(schemesStatusData!.publicPrivate==0){
        subsidyType= publicStr.tr;
      }
      else{
        subsidyType= privateStr.tr;
      }
      if(schemesStatusData!.reason!=null){
        var reasonList = json.decode(schemesStatusData!.reason!).toList();
        reasonList.removeWhere((value) => value == null);
        for(int i=0;i<reasonList.length;i++){
          reasonOfRejection.add(reasonList[i]);
          debugPrint("reason list${reasonOfRejection[i]}");
        }
        debugPrint("reason for$reasonList");
      }
      else{
        if(schemesStatusData!.districtReason!=null){
          var reasonList = json.decode(schemesStatusData!.districtReason!).toList();
          reasonList.removeWhere((value) => value == null);
          for(int i=0;i<reasonList.length;i++){
            reasonOfRejection.add(reasonList[i]);
            debugPrint("reason list${reasonOfRejection[i]}");
          }
          debugPrint("reason for$reasonList");
        }

      }



      applicationInformationValueList.insert(0, appliedSchemesDate);
      applicationInformationValueList.insert(1, applicationsNumber);
      applicationInformationValueList.insert(2, schemesType);
      applicationInformationValueList.insert(3, subsidyType);
      stage=schemesStatusData!.stage;

      if(stage==TEHSIL_STAGE){
        isSchemesStatusTehsil.value=true;
        tehsilStatus.value=schemesStatusData!.tehsilStatus!;
          if(tehsilStatus.value==SCHEMES_STATUS_PROGRESS){
            tehsilStatusDate.value="";
          }
          else{
            final DateFormat formatter = DateFormat('dd-MM-yyyy');
            var date=  DateTime.parse("${schemesStatusData!.tehsilUpdated}");
            tehsilStatusDate.value = "on ${formatter.format(date)}";
          }

          if(tehsilStatus.value==SCHEMES_STATUS_REJECTED){
            isTehsilRejected.value=true;
          }
          if(tehsilStatus.value==SCHEMES_STATUS_RESUBMIT){
            final date2 = currentDate;
            var date=  DateTime.parse("${schemesStatusData!.tehsilUpdated}");
            final difference = daysBetween(date, date2);
            debugPrint("days remaing$difference");
            if(difference<=7){
              timeLeft.value =timeLeft.value-difference;
            }
            else{
              timeLeft.value=0;
            }
            isTehsilResubmit.value=true;
          }

        update();
      }

      else if(stage==DISTRICT__STAGE){
        tehsilStatus.value=schemesStatusData!.tehsilStatus!;
          if(schemesStatusData!.tehsilStatus==SCHMES_STATUS_APPROVED||schemesStatusData!.tehsilStatus==SCHMES_STATUS_AUTO_APPROVED){
             isSchemesApprovedAtTehsil.value=true;
           }

        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        var date=  DateTime.parse("${schemesStatusData!.tehsilUpdated}");
        tehsilStatusDate.value = "on ${formatter.format(date)}";
        isSchemesStatusDistrict.value=true;
        districtStatus.value=schemesStatusData!.districtStatus!;
        if(districtStatus.value==SCHEMES_STATUS_PROGRESS){
          districtStatusDate.value="";
        }
        else{
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          var date=  DateTime.parse("${schemesStatusData!.districtUpdated}");
          districtStatusDate.value = "on ${formatter.format(date)}";
          var dateTehsil=  DateTime.parse("${schemesStatusData!.tehsilUpdated}");
          tehsilStatusDate.value = "on ${formatter.format(dateTehsil)}";
        }

          if(districtStatus.value==SCHEMES_STATUS_REJECTED){
            isDistrictRejected.value=true;
          }
          if(districtStatus.value==SCHEMES_STATUS_RESUBMIT){
            final date2 = currentDate;
            var date=  DateTime.parse("${schemesStatusData!.districtUpdated}");
            final difference = daysBetween(date, date2);
            debugPrint("days remaing$difference");
            if(difference<=7){
              timeLeft.value =timeLeft.value-difference;
            }
            else{
              timeLeft.value=0;
            }

            isDistrictResubmit.value=true;
          }

        update();

      }

      else{
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
           if(schemesStatusData!.districtUpdated!=null){
             var date=  DateTime.parse("${schemesStatusData!.districtUpdated}");
             districtStatusDate.value = "on ${formatter.format(date)}";
           }
           else{
             var date=  DateTime.parse("${schemesStatusData!.acreatedAt}");
             districtStatusDate.value = "on ${formatter.format(date)}";
           }
         if(schemesStatusData!.tehsilUpdated!=null){
           var dateTehsil=  DateTime.parse("${schemesStatusData!.tehsilUpdated}");
           tehsilStatusDate.value = "on ${formatter.format(dateTehsil)}";
         }
         else{
           var date=  DateTime.parse("${schemesStatusData!.acreatedAt}");
           tehsilStatusDate.value = "on ${formatter.format(date)}";
         }

        tehsilStatus.value=schemesStatusData!.tehsilStatus!;
        districtStatus.value=schemesStatusData!.districtStatus!;
        if(tehsilStatus.value==SCHMES_STATUS_APPROVED||tehsilStatus.value==SCHMES_STATUS_AUTO_APPROVED&&districtStatus.value==SCHMES_STATUS_APPROVED||districtStatus.value==SCHMES_STATUS_AUTO_APPROVED)
        {
          isSchemesApprovedAtState.value=true;
        }
        if(schemesStatusData!.districtStatus==SCHMES_STATUS_APPROVED||schemesStatusData!.districtStatus==SCHMES_STATUS_AUTO_APPROVED)
        {
           isSchemesApprovedAtDistrict.value=true;
        }

      }
    }


  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}


