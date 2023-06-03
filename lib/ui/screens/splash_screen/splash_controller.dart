import 'dart:async';

import 'package:farmer_app/ui/constants/exports.dart';


class SplashController extends GetxController{
  var token;
  var farmerId;
  @override
  void onInit() {
    token=localStorage.read(LocalStorageConstants().token);
    farmerId=localStorage.read(LocalStorageConstants().farmerUniqueId);
    checkLogin();
    super.onInit();
  }
  checkLogin(){
    if(token!=null&&token!=""&&farmerId!=null&&farmerId!=""){
        Timer(const Duration(seconds: 1),
      ()=>Get.offAllNamed(Routes().mainScreen));
      }
      else{
        Timer(const Duration(seconds: 1),()=>Get.offAllNamed(Routes().selectLanguage));
      }

      }
}