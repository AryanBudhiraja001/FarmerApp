import 'package:farmer_app/ui/controller/languages_pref_controller.dart';
import 'package:flutter/material.dart';
import '../../constants/exports.dart';

class LanguagesPreference extends StatelessWidget {
  LanguagesPreference({Key? key}) : super(key: key);

  final LanguagePrefController _controller = Get.put(LanguagePrefController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<LanguagePrefController>(
      init: LanguagePrefController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: ()async{
             //   Get.put<MainScreenController>(MainScreenController());
              return true;
          },
          child: Scaffold(
              appBar: customAppBar(title: languagesPreferenceStr.tr),
              body: _languagesList()),
        );
      },
    ));
  }

  _languagesList() {
    return ListView.builder(
        itemCount: _controller.languages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _languagesItem(index);
        });
  }

  _languagesItem(index) {
    return ListTile(
      title: commonText(_controller.languages[index],
          fontSize: font_16, color: floatingTextColor),
      trailing: Radio(
        activeColor: primaryColor,
        onChanged: (value) {
          _controller.selectLanguageFun(index);
          localStorage.write(LocalStorageConstants().selectedLanguage, index);
        },
        groupValue: index,
        // value: _controller.selectLanguages.value,
        value: _controller.selectLanguages.value,
      ),
    );
  }
}
