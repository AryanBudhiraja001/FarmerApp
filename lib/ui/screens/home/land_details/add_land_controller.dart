import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import '../../../networks/dio/api_params.dart';
import '../../../networks/dio/error_handling.dart';

class addLandController extends GetxController{

  // var extended;
  //
  // DynamicLandFieldsController (this.extended);
  final formKey = GlobalKey<FormState>();

  TextEditingController totalLandAreaEditController=TextEditingController();
  TextEditingController landSurveyNUmberEditController=TextEditingController();
  TextEditingController stateEditController=TextEditingController();
  TextEditingController districtEditController=TextEditingController();
  TextEditingController tehsilEditController=TextEditingController();
  TextEditingController villageEditController=TextEditingController();
  TextEditingController fullAddressEditController=TextEditingController();
  TextEditingController pincodeEditController=TextEditingController();
  TextEditingController landAddressEditController=TextEditingController();
  TextEditingController areaInformationEditController=TextEditingController();
  TextEditingController fardEditController=TextEditingController();
  TextEditingController patedarNoEditController=TextEditingController();
  TextEditingController khewatNoEditController=TextEditingController();
  TextEditingController khataniNoEditController=TextEditingController();
  TextEditingController khasraNoEditController=TextEditingController();


  var loadingData=false.obs;
  DistrictModel? districtData;
  HttpsService? httpsService;
  // var  districtList=[];
  // var  districtIdList=[];
  // var  tehsilList=[];
  // var  tehsilIdList=[];
  // var  villageList=[];
  // var  villageIdList=[];

  var errorMessage="".obs;
  var showLandForm=false.obs;

    LandDetailsController? landController;

  showLandDetails(){
    showLandForm.value=!showLandForm.value;
    update();
  }

 landExtend(value){
   showLandForm.value=value;
    update();
  }

  /*================index of select district ,tehsil, village in the drop down menu   to get id  for send to api====================*/

  var selectedDistrictIndex=0.obs;
  var selectedTehsilIndex=0.obs;
  var selectedVillageIndex=0.obs;


/*================id of select district ,tehsil, village in the drop down menu for send to api====================*/
  var selectDistrictId=0.obs;
  var selectTehsilId=0.obs;
  var selectVillageId=0.obs;

  /*================id of select district ,tehsil, village in the drop down menu for send to api====================*/

  var  selectDistrictTypeId=0.obs;
  var  selectTehsilTypeId=0.obs;
  var  selectVillageTypeId=0.obs;

  var landDetailsFilled=false.obs;
  var pickFardFile;
  var pickPatedarDocumentFile;
  var landAddressExpansion=true.obs;
  Future? districtFutureData;
  var landDetailsErrorMessage="".obs;
  var generatedLandNumber=0.obs;

  @override
  void onInit() {
    httpsService=HttpsService();
    landController=Get.find<LandDetailsController>();

    districtFutureData=landController!.checkIsTodayVisit();

    super.onInit();
  }


  var stateList=[
    punjabStr
  ];



  void stateType(String value) {
    stateEditController.text=value;
    update();
  }





  void districtType(String value) {
    districtEditController.text=value;
    update();
  }

  void tehsilType(String value) {
    tehsilEditController.text=value;
    update();
  }

  void villageType(String value) {
    villageEditController.text=value;
    update();
  }


  selectDistrictIndexIdFun(value){
    selectedDistrictIndex.value=value;
    update();
  }

  selectDistrictTypeIdFun(value){
    selectDistrictTypeId.value=value;
    update();
  }


  selectTehsilTypeIdFun(value){
    selectTehsilTypeId.value=value;
    update();
  }



  selectVillageTypeIdFun(value){
    selectVillageTypeId.value=value;
    update();
  }


  void selectDistrictIdFun(var value) {
    selectDistrictId.value=value;
    update();
  }
  void selectTehsilIdFun(var value) {
    selectTehsilId.value=value;
    update();
  }
  void selectVillageIdFun(var value) {
    selectVillageId.value=value;
    update();
  }

  selecttehsilIndexIdFun(value){
    selectedTehsilIndex.value=value;
    update();
  }

  changeExpansion(value){
    landAddressExpansion.value=value;
    update();
  }
  refreshScreen(){
    update();
  }



  landDetailsPostApiCall() async {
    try {
      loadingData.value=true;
      update();
      var fardDoucmentMUltiPartFile;
      var patedarDocumentMultipartFile;
      if (pickFardFile != null) {
        fardDoucmentMUltiPartFile =
        await MultipartFile.fromFile(pickFardFile!.path,
            filename: pickFardFile!.path);
      }
      if (pickPatedarDocumentFile != null) {
        patedarDocumentMultipartFile =
        await MultipartFile.fromFile(pickPatedarDocumentFile!.path,
            filename: pickPatedarDocumentFile!.path);
      }
      var token=localStorage.read(LocalStorageConstants().token);
      var farmerID=await localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id:${farmerID} and token ${token}");

      var landDetailsData = AuthParams().landDetailsParam(
          farmerid: farmerID,
          totalLandArea: totalLandAreaEditController.text.trim(),
          state: stateEditController.text.trim(),
        district:selectDistrictId.value,
        tehsil: selectTehsilId.value,
        city: selectVillageId.value,
        landAddress: landAddressEditController.text.trim(),
        pinCode: pincodeEditController.text.trim(),
        areaInformations: areaInformationEditController.text.trim(),
        pateDarNo: patedarNoEditController.text.trim(),
        khasraNo: khasraNoEditController.text,
          khatauniNo: khataniNoEditController.text,
        khewatNumber: khewatNoEditController.text,
        uploadFard:fardDoucmentMUltiPartFile,
        uploadPatedarDocument: patedarDocumentMultipartFile,


      );

      var response = await Dio().post(
          BASE_URL+landDetailsEnd,
          data: landDetailsData,
          options: Options(headers: httpsService!.headers)
      );
      if (response.statusCode == 200) {
        landDetailsFilled.value=true;
        loadingData.value=false;
           update();
        localStorage.write(LocalStorageConstants().landDetailsSaved, true);
        toast(landDetailsAddedStr.tr);
        Get.back(result: true);
        // bankDetailsFilled.value=true;
        debugPrint("land  details response successfull${response.data}");
      }
    }
    catch (e) {
      loadingData.value=false;
      update();
      if (e is DioError) {
        DioException.fromDioError(e);
        landDetailsErrorMessage.value = DioException.errorMessage!;
        debugPrint("land details  error${landDetailsErrorMessage.value} ");
        toast(landDetailsErrorMessage.value);
        landDetailsErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          landDetailsErrorMessage.value = e.response!.data;
          toast(e.response!.data);
        }
        else {
          loadingData.value=false;
          update();
        }
      }
    }
  }

  @override
  void onClose() {
    loadingData.value=false;
    super.onClose();
  }

}
