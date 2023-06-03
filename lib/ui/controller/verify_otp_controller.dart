

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/models/sendOtpDataModel.dart';
import 'package:farmer_app/ui/networks/dio/HttpService.dart';

import 'package:sms_autofill/sms_autofill.dart';

import '../constants/exports.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';

class LoginOtpVerifyController extends GetxController {
  OtpFieldController otpController = OtpFieldController();
  var otp = "";
  var otpFilled = false.obs;
  bool showIndicator = false;
  FarmerLoginController? loginController = Get.find<FarmerLoginController>();
  HttpsService? httpsService;
  var loadingLoginApiData=false.obs;
  var isTimeFinish=false.obs;
  TextEditingController testotpController =TextEditingController();
  SendOtpDataModel? sendOtpDataModel;


     var phoneNumber="";
  DateTime? target;
  String timeLeft = "";
  bool running = true;

  showIndicatorFun() {
    showIndicator = !showIndicator;
    update();
  }

  onInit() {
    getOTP();
    httpsService = HttpsService();
    sendOtpDataModel=Get.arguments;


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

  getOTP() async {
    await SmsAutoFill().unregisterListener();
    await SmsAutoFill().listenForCode();
  }

  Future<void> loginUsingOtp(String otp, userId) async {
    loadingLoginApiData.value=true;
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
        loadingLoginApiData.value=false;
        update();
        loginController!.sendLoginDataApiCall();
      }
    }
    catch(e){
      loadingLoginApiData.value=false;
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


  resendOtpFun() async {
    try{
      // loadingLoginApiData.value=true;
      // update();
      debugPrint("url ${BASE_URL + mobileExistEnd}");
      var response2= await Dio().post(BASE_URL + resendOtpEnd,
          data: AuthParams().resendOtpAuth(
            userId:sendOtpDataModel!.data!.userId,
          )
      );
      if(response2.statusCode==200){
        // loadingLoginApiData.value=false;
        // update();
        otpTimer();
        getOTP();
        toast(otpResendStr.tr);
      }
    }
    catch(e){
      // loadingLoginApiData.value=false;
      // update();
      otpTimer();
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





  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    loadingLoginApiData.value=false;
    super.onClose();
  }

}

