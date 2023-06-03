import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import '../models/schmes_status_model.dart';
import '../networks/dio/error_handling.dart';
import 'package:intl/intl.dart';
class MySchemesController extends GetxController{

    HttpsService? https;

    MySchemesStatusModel? statusSchemesModel;
      Future<MySchemesStatusModel>? futureSchemesStatus;
   List<SchemesStatusData>? schemesDataList=[];
   var applicationsStatus=[];
    var appliedSchemesData=[];
    var schemesStatusErrorMessages="".obs;
    var schemesIdList=[];
   var mediaUrl="";
  @override
  void onInit() {
    super.onInit();
    https=HttpsService();

   futureSchemesStatus= schemesStatusApiCall();
  }


   Future<MySchemesStatusModel>schemesStatusApiCall()async{
        try{

          var farmerId=localStorage.read(LocalStorageConstants().farmerId);
        debugPrint("farmer id$farmerId");
          var response=await Dio().get(
              BASE_URL+
              fetchAppliedSchemeEnd,
              options: Options(
                headers: https!.headers
              ),
              queryParameters: {
            "farmer_id":farmerId
          }
          );
           if(response.statusCode==200){

             statusSchemesModel=MySchemesStatusModel.fromJson(response.data);
             debugPrint("schmes Staus data is ${statusSchemesModel!.data![0].farmerId}  hellooo");
             debugPrint("schmes Staus length ${statusSchemesModel!.data!.length}  hellooo");

             if(statusSchemesModel!=null){
               mediaUrl=statusSchemesModel!.mediaUrl!;
               debugPrint("fetch applied ${statusSchemesModel!.documentUrl}");
               // localStorage.write(LocalStorageConstants().docUrl,statusSchemesModel!.documentUrl);
               schemesDataList!.clear();
               for(int i=0;i<statusSchemesModel!.data!.length;i++){
                 schemesIdList.insert(i, statusSchemesModel!.data![i].schemeId);
                 schemesDataList!.insert(i, statusSchemesModel!.data![i]);

              if(statusSchemesModel!.data![i].stage==TEHSIL_STAGE){
                 applicationsStatus.insert(i, statusSchemesModel!.data![i].tehsilStatus);
              }
              else if(statusSchemesModel!.data![i].stage==DISTRICT__STAGE){
                applicationsStatus.insert(i, statusSchemesModel!.data![i].districtStatus);
              }
            else  if(statusSchemesModel!.data![i].stage==STATE_STAGE){
                   if(statusSchemesModel!.data![i].districtStatus==""){
                      if(statusSchemesModel!.data![i].tehsilStatus!=""){
                        applicationsStatus.insert(i, statusSchemesModel!.data![i].tehsilStatus);
                      }
                   }
                   else{
                     applicationsStatus.insert(i, statusSchemesModel!.data![i].districtStatus);
                   }

              }

               }
             var lisst=  json.encode(schemesIdList) ;
               localStorage.write(LocalStorageConstants().schemesIdList,lisst);

               var list=localStorage.read(LocalStorageConstants().schemesIdList);
               var list2=   json.decode(list);

             }


             if(schemesDataList!=null){
               for(int i=0;i<schemesDataList!.length;i++){
                 final DateFormat formatter = DateFormat('dd-MM-yyyy');
                 debugPrint("date is  api${schemesDataList![i].acreatedAt}");
                     // if()
                 if(schemesDataList![i].stage==TEHSIL_STAGE){
                     if(schemesDataList![i].tehsilStatus==SCHEMES_STATUS_RESUBMIT||schemesDataList![i].tehsilStatus==SCHEMES_STATUS_REJECTED)
                     {
                       var date=  DateTime.parse("${schemesDataList![i].tehsilUpdated}");
                       final String formatted = formatter.format(date);
                       debugPrint("date is $formatted");
                       appliedSchemesData.insert(i,formatted);
                     }
                     else{
                       var date=  DateTime.parse("${schemesDataList![i].acreatedAt}");
                       final String formatted = formatter.format(date);
                       debugPrint("date is $formatted");
                       appliedSchemesData.insert(i,formatted);
                     }
                 }
                 if(schemesDataList![i].stage==DISTRICT__STAGE){
                   var date=  DateTime.parse("${schemesDataList![i].tehsilUpdated}");
                   final String formatted = formatter.format(date);
                   debugPrint("date is $formatted");
                   appliedSchemesData.insert(i,formatted);
                 }
                 if(schemesDataList![i].stage==STATE_STAGE){
                    if(schemesDataList![i].districtUpdated!=null){
                    var date=  DateTime.parse("${schemesDataList![i].districtUpdated}");
                    final String formatted = formatter.format(date);
                    debugPrint("date is $formatted");
                    appliedSchemesData.insert(i,formatted);
                    }
                    else{
                      var date=  DateTime.parse("${schemesDataList![i].acreatedAt}");
                      final String formatted = formatter.format(date);
                      debugPrint("date is $formatted");
                      appliedSchemesData.insert(i,formatted);
                    }


                 }

               }

             }

           }
        }
        catch(e) {
          if (e is DioError) {
            DioException.fromDioError(e);
            schemesStatusErrorMessages.value = DioException.errorMessage!;
            debugPrint("schemes  error${schemesStatusErrorMessages.value} ");
            schemesStatusErrorMessages.value =
                DioException.handleStatusCode(e.response!.statusCode);
            if (e.response!.statusCode == 401) {

            }
            else {

            }
          }
          else {
            schemesStatusErrorMessages.value = "Data not processes";
          }
        }
   return  statusSchemesModel!;
      }



 @override
  void onClose() {
   schemesDataList!.clear();
   // TODO: implement onClose
    super.onClose();
  }


}