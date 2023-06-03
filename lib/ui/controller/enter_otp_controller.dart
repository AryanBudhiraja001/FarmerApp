import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/models/sendOtpDataModel.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';


class RegisterOtpController extends GetxController{
  bool showIndicator=false;
  OtpFieldController otpController = OtpFieldController();
  var otp="".obs;
  var otpFilled=false.obs;

  RegisterController? registerController;

  SendOtpDataModel? sendOtpDataModel;
  var isLoadingData=false.obs;
  var deviceToken;

  var isTimeFinish=false.obs;

  DateTime? target;
  String timeLeft = "";
  bool running = true;
  onInit()  {
    getOTP();
    sendOtpDataModel=Get.arguments;
    registerController=Get.find<RegisterController>();
    getDeviceTokenToSendNotification();
    otpTimer();
    super.onInit();
  }



  otpTimer() async {
    isTimeFinish.value=false;
    target =DateTime.now().add(Duration(minutes: 5));
    while (running) {
      timeLeft = DateTime.now().isAfter(target!)
          ? ''
          : target!.difference(DateTime.now()).toString().substring(2,7);
      update(["timer"]);
      update(["Resend"]);
      if(DateTime.now().isAfter(target!)) {
        isTimeFinish.value=true;
        update(["timer"]);
        update(["Resend"]);
      }
      await Future.delayed(Duration(seconds: 1), () {});
    }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    deviceToken = await _fcm.getToken();
    debugPrint("Token Value $deviceToken");
  }
  showIndicatorFun(){
    showIndicator=!showIndicator;
    update();
  }


  getOTP()async{
    await SmsAutoFill().listenForCode();
  }

  Future<void> registerUsingOtp(String otp,int userId) async {
    isLoadingData.value=true;
    update();
    try{
      update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + verifyOtpEnd,
          data: AuthParams().verifyOtpAuth(
              otp: int.parse(otp),
              userId: userId
          )
      );
      if(response2.statusCode==200){
        isLoadingData.value=false;
        update();
        registerController!.sendRegisterDataApiCall();
      }
    }
    catch(e){
      isLoadingData.value=false;
      update();
      isTimeFinish.value=true;
      update(["timer"]);
      update(["Resend"]);
      if(e is DioError){
        var verifyOtpErrorMessage="".obs;
        DioException.fromDioError(e);
        verifyOtpErrorMessage.value=DioException.errorMessage!;
        debugPrint("save notification error${verifyOtpErrorMessage.value}");
        //  registerErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.data["message"]!=""){
          toast("${e.response!.data["message"]}");
        }
        else{
          toast(verifyOtpErrorMessage.value);
        }
      }
      else{
        toast(somethingWrongStr.tr);
      }
    }
  }





  resendOtpFun()async{
    try{
      // isLoadingData.value=true;
      // update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + resendOtpEnd,
          data: AuthParams().resendOtpAuth(
            userId:sendOtpDataModel!.data!.userId,
          )
      );
      if(response2.statusCode==200){

        // isLoadingData.value=false;
        // update();
        otpTimer();
        getOTP();
        toast(otpResendStr.tr);
      }
    }
    catch(e) {
      // isLoadingData.value = false;
      // update();
      otpTimer();
      if (e is DioError) {
        var loginErrorMessage = "".obs;
        DioException.fromDioError(e);
        loginErrorMessage.value = DioException.errorMessage!;
        debugPrint("save notification error${loginErrorMessage.value}");
        loginErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.data["message"] != "") {
          toast("${e.response!.data["message"]}");
        }
        else {
          toast(loginErrorMessage.value);
        }
      }
      else {
        toast(somethingWrongStr.tr);
      }
    }
  }




  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    isLoadingData.value=false;
    otp.value="";
    super.onClose();
  }


}