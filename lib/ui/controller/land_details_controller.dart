import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/fetch_land_details_model.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';



class LandDetailsController extends GetxController{
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
  //TextEditingController patedarNoEditController=TextEditingController();
  TextEditingController khewatNoEditController=TextEditingController();
  TextEditingController khataniNoEditController=TextEditingController();
  TextEditingController khasraNoEditController=TextEditingController();
 var isLoadingLandDetailsData=false.obs;
  DistrictModel? districtData;
  HttpsService? httpsService;
  FetchLandDetailsModel? fetchLandDetailsModel;
  var  districtList=[];
  var  districtIdList=[];
  var  tehsilList=[];
  var  tehsilIdList=[];
  var  villageList=[];
  var  villageIdList=[];
  var errorMessage="".obs;
  var extendLandDetailsForm=[];
   var mediaUrl;
   var updateLandDetailsErrorMessage="".obs;
   var deleteErrorMessage="".obs;




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
  var currentIndex=0.obs;
  var landDetailsFilled=false.obs;
  var pickFardFile;
  var pickPatedarDocumentFile;
  var isPickedFardFile=false.obs;
  var isPickedPatedarDocumentFile=false.obs;

  var landAddressExpansion=true.obs;
   Future? landDetailsFutureData;
   var addLandDetailsList=[];

   List<LandData> landDetailsDataList=[];


@override
  void onInit() {
   httpsService=HttpsService();
   landDetailsFutureData= fetchLandDetails();
   checkIsTodayVisit();

    super.onInit();
  }
  extendLandFormFun(index){
     extendLandDetailsForm[index]=!extendLandDetailsForm[index];
      if(landDetailsDataList.isNotEmpty){
        setLandDetailsFormData(index);
      }

    update();
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
    }

  resetExtendLandDetailsForm(index){
    extendLandDetailsForm.clear();
    for(int i=0;i<addLandDetailsList.length;i++){
      extendLandDetailsForm.insert(i, false);
    }

  }
  @override
  void onClose() {
    addLandDetailsList.clear();
    currentIndex.value=0;
  }

  var stateList=[
    punjabStr
  ];

  refreshScreen() {
  update();
  }



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
  selectDistrictSelectedIndexIdFun(value){
    selectedDistrictIndex.value=value;
    update();
  }
  selecttehsilSelectedIndexIdFun(value){
    selectedTehsilIndex.value=value;
    update();
  }


