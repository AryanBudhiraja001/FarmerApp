import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/mandi_data_model.dart';
import '../models/mandi_district_model.dart';
import '../models/mandi_price_model.dart';
import '../networks/dio/error_handling.dart';




class MandiRateController extends GetxController{
  HttpsService? httpsService;
  var stateSelect="State".obs;
  var districtSelect="District".obs;
  var mandiSelect="Mandi".obs;
  var selectedItem=0.obs;
  MandiPriceModel? mandiPriceModel;
  var isLoadingData=false.obs;
  Future<MandiPriceModel>? futureMandiRate;
  MandiDistrictsModel? mandiDistrictModel;
  var commonditySelectedValue="".obs;
  var mandiRateErrorMessage="".obs;
  var districtListErrorMessage="".obs;
  MandiDataModel? mandiDataModel;

  // List<MandiData> mandiRateDataList=[];


  var mandiErrorMessage="".obs;
  List itemSelected=
  [
     punjabStr,
    districtEnd,
    mandiStr,
  ];

  var isLastPage=false.obs;

  var listItemSelected=0.obs;
  var listItemSelectedDistrict=0.obs;
  var listItemSelectedMandi=0.obs;
  var listItemSelectedCommodity=0.obs;
  List districtList = [
    "All",
  ];

  List stateList = ["Punjab"];
  List mandiList = [
    "All",
  ];

  List commodity = [
    ];
  var currentPage=1.obs;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? countStartFrom;

  var isLoadingMandiRateData=false.obs;

  ScrollController mandiRateScrollController = ScrollController();
  @override
  onInit(){
    httpsService = HttpsService();
    // getDistrictList();
    futureMandiRate=  getDistrictList();
    super.onInit();
    }


  selectCommodityItem(selectItems) {
    commonditySelectedValue.value = selectItems;
 var index=commodity.indexOf(selectItems);
    listItemSelectedCommodity.value=index;
    update();
  }
  goToPageClicked(pageNumber){
    currentPage.value=pageNumber;
    getMandiPriceApiCall();
  }

  refreshUi(){
    update();
  }

  updateItemFun(index,value){
    itemSelected[index]=value;
    if(index==0){
        listItemSelected.value=index;
      }
      if(index==1){
       var selectedIndex= districtList.indexOf(value);
        listItemSelectedDistrict.value=selectedIndex;
      }
    if(index==2){
      var selectedIndex= mandiList.indexOf(value);
      listItemSelectedMandi.value=selectedIndex;
    }


    update();
  }



  updateSelectContainer(value){
    selectedItem.value=value;
    update();

  }

  selectState(value){
    stateSelect.value=value;
    update();
  }


  selectDistrict(value){
    districtSelect.value=value;
    update();
  }

  selectMandi(value){
    mandiSelect.value=value;
    update();
  }



 Future<MandiPriceModel>  getDistrictList()async{
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
            if(commodity.isNotEmpty){
              selectCommodityItem(mandiDataModel!.data!.commodity![0].commodity!);
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
        //  Get.offNamed(Routes().loginScreen);


        }
        else{
        }
      }
    }
    return  getMandiPriceApiCall();
  }

 Future<MandiPriceModel> getMandiPriceApiCall()async{
    try{
      isLoadingData.value=true;
      update();
      await Dio().get(BASE_URL+mandiPriceEnd,
        queryParameters:  {
        "market":itemSelected[2]=="Mandi"||itemSelected[2]=="All"?"":itemSelected[2],
        "district": itemSelected[1]=="district"||itemSelected[1]=="All"?"":itemSelected[1],
        "commodity":commonditySelectedValue.value=="Search commodity"||commonditySelectedValue.value=="All"?"":commonditySelectedValue.value,
          "page":currentPage.value,
        },
        options: Options
          (headers: httpsService?.headers
        ),
      ).then((value){
        if(value.statusCode==200){
          isLoadingData.value=false;
          update();
          mandiPriceModel=MandiPriceModel.fromJson(value.data);
          // for(int i=0;i<mandiPriceModel!.data!.data!.length;i++){
          //   mandiRateDataList.add(mandiPriceModel!.data!.data![i]);
          // }



          totalPages=mandiPriceModel!.data!.lastPage;
          debugPrint("mandi price data is${value.data}");
          refreshUi();
        }
      });
    }
    catch(e){
      if(e is DioError){
        isLoadingData.value=false;
        update();
        DioException.fromDioError(e);
        mandiRateErrorMessage.value=DioException.errorMessage!;
        debugPrint("mandi rate error${mandiRateErrorMessage.value} ");
        mandiRateErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){

        }
        else{

        }
      }
      else{
        isLoadingData.value=false;
        update();
      }
    }


return mandiPriceModel!;
  }
}