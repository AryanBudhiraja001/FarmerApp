import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../constants/exports.dart';


class RegisterOtpVerification extends GetView<RegisterOtpController> {
   RegisterOtpVerification({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:GetBuilder<RegisterOtpController>(
            init: RegisterOtpController(),
            builder: (_){
              return controller.isLoadingData.value?loader():
              SingleChildScrollView(
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
                          GetBuilder<RegisterOtpController>(
                              id: "RegisterOtpWidgets",
                              builder: (_){
                            return  otpAutoFilled();
                          }),

                        sizedBox(height: margin_57),
                        _registerButton(),
                        sizedBox(height: margin_78),
                        GetBuilder<RegisterOtpController>(
                            id: "Resend",
                            builder: (_){
                              return   controller.isTimeFinish.value?alreadyAccountText(
                                  title: notReceiveStr.tr, leading:resendStr.tr,
                                  onclick: () {
                                    controller.otp.value="";
                                    controller.update(["RegisterOtpWidgets"]);
                                    controller.resendOtpFun();
                                  }) :
                              GetBuilder<RegisterOtpController>(
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
    return commonText(receiveInStr.tr,
        fontWeight: FontWeight.w400, color: floatingTextColor);
  }
  otpAutoFilled(){
    return    PinFieldAutoFill(
      codeLength: 4,
      decoration: UnderlineDecoration(
        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
      ),
      currentCode: controller.otp.value,
      onCodeSubmitted: (code) {

      },
      onCodeChanged: (code) {
        if (code!.length == 4) {
              debugPrint("code is $code");
              controller.otp.value=code;
              controller.otpFilled.value=true;
        }
      },
    );

    }


    _registerButton() {
    return GetBuilder<RegisterOtpController>(
      builder: (controller){
        return    Row(
        children: [
        Expanded(
        child: CustomButton(
          onClick: (){
            var id=controller.sendOtpDataModel!.data!.userId;
            if(controller.otpFilled.value){
              controller.registerUsingOtp(controller.otp.value,id!);
            }
            else{
              toast(enterValidOtpStr.tr);
            }
          },
          showIndicator: controller.showIndicator,
         cornerRadius: margin_25,
        buttonText: registerStr.tr,
        ),
        ),
        ],
        );
      },
    );
  }
}
