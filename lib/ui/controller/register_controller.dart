import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/models/sendOtpDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../models/register_model.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';


class RegisterController extends GetxController{

  TextEditingController phoneNumberController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  var verificationIdCode="".obs;
  HttpsService? httpsService;
  var selectedLanguageIndex;

  SendOtpDataModel? sendOtpDataModel;
  var locale;
  var resentToken;
  var deviceToken;



 var isLoadingNumberExist=false.obs;
 var registerErrorMessage="".obs;
  var errorMessage="".obs;
  RegisterModel? registerModel;
  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    httpsService=HttpsService();

    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    deviceToken= await _fcm.getToken();
    debugPrint("device Token  $deviceToken");
  }

  FirebaseAuth? auth;
  sendOtpFun({phoneNumber})async{
    try{
      isLoadingNumberExist.value=true;
      update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + sendOtpEnd,
          data: AuthParams().sendOtpAuth(
            mobileNumber: phoneNumber??phoneNumberController.text,
          )
      );
      if(response2.statusCode==200){
        sendOtpDataModel=SendOtpDataModel.fromJson(response2.data);
        isLoadingNumberExist.value=false;
            update();
            toast(otpSendStr.tr);
            if(sendOtpDataModel!=null){
              Get.toNamed(Routes().enterOtp,arguments:sendOtpDataModel!);
            }
      }
    }
    catch(e){
      isLoadingNumberExist.value=false;
      update();
      if(e is DioError){
        DioException.fromDioError(e);
        registerErrorMessage.value=DioException.errorMessage!;
        debugPrint("save notification error${registerErrorMessage.value}");
        registerErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.data["message"]!=""){
          toast("${e.response!.data["message"]}");
        }
        else{
          toast(registerErrorMessage.value);
        }
      }
      else{
        toast(somethingWrongStr.tr);
      }
    }
  }


  mobileNumberExistApiCall({phoneNumber}) async {
    try{
      isLoadingNumberExist.value=true;
      update();
          debugPrint("url ${BASE_URL + mobileExistEnd}");
          var response2= await Dio().post(BASE_URL + mobileExistEnd,
              data: AuthParams().loginAuth(
                  mobileNumber: phoneNumber??phoneNumberController.text,
                 )
          );
          if(response2.statusCode==200){
            verificationIdCode.value="";
            sendOtpFun(phoneNumber:phoneNumberController.text);
            debugPrint(response2.toString());
          }
        }
        catch(e){
          isLoadingNumberExist.value=false;
          update();
          if(e is DioError){
            DioException.fromDioError(e);
            registerErrorMessage.value=DioException.errorMessage!;
            debugPrint("save notification error${registerErrorMessage.value}");
            registerErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
              if(e.response!.data["message"]!=""){
                toast("${e.response!.data["message"]}");
              }
              else{
                toast(registerErrorMessage.value);
              }
          }
          else{
            toast(somethingWrongStr.tr);
          }
    }
  }



  sendRegisterDataApiCall()async {
    selectedLanguageIndex =
    await localStorage.read(LocalStorageConstants().selectedLanguage);
    if (selectedLanguageIndex != null) {
      if (selectedLanguageIndex == 0) {
        locale = "en";
      }
      else if (selectedLanguageIndex == 1) {
        locale = "pa";
      }
      else {
        locale = "hi";
      }
    }
    try{
      isLoadingNumberExist.value=true;
   update();
      debugPrint("url ${BASE_URL + registerEnd}");
      var response2= await Dio().post(BASE_URL + registerEnd,
          data: AuthParams().registerAuth(
              mobileNumber:int.parse(phoneNumberController.text),
              languageLocale: locale ?? "en",
               deviceToken:deviceToken,
              ),

            );
      if(response2.statusCode==200){
        isLoadingNumberExist.value=false;
        update();
        registerModel = RegisterModel.fromJson(response2.data);
        localStorage.write(LocalStorageConstants().token, registerModel!.token);
        localStorage.write(LocalStorageConstants().userId, registerModel!.userId);
         toast("${registerModel!.message}");
        var token=localStorage.read(LocalStorageConstants().token);
        debugPrint("token is $token");
        Get.offNamed(Routes().farmerProfile,arguments: phoneNumberController.text);
        debugPrint(response2.toString());
      }
    }
    catch (e) {
      isLoadingNumberExist.value=false;
      update();
      if (e is DioError) {
        DioException.fromDioError(e);
        errorMessage.value = DioException.errorMessage!;
        debugPrint("video feed error${errorMessage.value} ");
        toast(errorMessage.value);
        errorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          toast(errorMessage.value);
        }
        else {
          isLoadingNumberExist.value=false;
          update();
        }
      }
      else{
        toast(somethingWrongStr.tr);
      }
    }
  }

@override
  void onClose() {
    SmsAutoFill().unregisterListener();
    isLoadingNumberExist.value=false;
    super.onClose();
  }


}