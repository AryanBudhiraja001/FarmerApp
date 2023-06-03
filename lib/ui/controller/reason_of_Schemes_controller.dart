import 'package:farmer_app/ui/constants/exports.dart';

import '../models/schmes_status_model.dart';

class ReasonOfSchemesController extends GetxController{


  var reasonList=[];
  var appBarTitle="";
  SchemesStatusData? schemesStatusData;
  @override
  void onInit() {
    super.onInit();
    reasonList=Get.arguments["reason"];
    appBarTitle=Get.arguments["title"];
    schemesStatusData=Get.arguments["scheme"];

  }
}