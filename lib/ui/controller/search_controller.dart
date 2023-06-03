import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import '../models/mandi_data_model.dart';
import '../models/mandi_price_model.dart';
import '../networks/dio/error_handling.dart';

class SearchController extends GetxController {
  //
  // var selectdContainer=0.obs;
  var selectItem = 0.obs;
  var selectedIndex=0.obs;
 var mandiErrorMessage="".obs;
  MandiDataModel? mandiDataModel;
  var commonditySelectedValue="Bindi".obs;
  HttpsService? httpsService;


  Future? futureDistrictData;

  List districtList = [
    allStr
  ];

  List stateList = [punjabStr];
  List mandiList = [
    allStr
  ];

  List commodity = [
    ];

  List foundUsers = [];
  // MandiRateController? mandiController;
@override
  onInit() {
     var argument=Get.arguments;
    selectedIndex.value=argument["index"];
    selectItem.value=argument["itemSelected"];
    update();
    httpsService=HttpsService();
    // mandiController = Get.find<MandiRateController>();
    // mandiDistrictModel = mandiController!.mandiDistrictModel;
   // getDistrictList();
    futureDistrictData=getDistrictList();
    super.onInit();
  }

  selectItemFun(selectItems) {
    selectItem.value = selectItems;
    update();
  }

  selectCommodityItem(selectItems) {
    commonditySelectedValue.value = selectItems;
    update();
  }

  foundUserFun(users) {
    foundUsers = users;
    update();
  }

  Future<MandiDataModel>  getDistrictList()async{
    try{
      var response=  await Dio().get(BASE_URL+mandiEnd,
        options: Options(headers: httpsService?.headersGet),
      );
      if(response.statusCode==200){
        mandiDataModel=MandiDataModel.fromJson(response.data);
        if(mandiDataModel!=null){
          for(int i=0;i<mandiDataModel!.data!.district!.length;i++){
            districtList.insert(i+1, mandiDataModel!.data!.district![i].district);
          }
          for(int i=0;i<mandiDataModel!.data!.commodity!.length;i++){
            commodity.insert(i, mandiDataModel!.data!.commodity![i].commodity);
          }
          for(int i=0;i<mandiDataModel!.data!.market!.length;i++){
            mandiList.insert(i+1, mandiDataModel!.data!.market![i].market);
          }
        }
        update();
        debugPrint("mandi  data is${response.data}");
      }
    }
    catch(e){
      if(e is DioError){
        DioException.fromDioError(e);
        mandiErrorMessage.value=DioException.errorMessage!;
        mandiErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){
          toast(e.response!.data);
       //   Get.offNamed(Routes().loginScreen);
          // mandiErrorMessage.value=e.response!.data;

        }
        else{
        }
      }
    }
    return mandiDataModel!;
  }


}
