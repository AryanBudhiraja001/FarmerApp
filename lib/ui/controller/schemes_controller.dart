

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/SchemesModel.dart';

import '../models/schemes_category_model.dart';
import '../networks/dio/error_handling.dart';

class SchemesController extends GetxController {
  HttpsService? httpsService;
  Future<SchemesCategoryModel>? future;  // Future<SchemesModel>? future; future;
   var schemesApiCount=0;

   SchemesCategoryModel? schemesCategoryModel;
  List<SchemesCategoryModel> categoryList = [];
  var schemesErrorMesages="".obs;
  @override
  void onInit() {
    httpsService = HttpsService();
    future = getSchemesData();
    super.onInit();
  }

 refreshScreen(){
    update(["schemes"]);
 }



  Future<SchemesCategoryModel> getSchemesData() async {
    Response? response;
    try {
      response = await Dio().get(BASE_URL+schemesEnd,
          options: Options(headers: httpsService?.headers));

      if (response.statusCode == 200) {
             debugPrint("category data is${response.data[0]}");
             for(int i=0;i<response.data.length;i++){
               schemesCategoryModel=SchemesCategoryModel.fromJson(response.data[i]);
               categoryList.insert(i,schemesCategoryModel!);
             }



      } else {
        debugPrint("there is something wrong${response.statusCode.toString()}");
      }
    }
    catch(e){
      if(e is DioError){
          DioException.fromDioError(e);
          schemesErrorMesages.value=DioException.errorMessage!;
          debugPrint("schemes category error${schemesErrorMesages.value} ");
          schemesErrorMesages.value=DioException.handleStatusCode(e.response!.statusCode);
          if(e.response!.statusCode==401){
            schemesErrorMesages.value=e.response!.data;
          }
          else{

          }
        }
      else{
        schemesErrorMesages.value="Data not processes";
      }
    }
    return schemesCategoryModel!;
  }




}