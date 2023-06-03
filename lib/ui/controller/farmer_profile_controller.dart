import 'dart:convert';
import 'dart:io';
import 'dart:math';



import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/foundation.dart';


import '../networks/dio/HttpService.dart';



class FarmerProfileController extends GetxController{
  File? pickedImage;
  DistrictModel? districtData;
  var  applicantName=[];
 var  applicantId=[];
 var  casteCategory=[];
  var  casteCategoryId=[];
  var  districtList=[];
  var  districtIdList=[];
  var  tehsilList=[];
  var  tehsilIdList=[];
  var  villageList=[];
  var  villageIdList=[];
  var  selectAppicantTypeId=0.obs;
  var  selectCategoryTypeId=0.obs;
  var  selectDistrictTypeId=0.obs;
  var  selectTehsilTypeId=0.obs;
  var  selectVillageTypeId=0.obs;

  List<District> district=[];



  var genderList=[
    maleStr,
    femaleStr,
    othersStr
  ];
  var residentList=[
    indianStr
  ];

  var stateList=[
    punjabStr
  ];
    var selectedDistrictIndex=0.obs;
    var selectedTehsilIndex=0.obs;
    var selectedVillageIndex=0.obs;


 HttpsService? httpsService;
 var loadingData=false.obs;
  Future<DistrictModel>? future;
  final formKey = GlobalKey<FormState>();
  TextEditingController? applicantTypeController=TextEditingController();
  TextEditingController applicantNameController=TextEditingController();
  TextEditingController applicantFatherNameController=TextEditingController();
  TextEditingController applicantGrandFatherNameController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  TextEditingController aadhaarNoController=TextEditingController();
 // TextEditingController panNoController=TextEditingController();
  TextEditingController mobileNumberController=TextEditingController();
  TextEditingController casteController=TextEditingController();
  TextEditingController residentController=TextEditingController();
  FocusNode? applicantTypeFocusNode=FocusNode();
  @override
  void onInit() {
    super.onInit();
    httpsService=HttpsService();
    future=getProfileData();

    mobileNumberController.text=Get.arguments;

  }

  pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
     pickedImage = imageTemp;
      update(['image']);
      if (kDebugMode) {
        print('Failed to pick image: $pickedImage');
      }
    } on PlatformException catch(e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      pickedImage=File(image.path);
      update(['image']);
      if (kDebugMode) {
        print('Failed to pick image: $pickedImage');
      }
    } on PlatformException catch(e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  void applicantType(String choice3) {
     if(applicantName.isNotEmpty){
       applicantTypeController?.text=applicantName[0];
     }

    applicantTypeController?.text=choice3;
    update();
    }
    void genderType(String value) {
      if(genderList.isNotEmpty){
        genderController.text=genderList[0];
      }
    genderController.text=value;
    update();
  }

  void residentType(String value) {
    if(residentList.isNotEmpty){
      residentController.text=residentList[0];
    }
    residentController.text=value;
    update();
  }


   void casteType(String value) {
     if(casteCategory.isNotEmpty){
       casteController.text=casteCategory[0];
     }
    casteController.text = value;
    update();
  }

  selectAppicateTypeIdFun(value){
    selectAppicantTypeId.value=value;
    update();
  }

  selectCategoryTypeIdFun(value){
    selectCategoryTypeId.value=value;
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


  Future<DistrictModel> getProfileData()async{
        Response? response;

        try{
          response=await Dio().get(
              BASE_URL+districtEnd,
              options: Options(
                  headers: httpsService?.headers)
          );
          loadingData.value=false;
    if(response.statusCode==200){
       debugPrint("district data is ${response.data}");
       var model=DistrictModel.fromJson(response.data);
       districtData=model;
     if(applicantName.isEmpty){
         for(int i=0;i<districtData!.data!.applicantType!.length;i++){
          applicantName.insert(i,districtData!.data!.applicantType![i].applicantTypeName);
          applicantId.insert(i,districtData!.data!.applicantType![i].id);
         }
       }

       if(casteCategory.isEmpty){
         for(int i=0;i<districtData!.data!.casteCategory!.length;i++){
           casteCategory.insert(i,districtData!.data!.casteCategory![i].casteName);
           casteCategoryId.insert(i,districtData!.data!.casteCategory![i].id);
         }
       }

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
            // EasyLoading.dismiss();
            debugPrint("error is${e.response.toString()}");
            // toast("${e.response!.data["message"]}");
          }
        }

      return districtData!;
  }



  selectDistrictSelectedIndexIdFun(value){
    selectedDistrictIndex.value=value;
    update();
  }
  selecttehsilSelectedIndexIdFun(value){
    selectedTehsilIndex.value=value;
    update();
  }

      getTehsilData(int index){
        if(districtList.isNotEmpty){
          if(tehsilList.isEmpty) {
            for (int i = 0; i <
                districtData!.data!.district![index].tehsil!.length; i++) {
              tehsilList.insert(
                  i,  districtData!.data!.district![index].tehsil![i].tehsilName);
              tehsilIdList.insert(
                  i,districtData!.data!.district![index].tehsil![i].tehsilId);
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

    }
  }







}