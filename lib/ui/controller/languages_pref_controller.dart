import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';


class LanguagePrefController extends GetxController{
  var selectLanguages=0.obs;

  List languages=
  [
    englishStr,
    punjabiStr,
    hindiStr
  ];


  @override
  void onInit() {
    super.onInit();
    getLanguagesSelectedIndex();
  }

  getLanguagesSelectedIndex() {
    var index = localStorage.read(LocalStorageConstants().selectedLanguage);
    if (index != null) {
      if (index == 0) {
        selectLanguages.value = 0;
      }
      if (index == 1) {
        selectLanguages.value = 1;
      }
      if (index == 2) {
        selectLanguages.value = 2;
      }
    }
  }

    selectLanguageFun(itemSelected) {
      selectLanguages.value = itemSelected;
      if (selectLanguages.value == 0) {
        Get.updateLocale(const Locale('en', 'US'));
        update();
      }
      if (selectLanguages.value == 1) {
        Get.updateLocale(const Locale('pa', 'IN'));
        update();
      }
      if (selectLanguages.value == 2) {
        Get.updateLocale(const Locale('hi', 'IN'));
        update();
      }
      update();
    }

    var headers = {
      'Authorization': 'Bearer 4|91D5RFNabq4XiNsAmRHzQ9XHaVAOTmrNlNT1JZCe'
    };
    var params = {
      "user_id": "2",
      "language": "hi",
    };

    languageData() async {
      await Dio().post(BASE_URL + languageUpdateEnd,
          data: jsonEncode(params),
          options: Options(
            headers: headers,
          )).then((value) {
        toast("Language Update successfuly");
      }).onError((error, stackTrace) {
        debugPrint("error is${error.toString()}");
        toast("$error");
      });
    }
  }


