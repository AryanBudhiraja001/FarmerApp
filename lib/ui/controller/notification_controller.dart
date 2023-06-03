import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/networks/dio/api_params.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/notification_model.dart';
import '../networks/dio/error_handling.dart';

class NotificationController extends GetxController{


 HttpsService? httpsService;
 var notificationError="";
 NotificationModel? notificationModel;
Future<NotificationModel>?notificationFutureData;
 List<NotificationData>? notificationList=[];
 List timeAgoList=[];
  @override
  void onInit() {
    httpsService=HttpsService();
    notificationFutureData= fetchNotificationApi();
    saveNotificationList();
    super.onInit();
  }





 Future<NotificationModel> fetchNotificationApi()async{
   try{
       var userId=localStorage.read(LocalStorageConstants().userId);
       Response response=await Dio().get(BASE_URL+notificationEnd,
         options:Options(
         headers:httpsService!.headers
         ),
         queryParameters: {
         "user_id":userId
         },
       );
       debugPrint("user id data is $userId");
       if(response.statusCode==200){

         notificationModel=NotificationModel.fromJson(response.data);

         debugPrint("notification data is ${response.data}");
          if(notificationModel!.data!.isNotEmpty){
            for(int i=0;i<notificationModel!.data!.length;i++){
              notificationList!.insert(i, notificationModel!.data![i]);
              DateTime dt = DateTime.parse(notificationModel!.data![i].createdAt!);
              timeAgoList.insert(i, timeago.format(dt));
            }
          }

       }
   }
   catch(e){
     if(e is DioError){
       DioException.fromDioError(e);
     notificationError=DioException.errorMessage!;
       debugPrint("save notification error$notificationError");
       notificationError=DioException.handleStatusCode(e.response!.statusCode);

       debugPrint("notification error is $notificationError");
       if(e.response!.statusCode==401){
         notificationError=e.response!.data;
       }
       else{

       }
     }
     else{
       debugPrint("notification error is ${e.toString()}");
       notificationError="Data not processes";
     }
   }
   return notificationModel!;
  }


  saveNotificationList()async{
    var userID=localStorage.read(LocalStorageConstants().userId);

    var notificationBody=AuthParams().saveNotificationParam(
       userId: userID,
      save: 1
    );
    try{
      var userId=localStorage.read(LocalStorageConstants().userId);
      Response response=await Dio().post(BASE_URL+postNotificationEnd,
        options:Options(
            headers:httpsService!.headers
        ),
      data: notificationBody,
      );

      debugPrint("user id data is $userId");
      if(response.statusCode==200){

        // notificationModel=NotificationModel.fromJson(response.data);
        debugPrint("save notification is saved${response.data}");
        Get.find<MainScreenController>().notificationReadStatus.value=false;

        }}
    catch(e){
      if(e is DioError){
        DioException.fromDioError(e);
        notificationError=DioException.errorMessage!;
        debugPrint("save category error$notificationError");
        notificationError=DioException.handleStatusCode(e.response!.statusCode);

        debugPrint(" save notification error is $notificationError");
        if(e.response!.statusCode==401){
          notificationError=e.response!.data;
        }
        else{

        }
      }
      else{
        debugPrint("notification error is ${e.toString()}");
        notificationError="Data not processes";
      }



    }
  }

  @override
  void onClose() {
    notificationList!.clear();
    super.onClose();
  }
}