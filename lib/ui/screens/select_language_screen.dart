
import 'package:farmer_app/ui/database/shared_pred.dart';
import 'package:flutter/material.dart';

import '../constants/exports.dart';

class SelectLanguage extends GetView<SelectLanguageController> {
  const SelectLanguage({super.key});



  @override
  Widget build(BuildContext context) {
    return
           Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Get.toNamed(Routes().registerScreen);
              },
              backgroundColor: primaryColor,
              child: Icon(Icons.arrow_forward_ios,color: white,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body:GetBuilder<SelectLanguageController>(
    builder:(controllers){
      return

            SingleChildScrollView(
              child:   setPadding(
                topPadding: margin_48,
                bottomPadding:margin_48,
                leftPadding: margin_53,
                rightPadding: margin_53,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logo(),
                    sizedBox(height: margin_48),
                    titleText(selectLanguageStr.tr),
                    sizedBox(height: margin_48),
                    _languageList(),
                  ],
                ),
              ),
            );
    }),
    );
  }

  _languageList(){
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.languages.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              // verticalOffset: 50.0,
              child: FadeInAnimation(
                child:_listItem(textTitle:controller.languages[index],index: index)
              ),
            ),
          );
        },
      ),
    );
  }

  _listItem({textTitle,index}){
    return getInkWell(
      ontap: (){
        controller.updateLanguageFun(index);
        localStorage.write(LocalStorageConstants().selectedLanguage, controller.selectedLanguage.value);
        var selectedlanguage=localStorage.read(LocalStorageConstants().selectedLanguage);
        debugPrint("selected Language is $selectedlanguage");
        },
      widget: Container(
        margin: EdgeInsets.only(bottom: margin_29),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: margin_40,horizontal:margin_105),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_4),
          color: white,
          border: Border.all(color:controller.selectedLanguage.value==index?primaryColor:borderColor),
        ),
        child: commonText(textTitle??"English",fontSize:font_16,color: subtitleColor,fontWeight: FontWeight.w400),

      ),
    );
  }




}
