
import 'package:flutter/material.dart';

import '../../constants/exports.dart';

class FarmerLogin extends GetView<FarmerLoginController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:GetBuilder<FarmerLoginController>(
            builder: (_){
            return  controller.isLoadingLoginData.value?loader():
              SingleChildScrollView(
                child: Center(
                  child: setPadding(
                    topPadding: margin_48,
                    bottomPadding:margin_48 ,
                    leftPadding: margin_22,
                    rightPadding: margin_22,
                    widget: Column(
                      children: [
                        logo(),
                        sizedBox(height: margin_48),
                        titleText(farmerLoginStr.tr),
                        sizedBox(height: margin_48),
                        _phoneNumberEditText(),
                        sizedBox(height: margin_57),
                        _getOtpButton(),
                        sizedBox(height: margin_78),
                        alreadyAccountText(title: notHaveAccountStr.tr,leading: registerNowStr.tr,
                            onclick: (){
                              Get.offAllNamed(Routes().registerScreen);
                            }
                        ),
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

  _phoneNumberEditText() {
    return GetBuilder<FarmerLoginController>(
      builder: (_){
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: CommonTextField(
            controller:controller.phoneNumberController,
            inputType: TextInputType.number,
            labelText:mobileNumberStr.tr,
            inputFormators: [phoneNumberFormatter],
            preText: preTextPhoneStr.tr,
            validation: (value){
              if(value.length<10){
                return  validMobileStr.tr;
              }
              else{
                disableKeyboard();
              }
              },
          ),
        );
        },
    );
  }

  _getOtpButton(){
    return
      Row(
        children: [
          Expanded(
            child: CustomButton(
              onClick: (){
                   disableKeyboard();
                if(controller.formKey.currentState!.validate()){

                }
                if(controller.phoneNumberController.text.length<10){
                  toast(validMobileStr.tr);
                }
                else{
                    controller.mobileNumberExistApiCall();
                }

              },
              cornerRadius: margin_25,
              buttonText: getOtpStr.tr,
            ),
          ),
        ],
      );
  }






}
