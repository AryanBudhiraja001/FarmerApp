import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/models/sendOtpDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/login_data_model.dart';

import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';

class FarmerLoginController extends GetxController{
  TextEditingController phoneNumberController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  HttpsService? httpsService;
  LoginModel? loginModel;
  var verificationIdCode="".obs;
  var isLoadingLoginData=false.obs;
  var loginErrorMessage="".obs;
  FirebaseAuth? auth;
    var resentToken;
    var deviceToken;
    var errorMessage="".obs;

    SendOtpDataModel? sendOtpDataModel;

  @override
  void onInit() {
    httpsService=HttpsService();

    getDeviceTokenToSendNotification();
    super.onInit();
  }
  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    deviceToken= await _fcm.getToken();
    debugPrint("device Token  $deviceToken");
  }
  sendOtpFun({phoneNumber})async{

    try{
      isLoadingLoginData.value=true;
      update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + sendOtpEnd,
          data: AuthParams().sendOtpAuth(
            mobileNumber: phoneNumber??phoneNumberController.text,
          )
      );
      if(response2.statusCode==200){

        sendOtpDataModel=SendOtpDataModel.fromJson(response2.data);
        isLoadingLoginData.value=false;
        update();
        toast(otpSendStr.tr);
        if(sendOtpDataModel!=null){
          debugPrint("otp response$sendOtpDataModel");
          Get.toNamed(Routes().enterOtpVerify,arguments:sendOtpDataModel!);
        }

      }
    }
    catch(e){
      isLoadingLoginData.value=false;
      update();
      if(e is DioError){
        var loginErrorMessage="".obs;
        DioException.fromDioError(e);
        loginErrorMessage.value=DioException.errorMessage!;
        debugPrint("save notification error${loginErrorMessage.value}");
        loginErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.data["message"]!=""){
          toast("${e.response!.data["message"]}");
        }
        else{
          toast(loginErrorMessage.value);
        }
      }
      else{
        toast(somethingWrongStr.tr);
      }
    }
  }

  mobileNumberExistApiCall() async {
    try{
      isLoadingLoginData.value=true;
      update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + mobileExistEnd,
          data: AuthParams().loginAuth(
            mobileNumber: phoneNumberController.text,
          )
      );
      if(response2.statusCode==200){
        isLoadingLoginData.value=false;
        update();
        verificationIdCode.value="";
        toast(mobileNumberAlreadyExistStr.tr);
        debugPrint(response2.toString());
      }
    }
    catch(e){
      if(e is DioError){
        DioException.fromDioError(e);
        loginErrorMessage.value=DioException.errorMessage!;
        loginErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){
               sendOtpFun(phoneNumber:phoneNumberController.text);
        }
        else{
          isLoadingLoginData.value=false;
          update();
          toast(loginErrorMessage.value);
        }
      }
      else{
        isLoadingLoginData.value=false;
        update();
        toast(somethingWrongStr.tr);
      }
    }
  }



  sendLoginDataApiCall()async {
    try{
      isLoadingLoginData.value=true;
    var response=  await Dio().post(BASE_URL+loginEnd,
          options: Options(
            headers:httpsService!.headers,
          ),
          data: AuthParams().loginAuth(
            mobileNumber: int.parse(phoneNumberController.text),
            deviceToken: deviceToken
          )
      );
       if(response.statusCode==200){
         isLoadingLoginData.value=false;
         loginModel=LoginModel.fromJson(response.data);
         debugPrint("login data is ${response.data}");



         getDistrict(districtID:loginModel!.userInfo!.districtId);


         if(loginModel!.userInfo!.farmerUniqueId!="null"){
           localStorage.write(LocalStorageConstants().farmerUniqueId, loginModel!.userInfo!.farmerUniqueId);
           Get.offAllNamed(Routes().mainScreen);
           }else{
             Get.offNamed(Routes().farmerProfile,arguments:phoneNumberController.text);
           }
         toast(loginModel!.message);
         debugPrint("login token is ${loginModel!.token}");
         localStorage.write(LocalStorageConstants().token, loginModel!.token);
         localStorage.write(LocalStorageConstants().userId, loginModel!.userId);
         localStorage.write(LocalStorageConstants().bankDetailsSaved,false);
         localStorage.write(LocalStorageConstants().landDetailsSaved,false);
         // localStorage.write(LocalStorageConstants().farmerId, loginModel!.);
         var token=localStorage.read(LocalStorageConstants().token);
         debugPrint("token is $token");
         debugPrint(response.toString());
       }
    }
    catch (e) {
      isLoadingLoginData.value=false;
      if (e is DioError) {
        DioException.fromDioError(e);

        errorMessage.value = DioException.errorMessage!;
        debugPrint("video feed error${errorMessage.value} ");
        toast(errorMessage.value);
        errorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          errorMessage.value = e.response!.data;
          toast(e.response!.data);
        }
        else {
          toast(errorMessage.value);
        }
      }
      else{
        toast(somethingWrongStr.tr);
      }
    }



  }

  getDistrict({districtID}) async {
    Response? response;
    try {
      response = await Dio().get(BASE_URL + districtEnd,
          options: Options(headers: httpsService?.headers));
      if (response.statusCode == 200) {
        var districtList=[];
        var districtIdList=[];
        var districtData = DistrictModel.fromJson(response.data);
        if(districtList.isEmpty){
          if(districtData.data!.district!.isNotEmpty){
            for (int i = 0; i < districtData.data!.district!.length; i++) {
              districtList.insert(
                  i, districtData.data!.district![i].districtName);
              districtIdList.insert(
                  i, districtData.data!.district![i].districtId);
            }
          }
        }
        if(districtIdList.isNotEmpty){
          var indexOfAppicant=districtIdList.indexOf(districtID);
          var districtIS= districtList[indexOfAppicant];
          debugPrint("district is saved $districtIS");
          localStorage.write(LocalStorageConstants().userDistrict,districtIS);
        }
      }

      else {
        debugPrint("there is something wrong${response.statusCode.toString()}");
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    isLoadingLoginData.value=false;
    super.onClose();
  }

}