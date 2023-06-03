import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import 'package:farmer_app/ui/models/profile_data_model.dart';
import 'package:flutter/foundation.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';

class UpdateProfileInfoController extends GetxController {
  DistrictModel? districtData;
  var applicantName = [];
  var applicantId = [];
  var casteCategory = [];
  var casteCategoryId = [];
  final formKey = GlobalKey<FormState>();
  List<District> district = [];
var errorMessage="".obs;
  var genderList = [maleStr, femaleStr,othersStr];
  var residentList = [indianStr];

  var stateList = [punjabStr];

  var selectAppicantTypeId = 0.obs;
  var selectCategoryTypeId = 0.obs;
  HttpsService? httpsService;
  var isLoadingData=false.obs;

  Future<ProfileDataModel?>? future;
  TextEditingController applicantTypeController = TextEditingController();
  TextEditingController applicantNameController = TextEditingController();
  TextEditingController applicantFatherNameController = TextEditingController();
  TextEditingController applicantGrandFatherNameController =
      TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController aadhaarNoController = TextEditingController();
 // TextEditingController panNoController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController residentController = TextEditingController();
  FocusNode? applicantTypeFocusNode = FocusNode();

  ProfileDataModel? profileData;
  File? pickedImage;
  MultipartFile? multipartImage;

  var districtApiErrorMessage="".obs;
  @override
  void onInit() {
    httpsService = HttpsService();
    future = getProfileData();

    super.onInit();
  }

  pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);


      pickedImage = imageTemp;
      update(['image']);
        multipartImage = await MultipartFile.fromFile(pickedImage!.path,
          filename: pickedImage!.path);
      if (kDebugMode) {
        debugPrint('picked image: $pickedImage');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to pick image: $e');
      }
    }
  }

  pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      pickedImage = File(image.path);

      update(['image']);

      multipartImage = await MultipartFile.fromFile(pickedImage!.path,
          filename: pickedImage!.path);
      if (kDebugMode) {
        debugPrint(' picked image: $pickedImage');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to pick image: $e');
      }
    }
  }

  void applicantType(String choice3) {
    if (applicantName.isNotEmpty) {
      applicantTypeController.text = applicantName[0];
    }
    applicantTypeController.text = choice3;
    update();
  }

  void genderType(String value) {
    if (genderList.isNotEmpty) {
      genderController.text = genderList[0];
    }
    genderController.text = value;
    update();
  }

  void residentType(String value) {
    if (residentList.isNotEmpty) {
      residentController.text = residentList[0];
    }
    residentController.text = value;
    update();
  }

  void casteType(String value) {
    if (casteCategory.isNotEmpty) {
      casteController.text =casteCategory[0];
    }
    casteController.text = value;
    update();
  }

  selectAppicateTypeIdFun(value) {
    selectAppicantTypeId.value = value;
    update();
  }

  selectCategoryTypeIdFun(value) {
    selectCategoryTypeId.value = value;
    update();
  }


  Future<ProfileDataModel?> getProfileData() async {
    Response? response;
   try{
     var userId = localStorage.read(LocalStorageConstants().userId);
     response = await Dio().get(BASE_URL+fetchProfileEnd,
         queryParameters: {"user_id": userId},
         options: Options(headers: httpsService?.headers));
     if (response.statusCode == 200) {
       debugPrint("profile data ${response.data}");
       profileData = ProfileDataModel.fromJson(response.data);
       if (profileData != null) {
         selectAppicateTypeIdFun(profileData!.data!.applicantTypeId);
         selectCategoryTypeIdFun(profileData!.data!.casteCategoryId);
         applicantNameController.text = profileData!.data!.name!;
         applicantFatherNameController.text = profileData!.data!.fatherHusbandName!;
         genderController.text = profileData!.data!.gender!;
         residentController.text = profileData!.data!.resident!;
         aadhaarNoController.text = profileData!.data!.aadharNumber!;
         mobileNumberController.text = profileData!.data!.mobileNumber!;
         getDistrictData();
       }
     }
   }
   catch(e){
     if(e is DioError){
       DioException.fromDioError(e);
       errorMessage.value=DioException.errorMessage!;
       debugPrint("profile update error is${errorMessage.value} ");
       errorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
       if(e.response!.statusCode==401){
         errorMessage.value=e.response!.data;
         // toast(e.response!.data);
       }
       if(e.response!.statusCode==429){
         update();
       }

     }}
   return profileData!;
  }

  Future<DistrictModel> getDistrictData() async {
    Response? response;
    try {
      response = await Dio().get(BASE_URL+districtEnd,
          options: Options(headers: httpsService?.headers));
      if (response.statusCode == 200) {
        districtData = DistrictModel.fromJson(response.data);
        if (applicantName.isEmpty) {
          for (int i = 0; i < districtData!.data!.applicantType!.length; i++) {
            applicantName.insert(
                i, districtData!.data!.applicantType![i].applicantTypeName);
            applicantId.insert(i, districtData!.data!.applicantType![i].id);
          }
        }

        if (applicantId.isNotEmpty) {
          var indexOfAppicant = applicantId.indexOf(profileData!.data!.applicantTypeId);
          applicantTypeController.text = applicantName[indexOfAppicant];
          applicantType(applicantName[indexOfAppicant]);
        }
        if (casteCategory.isEmpty) {
          for (int i = 0; i < districtData!.data!.casteCategory!.length; i++) {
            casteCategory.insert(
                i, districtData!.data!.casteCategory![i].casteName);
            casteCategoryId.insert(i, districtData!.data!.casteCategory![i].id);
          }

          if (casteCategoryId.isNotEmpty) {
            var indexOfAppicant =
                casteCategoryId.indexOf(profileData!.data!.casteCategoryId);
            casteController.text = casteCategory[indexOfAppicant];
            casteType(casteCategory[indexOfAppicant]);
          }
        }

        update();
      } else {
        debugPrint("there is something wrong${response.statusCode.toString()}");
      }
    }
    catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);

        districtApiErrorMessage.value = DioException.errorMessage!;
        debugPrint("district api error${districtApiErrorMessage.value} ");
        toast(districtApiErrorMessage.value);
        districtApiErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          toast(e.response!.data);
          //Get.offNamed(Routes().loginScreen);
          districtApiErrorMessage.value = e.response!.data;

        }
        else {

        }
      }
      else{
        toast(e.toString());
      }
    }
    return districtData!;
  }

  updateProfileData() async {
    var userid=localStorage.read(LocalStorageConstants().userId);
    var authBody = AuthParams().updateProfileUpdateData(
        userId:userid ,
        applicantTypeId: selectAppicantTypeId.value,
        applicantName: applicantNameController.text.trim(),
        fatherName: applicantFatherNameController.text.trim(),
        gender: genderController.text.trim(),
        residence: residentController.text.trim(),
        aadhaarNumber: aadhaarNoController.text.trim(),
        panNumber:"",
        casteCategoryIdValue: selectAppicantTypeId.value,
        image: multipartImage);
    try{
      isLoadingData.value=true;
      update();
   var response=   await Dio()
          .post(BASE_URL + updateProfileEnd,
          options: Options(
            headers: httpsService?.headers,
          ),
          data: authBody);
     if(response.statusCode==200){
       isLoadingData.value=false;
       update();
       profileData = ProfileDataModel.fromJson(response.data);
       debugPrint("profile uploaded data${response.data}");
       toast(profileData!.message);
     }
    }
    catch(e){
      if(e is DioError){
        isLoadingData.value=false;
        update();
        DioException.fromDioError(e);
        errorMessage.value=DioException.errorMessage!;
        debugPrint("profile update error is${errorMessage.value} ");
        errorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        toast(errorMessage.value);
        if(e.response!.statusCode==401){
          errorMessage.value=e.response!.data;
           toast(errorMessage.value);
        }
        else{
          isLoadingData.value=false;
          update();
        }
      }

    }


  }


  @override
  void onClose() {
     pickedImage=="";
    super.onClose();
  }
}