  Future<DistrictModel> getDistrictData()async{
    try{
      var response= await Dio().get(
          BASE_URL+districtEnd,
          options: Options(
              headers: httpsService?.headers));
      if(response.statusCode==200){
        debugPrint("district data is ${response.data}");
        var model=DistrictModel.fromJson(response.data);
        String user = jsonEncode(model);
        localStorage.write(LocalStorageConstants().districtDataModel,user);
        districtData=model;
        if(districtList.isEmpty) {
          for (int i = 0; i < districtData!.data!.district!.length; i++) {
            districtList.insert(
                i, districtData!.data!.district![i].districtName);
            districtIdList.insert(
                i, districtData!.data!.district![i].districtId);
          }
        }
        update();
      } else{
        debugPrint("there is something wrong${response.statusCode.toString()}");
      }
    }
    catch (e){
      if(e is DioError){
        DioException.fromDioError(e);
        errorMessage.value=DioException.errorMessage!;
        debugPrint("district data  error${errorMessage.value} ");
        errorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){
          errorMessage.value=e.response!.data;
        }
        else{

        }
      }
    }
    return districtData!;
  }

  getTehsilData(int index){
    if(districtList.isNotEmpty){
      if(tehsilList.isEmpty) {
        for (int i = 0; i <
            districtData!.data!.district![index].tehsil!.length; i++) {
          tehsilList.insert(
              i,  districtData!.data!.district![index].tehsil![i].tehsilName);
          tehsilIdList.insert(i,districtData!.data!.district![index].tehsil![i].tehsilId);
        }
      }
      else{
        tehsilList.clear();
        tehsilIdList.clear();
        for (int i = 0; i <
            districtData!.data!.district![index].tehsil!.length; i++) {
          tehsilList.insert(
              i,  districtData!.data!.district![index].tehsil![i].tehsilName);
          tehsilIdList.insert(i,districtData!.data!.district![index].tehsil![i].tehsilId);
        }

      }

    }
  }
  getVillageData(int index,int districtIndex){
    if(tehsilList.isNotEmpty){
      if(villageList.isEmpty) {
        for (int i = 0; i <districtData!.data!.district![districtIndex].tehsil![index].city!.length; i++) {
          villageList.insert(i, districtData!.data!.district![districtIndex].tehsil![index].city![i].cityName);
          villageIdList.insert(i,districtData!.data!.district![districtIndex].tehsil![index].city![i].cityId);
        }
      }
      else{
        villageList.clear();
        villageIdList.clear();
        for (int i = 0; i <districtData!.data!.district![districtIndex].tehsil![index].city!.length; i++) {
          villageList.insert(i, districtData!.data!.district![districtIndex].tehsil![index].city![i].cityName);
          villageIdList.insert(i,districtData!.data!.district![districtIndex].tehsil![index].city![i].cityId);
        }

      }

    }
  }



  Future<FetchLandDetailsModel> fetchLandDetails() async {
     // Response? response;
     try {

       var farmerID=await localStorage.read(LocalStorageConstants().farmerId);
       debugPrint("farmer id:${farmerID}");
       var response = await Dio().get(BASE_URL +fetchLandDetailsEnd,
           queryParameters: {"farmer_id": farmerID},
           options: Options(headers: httpsService?.headers));
       if (response.statusCode == 200) {
         debugPrint("land details data is  ${response.data}");
         fetchLandDetailsModel = FetchLandDetailsModel.fromJson(response.data);
         mediaUrl=fetchLandDetailsModel!.mediaUrl;
         for(int i=0;i<fetchLandDetailsModel!.data!.length;i++){
           addLandDetailsList.insert(i, "${i+1}");
           extendLandDetailsForm.insert(i, false);
           landDetailsDataList.insert(i,fetchLandDetailsModel!.data![i]);

         }
          refreshScreen();

         if(fetchLandDetailsModel!.data!.isEmpty){
         localStorage.write(LocalStorageConstants().landDetailsSaved, false);
         }
         else{
           localStorage.write(LocalStorageConstants().landDetailsSaved, true);
         }
         getDocumentFilledDetails();
         // Future.delayed(Duration(seconds: 1)).then((value) {
         //   update();
         // });


       }

     }
     catch (e) {
       if (e is DioError) {
         DioException.fromDioError(e);
         errorMessage.value = DioException.errorMessage!;
         toast(errorMessage.value);
         debugPrint("land details ${errorMessage.value} ");
         errorMessage.value = DioException.handleStatusCode(e.response!.statusCode);
         if (e.response!.statusCode == 401) {
           errorMessage.value = e.response!.data;
           // toast(e.response!.data);
         }
         else {
           toast(e.toString());

         }
       }
     }
     return fetchLandDetailsModel!;
   }



    setLandDetailsFormData(index){
      stateType(landDetailsDataList[index].state!);
      totalLandAreaEditController.text=landDetailsDataList[index].totalLandArea!;
      pincodeEditController.text=landDetailsDataList[index].pinCode!;
      landAddressEditController.text=landDetailsDataList[index].landAddress!;
      areaInformationEditController.text=landDetailsDataList[index].areaInformation!;
      //patedarNoEditController.text=landDetailsDataList[index].pattedarNo!;
      khewatNoEditController.text=landDetailsDataList[index].khewatNo!;
      khataniNoEditController.text=landDetailsDataList[index].khatauniNo!;
      khasraNoEditController.text=landDetailsDataList[index].khasraNo!;
       pickFardFile=File(image_url+mediaUrl+landDetailsDataList[index].uploadFard!);
      pickPatedarDocumentFile=File(image_url+mediaUrl+landDetailsDataList[index].uploadPattedar!);

    if(districtList.isEmpty){
        if(districtData!.data!=null){
          if(districtData!.data!.district!.isNotEmpty){
            for (int i = 0; i < districtData!.data!.district!.length; i++) {
              districtList.insert(
                  i, districtData!.data!.district![i].districtName);
              districtIdList.insert(
                  i, districtData!.data!.district![i].districtId);
            }
          }
        }

    }
    if(districtIdList.isNotEmpty){
      var indexOfAppicant=districtIdList.indexOf(landDetailsDataList[index].districtId);
      districtType(districtList[indexOfAppicant]);
      selectDistrictIdFun(landDetailsDataList[index].districtId);
      selectDistrictSelectedIndexIdFun(districtList.indexOf(districtList[indexOfAppicant]));
      selectDistrictTypeIdFun(indexOfAppicant);
      getTehsilData(selectedDistrictIndex.value);
    }
    if(tehsilIdList.isNotEmpty){

      var indexOfAppicant=tehsilIdList.indexOf(landDetailsDataList[index].tehsilId);
      selectTehsilIdFun(landDetailsDataList[index].tehsilId);
      tehsilType(tehsilList[indexOfAppicant]);
      selectTehsilTypeIdFun(landDetailsDataList[index].tehsilId);
      selecttehsilSelectedIndexIdFun(tehsilList.indexOf(tehsilList[indexOfAppicant]));
      tehsilEditController.text=tehsilList[indexOfAppicant];
      getVillageData(selectedTehsilIndex.value,selectedDistrictIndex.value);
    }
    if(villageIdList.isNotEmpty){
      selectVillageTypeIdFun(landDetailsDataList[index].cityId);
      selectVillageId.value=landDetailsDataList[index].cityId as int;
      selectVillageIdFun(landDetailsDataList[index].cityId);
      var indexOfAppicant=villageIdList.indexOf(landDetailsDataList[index].cityId);

      villageEditController.text=villageList[indexOfAppicant];
    }
    update();
    // return districtData!;
  }

  changeExpansion(value){
    landAddressExpansion.value=value;
    update();
  }


  Future<DistrictModel> checkIsTodayVisit() async {
    var lastVisitDate =await localStorage.read(LocalStorageConstants().todayDateLand);


    var toDayDate = DateTime.now().day.toString(); // Here is you just get only date not Time.
    if (toDayDate==lastVisitDate) {
      var   districtData2=await  jsonDecode(localStorage.read(LocalStorageConstants().districtDataModel));
      districtData=DistrictModel.fromJson(districtData2);
      debugPrint("user visit again district data");

      if(districtList.isEmpty) {
        for (int i = 0; i < districtData!.data!.district!.length; i++) {
          districtList.insert(
              i, districtData!.data!.district![i].districtName);
          districtIdList.insert(
              i, districtData!.data!.district![i].districtId);
        }
      }
      return districtData!;
    }
    else {
      debugPrint("user visit first time district data");
      localStorage.write(LocalStorageConstants().todayDateLand,toDayDate);

      return getDistrictData();
    }
  }


  updateLandDetailsPostApiCall(index) async {
    try {
      var fardDoucmentMUltiPartFile;
      var patedarDocumentMultipartFile;
      if(isPickedFardFile.value==true){
        if (pickFardFile != null) {
          fardDoucmentMUltiPartFile =
          await MultipartFile.fromFile(pickFardFile!.path,
              filename: pickFardFile!.path);
        }
      }
      if(isPickedPatedarDocumentFile.value==true){
        if (pickPatedarDocumentFile != null) {
          patedarDocumentMultipartFile =
          await MultipartFile.fromFile(pickPatedarDocumentFile!.path,
              filename: pickPatedarDocumentFile!.path);
        }
      }
      var token=localStorage.read(LocalStorageConstants().token);
      var farmerID=await localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id:${farmerID} and token ${token}");

      var landDetailsData = AuthParams().landDetailsParam(
         landId: landDetailsDataList[index].id!,
        farmerid: farmerID,
        totalLandArea: totalLandAreaEditController.text.trim(),
        state: stateEditController.text.trim(),
        district:selectDistrictId.value,
        tehsil: selectTehsilId.value,
        city: selectVillageId.value,
        landAddress: landAddressEditController.text.trim(),
        pinCode: pincodeEditController.text.trim(),
        areaInformations: areaInformationEditController.text.trim(),
        pateDarNo: "",
        khasraNo: khasraNoEditController.text,
        khatauniNo: khataniNoEditController.text,
        khewatNumber: khewatNoEditController.text,
        uploadFard:isPickedFardFile.value?fardDoucmentMUltiPartFile:"" ,
        uploadPatedarDocument: isPickedPatedarDocumentFile.value?patedarDocumentMultipartFile:"",


      );
      isLoadingLandDetailsData.value=true;
      update();
      var response = await Dio().post(
          BASE_URL+landDetailsEnd,
          data: landDetailsData,
          options: Options(headers: httpsService!.headers)
      );

      if (response.statusCode == 200) {
        isLoadingLandDetailsData.value=false;
        update();
        addLandDetailsList.clear();
        extendLandDetailsForm.clear();
        landDetailsDataList.clear();

        fetchLandDetails();
          if(landDetailsDataList.isNotEmpty){
            setLandDetailsFormData(index);
          }

          toast(landUpdatedStr.tr);
          debugPrint("land  details response successfull${response.data}");
      }
    }
    catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);
        isLoadingLandDetailsData.value=false;
        update();
        updateLandDetailsErrorMessage.value = DioException.errorMessage!;
        debugPrint(" update land details  error${updateLandDetailsErrorMessage.value} ");
        toast(updateLandDetailsErrorMessage.value);
        updateLandDetailsErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          updateLandDetailsErrorMessage.value = e.response!.data;
          toast(e.response!.data);
        }
        else {
          isLoadingLandDetailsData.value=false;
          update();
        }
      }
      else{
        toast(e.toString());
      }
    }
  }


  deleteLandApiCall(landId,index)async {
    try {
      Response? response;
      isLoadingLandDetailsData.value=true;
      update();
       response = await Dio().get(BASE_URL + deleteLandEnd,
          queryParameters: {
            "land_id": landId,
          }, options: Options(headers: httpsService!.headers)
      );
      if(response.statusCode==200){
        debugPrint("delete successfully${response.data!}");
        isLoadingLandDetailsData.value=false;
        update();
        addLandDetailsList.clear();
        extendLandDetailsForm.clear();
        landDetailsDataList.clear();
        fetchLandDetails();
        if(landDetailsDataList.isNotEmpty){
          setLandDetailsFormData(index);
        }


      }

    }

    catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);
        isLoadingLandDetailsData.value=false;
        update();
        deleteErrorMessage.value = DioException.errorMessage!;
        debugPrint(" delete land details  error${deleteErrorMessage
            .value} ");
        toast(deleteErrorMessage.value);
        deleteErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          deleteErrorMessage.value = e.response!.data;
          toast(e.response!.data);
        }
        else {
          isLoadingLandDetailsData.value=false;
          update();
        }
      }
      else {
        toast(e.toString());
      }
    }
  }



}