import 'package:farmer_app/ui/constants/exports.dart';
import 'package:dio/dio.dart';
import 'package:farmer_app/ui/models/profile_data_model.dart';
import '../networks/dio/api_params.dart';
import '../networks/dio/error_handling.dart';

  class UpdateAddressController extends GetxController{
    static UpdateAddressController get i => Get.find();
  final formKey = GlobalKey<FormState>();
  HttpsService? httpsService;
var isLoadingData=false.obs;
    Future<DistrictModel>?farmerAddressfuture;
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
    var  districtList=[];
    var  districtIdList=[];
    var  tehsilList=[];
    var  tehsilIdList=[];
    var  villageList=[];
    var  villageIdList=[];

   var selectDistrictTypeId=0.obs;
   var selectTehsilTypeId=0.obs;
   var selectVillageTypeId=0.obs;
   var selectedDistrictIndex=0.obs;
   var selectedTehsilIndex=0.obs;
   ProfileDataModel? profileData;
   DistrictModel? districtData;


    var errorMessage="".obs;
  void selectDistrictIdFun(var value){
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

  late UpdateProfileInfoController updateProfileInfoController;

  @override
  void onInit() {
        updateProfileInfoController=Get.put(UpdateProfileInfoController());
        updateProfileInfoController= Get.find<UpdateProfileInfoController>();
        farmerAddressfuture= setData();
  httpsService=HttpsService();
  super.onInit();
  }

    Future<DistrictModel> setData()async{
      profileData=await updateProfileInfoController.getProfileData();
     districtData= await updateProfileInfoController.getDistrictData();
     if(districtList.isEmpty){
        if(districtData!.data!.district!.isNotEmpty){
          for (int i = 0; i < districtData!.data!.district!.length; i++) {
            districtList.insert(
                i, districtData!.data!.district![i].districtName);
            districtIdList.insert(
                i, districtData!.data!.district![i].districtId);
          }
        }
     }
     debugPrint(profileData.toString());
     stateType(profileData!.data!.state!);
     fullAddressController.text=profileData!.data!.fullAddress!;
     pincodeController.text=profileData!.data!.pinCode!;
     if(districtIdList.isNotEmpty){
      var indexOfAppicant=districtIdList.indexOf(profileData!.data!.districtId);
      districtType(districtList[indexOfAppicant]);
      selectDistrictIdFun(profileData!.data!.districtId);

      selectDistrictSelectedIndexIdFun(districtList.indexOf(districtList[indexOfAppicant]));
      selectDistrictTypeIdFun(indexOfAppicant);
      getTehsilData(selectedDistrictIndex.value);
    }
    if(tehsilIdList.isNotEmpty){
      var indexOfAppicant=tehsilIdList.indexOf(profileData!.data!.tehsilId);

       selectTehsilIdFun(profileData!.data!.tehsilId);
      tehsilType(tehsilList[indexOfAppicant]);

      selectTehsilTypeIdFun(profileData!.data!.tehsilId);
      selecttehsilSelectedIndexIdFun(tehsilList.indexOf(tehsilList[indexOfAppicant]));
      tehsilController.text=tehsilList[indexOfAppicant];
      getVillageData(selectedTehsilIndex.value,selectedDistrictIndex.value);
    }

     if(villageIdList.isNotEmpty){
       selectVillageTypeIdFun(profileData!.data!.cityId);
       selectVillageId.value=profileData!.data!.cityId as int;
       selectVillageIdFun(profileData!.data!.cityId);
       var indexOfAppicant=villageIdList.indexOf(profileData!.data!.cityId);
       villageController.text=villageList[indexOfAppicant];
     }
     update();
 return districtData!;
  }



  void stateType(String value) {
    stateController.text=value;
  update();
  }

  void districtType(String value) {
  districtController.text=value;
  update();
  }
    void tehsilType(String value) {
      tehsilController.text=value;
      update();
    }
    void villageType(String value) {
      villageController.text=value;
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

  postUpdateAddressData()async{
   var userid= localStorage.read(LocalStorageConstants().userId);
   debugPrint("user id$userid");
   isLoadingData.value=true;
  update();
    try{
      await Dio().post(BASE_URL+updateAddressEnd,
          options: Options(
            headers:httpsService?.headers,
          ),
          data: AuthParams().addressUpdateData(
            userId: userid,
            state:  stateController.text.trim(),
            district:selectDistrictId.value,
            tehsil: selectTehsilId.value,
            city: selectVillageId.value,
            fullAddress: fullAddressController.text.trim(),
            postalCode: pincodeController.text.trim(),
          )
      ).then((value) {
        isLoadingData.value=false;
        update();
        profileData=ProfileDataModel.fromJson(value.data);
        localStorage.write(LocalStorageConstants().userId, profileData!.data!.userId);
        localStorage.write(LocalStorageConstants().userDistrict,districtController.text);
        debugPrint(value.toString());
        toast(profileData!.message);


      });
    }
    catch (e){
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
          for (int i = 0; i < districtData!.data!.district![index].tehsil!.length; i++) {
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

