import 'package:farmer_app/ui/constants/exports.dart';


class SelectLanguageController extends GetxController{
  var selectedLanguage=0.obs;
  final List languages=[
    englishStr,
    punjabiStr,
    hindiStr
  ];


  var params =  {
    "user_id": "2",
    "language":"hi",
  };
  // languageData()async{
  //   await Dio().post(base_url+languageUpdateEnd,
  //       data:jsonEncode(params),
  //       options: Options(
  //         headers:httpsService?.headers,
  //       )).then((value) {
  //     toast("Language Update successfuly");
  //   }).onError((error, stackTrace) {
  //     debugPrint("error is${error.toString()}");
  //     toast("$error");
  //   });
  //
  // }
  updateLanguageFun(languageSelected){
    selectedLanguage.value=languageSelected;
    if(selectedLanguage.value==0){
      Get.updateLocale(const Locale('en', 'US'));
      update();
    }
    if(selectedLanguage.value==1){
      Get.updateLocale(const Locale('pa', 'IN'));
      update();
    }
    if(selectedLanguage.value==2){
      Get.updateLocale(const Locale('hi', 'IN'));
      update();
    }
    update();
  }
}