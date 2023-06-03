
import 'package:flutter/material.dart';
import '../../constants/exports.dart';

class Register extends GetView<RegisterController> {
    Register({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:GetBuilder<RegisterController>(
            init:RegisterController(),
            builder: (_){
              return   controller.isLoadingNumberExist.value?loader():

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
                        titleText(farmerRegisterStr.tr),
                        sizedBox(height: margin_48),
                        _phoneNumberEditText(),
                        sizedBox(height: margin_57),
                        _getOtpButton(),
                        sizedBox(height: margin_78),
                        alreadyAccountText(title: alreadyStr.tr,leading: loginStr.tr,
                            onclick: (){
                              Get.offAllNamed(Routes().loginScreen);
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
    return GetBuilder<RegisterController>(
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
              inputActions: TextInputAction.done,
              validation: (value){
                if(value.length<10){
                  return  validMobileStr.tr;
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
                   if(controller.formKey.currentState!.validate()){
                     disableKeyboard();
                      controller.mobileNumberExistApiCall(phoneNumber:controller.phoneNumberController.text);

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
