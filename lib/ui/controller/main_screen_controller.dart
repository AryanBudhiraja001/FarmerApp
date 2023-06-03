//import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/notification_model.dart';
import '../models/profile_data_model.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';
import '../notifications/FirebaseMessageService.dart';

class MainScreenController extends GetxController {
  var currentIndex = 0.obs;
  ProfileDataModel? profileData;
  HttpsService? httpsService;
  var notificationReadStatus=false.obs;
  var address;
  var fetchProfileErrorMessage = "".obs;
  var districtName;
  var notificationError="";
  List<NotificationData>? notificationList=[];
  NotificationModel? notificationModel;
  var bottomScreen = [
    HomeScreen(),
    //   CompleteDetailsScreen(),
    Schemes(),
    MandiRate(),
    VideoFeed(),
  ];
  var isLoadingData = false.obs;
  Future<ProfileDataModel?>? future;
  List appBarTitle = [
    homeStr.tr,
    schemesStr.tr,
    mandiRateStr.tr,
    videoFeedStr.tr,
  ];

  List drawerItems = [
    notificationsStr.tr,
    personalInfoStr.tr,
    addressStr.tr,
    languagePreferenceStr.tr,
    mySchemesStr.tr,
    bankDetailsStr.tr,
    landDetailsStr.tr,
  ];

  onBottomClick(value) {
    currentIndex.value = value;
    update();

  }
 // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  void onInit() {
    httpsService = HttpsService();
    var token = localStorage.read(LocalStorageConstants().token);

    getDeviceTokenToSendNotification();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        debugPrint("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          debugPrint("New Notification");
          FirebaseMessagingService().createanddisplaynotification(message);
        }
      },
    );
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        debugPrint("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data11 ${message.data}");
          FirebaseMessagingService().createanddisplaynotification(message);
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data22 ${message.data['_id']}");
          FirebaseMessagingService().createanddisplaynotification(message);

        //  Get.offNamed(Routes().mySchemes);

        }
      },
    );


    debugPrint("token is$token");
    future = getProfileData();
    disableKeyboard();
    fetchNotificationApi();

    getDistrictName();

    setupInteractedMessage();
    super.onInit();
  }
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
      Get.offNamed(Routes().mySchemes);
  }




  fetchNotificationApi()async{
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
         if(notificationModel!.count==0){
           notificationReadStatus.value=false;
         }
         else{
           notificationReadStatus.value=true;
         }
        }

      }



    }
    catch(e){
      if(e is DioError){
        DioException.fromDioError(e);
        notificationError=DioException.errorMessage!;
        debugPrint("schemes category error$notificationError");
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


  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    debugPrint("Token Value $token");
  }

  getDistrictName() {
    var district = localStorage.read(LocalStorageConstants().userDistrict);
    if (district == null) {
      getProfileData();
    } else {
      districtName = district;
      debugPrint("district name $districtName");
    }
  }

  /*===============================================api call to get profile data====================*/
  Future<ProfileDataModel?> getProfileData() async {
    Response? response;
    var userId = localStorage.read(LocalStorageConstants().userId);
    response = await Dio().get(BASE_URL + fetchProfileEnd,
        queryParameters: {"user_id": userId},
        options: Options(headers: httpsService?.headersGet));
    if (response.statusCode == 200) {
      if (profileData == null) {
        debugPrint("profile data ${response.data}");

        profileData = ProfileDataModel.fromJson(response.data);

        localStorage.write(LocalStorageConstants().farmerId, profileData!.data!.id);

        localStorage.write(LocalStorageConstants().userDistrict, profileData!.data!.districtName);
        if(profileData!.data!.districtName=="SAS Nagar"){
          profileData!.data!.districtName="Mohali";
          districtName = profileData!.data!.districtName;
        }
        else{
          districtName = profileData!.data!.districtName;
        }
        debugPrint("farmer id${profileData!.data!.id}");
        debugPrint("district name $districtName");
        update();
      }
    }
    return profileData!;
  }



  logoutApiCall() async {
    try {
      isLoadingData.value = true;
      update();
      var response = await Dio().post(BASE_URL + logOutEnd,
          options: Options(
            headers: httpsService!.headers,
          ),
          data: AuthParams().logoutAuth(
              token: localStorage.read(LocalStorageConstants().token)));
      if (response.statusCode == 200) {
        isLoadingData.value = false;
        update();
        debugPrint("logout response${response.data}");
        toast(response.data["message"]);
        localStorage.remove(LocalStorageConstants().token);
        Get.offAllNamed(Routes().loginScreen);
      }
    } catch (e) {
      if (e is DioError) {
        isLoadingData.value = false;
        update();
        debugPrint(e.response.toString());
        toast("${e.response!.data["message"]}");
        Get.offAllNamed(Routes().loginScreen);
      }
    }
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {
    isLoadingData.value = false;
    super.onClose();
  }
}
