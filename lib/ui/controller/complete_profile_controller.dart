
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/database/shared_pred.dart';
import 'package:farmer_app/ui/models/profile_data_model.dart';

import '../networks/dio/HttpService.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';

class CompleteProfileController extends GetxController{
  final formKey = GlobalKey<FormState>();

  HttpsService? httpsService;
  TextEditingController stateController=TextEditingController();
  TextEditingController districtController=TextEditingController();
  TextEditingController tehsilController=TextEditingController();
  TextEditingController villageController=TextEditingController();
  TextEditingController fullAddressController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();

  var selectDistrictId=0.obs;
    var selectTehsilId=0.obs;
    var selectVillageId=0.obs;
    var loadingProfileData=false.obs;
    var isLoadingData=false.obs;
  var errorMessage="".obs;
    ProfileDataModel? profileData;

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



  late FarmerProfileController farmerProfileController;


  @override
  void onInit() {
    farmerProfileController = Get.find<FarmerProfileController>();
    farmerProfileController.getTehsilData(0);
    farmerProfileController.getVillageData(0,0);
    httpsService=HttpsService();
    super.onInit();
  }

  void stateType(String value) {

    stateController.text=value;
    update();
  }

  void districtType(String value) {
    districtController.text=value;
    update();
  }




     postProfileData()async{
     try{
       var multipartImage;
       String fileName =farmerProfileController.pickedImage!.path.split('/').last;
       multipartImage=  await MultipartFile.fromFile(farmerProfileController.pickedImage!.path,
           filename:fileName);
       var userId=localStorage.read(LocalStorageConstants().userId);
       var token=localStorage.read(LocalStorageConstants().token);
       debugPrint("token is $token");
       isLoadingData.value=true;
       update();
       var response= await Dio().post(BASE_URL+profileUpdateEnd,
           options: Options(
             headers:httpsService!.headers,
           ),
           data: AuthParams().profileUpdateData(
               userId:userId,
               applicantTypeId:
               farmerProfileController.selectAppicantTypeId.value,
               applicantName: farmerProfileController.applicantNameController.text.trim(),
               fatherName:farmerProfileController.applicantFatherNameController.text.trim(),
               gender: farmerProfileController.genderController.text.trim(),
               residence: farmerProfileController.residentController.text.trim(),
               aadhaarNumber: farmerProfileController.aadhaarNoController.text.trim(),
               panNumber:"",
               casteCategoryIdValue: farmerProfileController.selectCategoryTypeId.value,
               state:  stateController.text.trim(),
               district:selectDistrictId.value,
               tehsil: selectTehsilId.value,
               city: selectVillageId.value,
               fullAddress: fullAddressController.text.trim(),
               postalCode: pincodeController.text.trim(),
               image:await multipartImage
           )
       );

       if(response.statusCode==200){
         isLoadingData.value=false;
         update();
         profileData=ProfileDataModel.fromJson(response.data);
         localStorage.write(LocalStorageConstants().userId, profileData!.data!.userId);
         localStorage.write(LocalStorageConstants().farmerUniqueId, profileData!.farmerUniqueId);
         debugPrint("profile data is ${response.data}");
         toast(profileData!.message);
         debugPrint("district is${districtController.text}");
         localStorage.write(LocalStorageConstants().userDistrict,districtController.text);

         var district =   localStorage.read(LocalStorageConstants().userDistrict);
         debugPrint("district saved  is$district");
         Get.offAllNamed(Routes().mainScreen);
       }
     }
     catch (e) {
       if (e is DioError) {
         DioException.fromDioError(e);
         isLoadingData.value=false;
         update();
         errorMessage.value = DioException.errorMessage!;
         debugPrint("video feed error${errorMessage.value} ");
         toast(errorMessage.value);
         errorMessage.value =
             DioException.handleStatusCode(e.response!.statusCode);
         if (e.response!.statusCode == 401) {
           errorMessage.value = e.response!.data;
           toast(e.response!.data);
         }
         else {
           isLoadingData.value=false;
           update();
         }
       }
       else{
         toast("cause of error is $e");
       }
     }
  }


@override
  void onClose() {
  isLoadingData.value=false;
    super.onClose();
  }


}