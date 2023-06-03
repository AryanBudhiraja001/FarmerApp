import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import '../models/SchemesModel.dart';
import '../models/fetch_bank_details_model.dart';
import '../models/fetch_land_details_model.dart';
import '../models/schmes_status_model.dart';
import '../networks/dio/error_handling.dart';



class CompleteDetailsScreensController extends GetxController{

  var bankDetailsFilled=false.obs;
  var landDetailsFilled=false.obs;
  var enableApplySchemesButton=false.obs;
  var fetchBankDetailsErrorMessage="".obs;
  FetchBankDetailsModel? fetchBankDetailsModel;
  FetchLandDetailsModel? fetchLandDetailsModel;
   var errorMessage="".obs;
  Future? futureBankDetailsData;
  HttpsService? http;
  var items=[
    bankDetailsStr.tr,
    landDetailsStr.tr,
  ];


   Scheme? scheme;
  SchemesStatusData? schemesStatusData;
  var schemesResubmit;

  @override
  void onInit() {
    scheme=Get.arguments["scheme"];
    schemesStatusData=Get.arguments["appliedScheme"];
    schemesResubmit=Get.arguments["isSchemeResubmit"];

    http=HttpsService();

    futureBankDetailsData= fetchBankDetails();
    fetchLandDetails();
  }

  refreshScreen(){
   update();
 }

 enableButton(){
    if(bankDetailsFilled.value==true&&landDetailsFilled.value==true){
      enableApplySchemesButton.value=true;
    }
    else{
      enableApplySchemesButton.value=false;
    }

  }
  getDocumentFilledDetails() async {
    var lAND = localStorage.read(LocalStorageConstants().landDetailsSaved);
    if(lAND==true){
      landDetailsFilled.value=true;
    }
    else{
      landDetailsFilled.value=false;
    }
    debugPrint("document filled $lAND");

   var bank=localStorage.read(LocalStorageConstants().bankDetailsSaved);
    debugPrint("document filled $bank");
    if(bank==true){
      bankDetailsFilled.value=true;
    }
    else{
      bankDetailsFilled.value=false;
    }
    enableButton();
  }


  Future<FetchBankDetailsModel>   fetchBankDetails()async{
    try{
      var farmerid=localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id $farmerid");
      var response=await Dio().get(
          BASE_URL+fetchBankEnd,
          queryParameters: {
            "farmer_id":farmerid,
          },
          options: Options(
            headers: http!.headersGet,
          )

      );
      if(response.statusCode==200){
         fetchBankDetailsModel=FetchBankDetailsModel.fromJson(response.data);
        debugPrint("bank detials are ${response.data}");
       if(fetchBankDetailsModel!.data!=null){
         bankDetailsFilled.value=true;
       // localStorage.write(LocalStorageConstants().bankDetailsSaved,true);
     //   getDocumentFilledDetails();

       }
       else{
         bankDetailsFilled.value=false;
         //localStorage.write(LocalStorageConstants().bankDetailsSaved,false);
        // getDocumentFilledDetails();

       }

       enableButton();
       refreshScreen();

      }
    }
    catch(e){
      if (e is DioError) {
        DioException.fromDioError(e);
        fetchBankDetailsErrorMessage.value = DioException.errorMessage!;
        debugPrint("bank  details error${fetchBankDetailsErrorMessage.value} ");
        fetchBankDetailsErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        toast(fetchBankDetailsErrorMessage.value);

      }
      else{
        toast(somethingWrongStr.tr);
      }
      enableButton();
      // getDocumentFilledDetails();
      refreshScreen();
    }
    return fetchBankDetailsModel!;
  }


  Future<FetchLandDetailsModel> fetchLandDetails() async {
    try {

      var farmerID=await localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id:${farmerID}");
      var response = await Dio().get(BASE_URL +fetchLandDetailsEnd,
          queryParameters: {"farmer_id": farmerID},
          options: Options(headers: http?.headers));
      if (response.statusCode == 200) {
        debugPrint("land details data is  ${response.data}");
        fetchLandDetailsModel = FetchLandDetailsModel.fromJson(response.data);

        if(fetchLandDetailsModel!.data!.isEmpty){
        //  localStorage.write(LocalStorageConstants().landDetailsSaved, false);
          landDetailsFilled.value=false;
        }
        else{
        //  localStorage.write(LocalStorageConstants().landDetailsSaved, true);
          landDetailsFilled.value=true;
        }
    //   getDocumentFilledDetails();
        enableButton();
        refreshScreen();
      }

    }
    catch (e) {
      if (e is DioError) {
        //getDocumentFilledDetails();
        DioException.fromDioError(e);
        errorMessage.value = DioException.errorMessage!;
        toast(errorMessage.value);
        debugPrint("land details ${errorMessage.value} ");
        errorMessage.value = DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          errorMessage.value = e.response!.data;

        }
        else {
          toast(e.toString());
        }
      }
      // else{
      //   getDocumentFilledDetails();
      // }
    }
    return fetchLandDetailsModel!;
  }

}

