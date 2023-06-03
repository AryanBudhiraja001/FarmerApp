import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../constants/exports.dart';

class LoginOtpVerify extends GetView<LoginOtpVerifyController> {
  LoginOtpVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:GetBuilder<LoginOtpVerifyController>(
            init:LoginOtpVerifyController(),
            builder: (_){
              return   controller.loadingLoginApiData.value?loader():SingleChildScrollView(
                child: Center(
                  child: setPadding(
                    topPadding: margin_48,
                    leftPadding: margin_22,
                    rightPadding: margin_22,
                    bottomPadding: margin_48,
                    widget: Column(
                      children: [
                        logo(),
                        sizedBox(height: margin_48),
                        titleText(enterTheOtpStr.tr),
                        sizedBox(height: margin_10),
                        subTitleText(),
                        sizedBox(height: margin_48),

                          GetBuilder<LoginOtpVerifyController>(
                              id: "OtpWidgets",
                              builder: (_){
                            return    _otpAutoFilled();
                          }),


                        sizedBox(height: margin_57),
                        _verifyButton(),
                        sizedBox(height: margin_78),
                        GetBuilder<LoginOtpVerifyController>(
                                id: "Resend",
                                builder: (_){
                              return   controller.isTimeFinish.value?alreadyAccountText(
                                  title: notReceiveStr.tr, leading:resendStr.tr,
                                  onclick: () {
                                    controller.otp="";
                                   controller.update(["OtpWidgets"]);
                                    controller.resendOtpFun();
                                  }) :
                              GetBuilder<LoginOtpVerifyController>(
                                  id: "timer",
                                  builder: (_){
                                    return    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        commonText(resentOtpInStr.tr,
                                            fontSize: font_16,fontWeight: FontWeight.w400, color: floatingTextColor),
                                        sizedBox(width: margin_10),
                                        commonText("${controller.timeLeft}",
                                            fontSize: font_16,fontWeight: FontWeight.w400, color: redColor),
                                      ],
                                    );

                                  });

                            })






                      ],
                    ),
                  ),
                ),
              );
            },
          )

        ),
    );
  }


  subTitleText() {
    return commonText(
        receiveInStr.tr, fontWeight: FontWeight.w400, color: floatingTextColor);
  }

  _otpAutoFilled() {
    return PinFieldAutoFill(
      //controller: controller.testotpController,
      codeLength: 4,
      decoration: UnderlineDecoration(
        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
      ),
      //currentCode:"1234",
      currentCode: controller.otp,
      onCodeSubmitted: (code) {

      },
      onCodeChanged: (code) {
        if (code!.length == 4) {
          debugPrint("code is $code");
          controller.otp = code.toString();
          controller.otpFilled.value = true;
        //  controller.update();
        }
      },
    );
  }

  _verifyButton() {
    return
      Row(
        children: [
          Expanded(
            child: CustomButton(
              onClick: () {
                if (controller.otpFilled.value) {
                  var id = controller.sendOtpDataModel!.data!.userId;
                  controller.loginUsingOtp(controller.otp, id);
                }
                else {
                  toast(enterValidOtpStr.tr);
                }
              },
              cornerRadius: margin_25,
              buttonText: verifyStr.tr,
            ),
          ),
        ],
      );
  }


}
