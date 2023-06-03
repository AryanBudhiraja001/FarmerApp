import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';

import '../models/SchemesModel.dart';
import '../networks/dio/error_handling.dart';





class ExploreSchemeController extends GetxController {

  var applyFilterShow = false.obs;
  HttpsService? httpsService;
  SchemesModel? schemesModel;

  FilterComponentListModel? filterComponentModel;
  var currentPage=1.obs;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? countStartFrom;

  var schemesIDList=[];

  TextEditingController componentEditController=TextEditingController();
  TextEditingController subComponentEditController=TextEditingController();
  List<Scheme> schemesList = [];
    var costNorm=[];
  var schemesErrorMessages = "".obs;
  var componentErrorMessages = "".obs;
  var componentSelect = 0.obs;
  var componentIdSelect = 0.obs;
  var subComponentSelect = 0.obs;
  var subComponentIdSelect = 0.obs;
  var isLastPage=false.obs;
  Future<SchemesModel>? futureSchemesData;
  Future<FilterComponentListModel>? futureComponentData;
    var isLoadingSchemes=false.obs;


  componentSelectFromMenu(id,index) {
    componentIdSelect.value = id;
    componentSelect.value = index;
     componentEditController.text=componentNameList[index];

  }

  subComponentSelectFromMenu(id,index) {
    subComponentIdSelect.value = id;
    subComponentSelect.value = index;
    subComponentEditController.text=subComponentNameList[index];
  }

  String? title;
  ComponentData? componentData;
  int? componentId;
  List<Components> componentList = [];
  List componentNameList = [allStr,];
  List<SubComponent> subComponentList =[];
  List subComponentNameList = [allStr,];

  @override
  void onInit() {
    componentEditController.text=componentNameList[0];
    subComponentEditController.text=subComponentNameList[0];
    httpsService = HttpsService();
    componentData = Get.arguments;
    title = componentData!.subcategoryName;
    componentId = componentData!.id;
    futureSchemesData=fetchSchemesApiData();
    futureComponentData=fetchComponentApiData();
    debugPrint("id is ${componentData!.id}");
    getAppliedSchemesID();
    super.onInit();
  }

    refreshFilterView(){
    update(["filter"]);
    }

  getAppliedSchemesID(){
    var schemesIDList2=localStorage.read(LocalStorageConstants().schemesIdList);
   if(schemesIDList2!=null){
     var schemesList=   json.decode(schemesIDList2);
     for(int i=0;i<schemesList.length;i++){
       schemesIDList.insert(i, schemesList[i]);
     }

   }


  }
  showApplyFilter() {
    applyFilterShow.value = !applyFilterShow.value;
    update();
  }

  refreshScreen(){
    update(["schemes"]);
  }

  goToNextPage(){
    if(currentPage.value!=totalPages){
      currentPage.value++;
      fetchSchemesApiData();
    }
  }
  goToPreviousPage(){
    if(currentPage.value!=1){
      currentPage.value--;
      fetchSchemesApiData();
    }
  }

  goToPageClicked(pageNumber){
    currentPage.value=pageNumber;
    fetchSchemesApiData();
  }

Future<SchemesModel>  fetchSchemesApiData()async {
    try {
      isLoadingSchemes.value=true;
      refreshScreen();
      var response = await Dio().get(
          BASE_URL + fetchSchemesFilterEnd,
        options: Options(
            headers: httpsService!.headersGet
        ),
          queryParameters: {
            "id": componentId,
            "component_id":componentIdSelect.value,
            "subcomponent_id": subComponentIdSelect.value,
             "page":currentPage.value
            },

      );
      if (response.statusCode == 200) {
        isLoadingSchemes.value=false;
        refreshScreen();
        schemesModel = SchemesModel.fromJson(response.data);
        debugPrint("schemes data is ${response.data}");
        debugPrint("schemes    id $componentId,  component id${componentIdSelect.value},sub componet id ${subComponentIdSelect.value}");

        localStorage.write(LocalStorageConstants().imageUrl, schemesModel!.mediaUrl);
        localStorage.write(LocalStorageConstants().docUrl,  schemesModel!.docUrl);

        var imageUrl= localStorage.read(LocalStorageConstants().imageUrl);
        var docUrl= localStorage.read(LocalStorageConstants().docUrl);
        countStartFrom=schemesModel!.schemes!.from;
        totalPages=schemesModel!.schemes!.lastPage;
        debugPrint("image url$imageUrl  docUrl is $docUrl");
        if(schemesModel!.schemes!.data!=null){
          schemesList.clear();
          for (int i = 0; i < schemesModel!.schemes!.data!.length; i++) {
            schemesList.insert(i, schemesModel!.schemes!.data![i]);
            var converter=viewsConverterCostNorm(double.parse(schemesModel!.schemes!.data![i].costNorms!).round());
            debugPrint("cost norm$converter");
            costNorm.insert(i,converter);
          }
        }

      }
    }
    catch (e) {
      isLoadingSchemes.value=false;
      refreshScreen();
      if (e is DioError) {
        DioException.fromDioError(e);
        schemesErrorMessages.value = DioException.errorMessage!;
        debugPrint("schemes  error${schemesErrorMessages.value} ");
        schemesErrorMessages.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {

        }
        else {

        }
      }
      else {
        schemesErrorMessages.value = "Data not processes";
      }
    }
    return schemesModel!;
  }

  Future<FilterComponentListModel> fetchComponentApiData()async {
    try {
      var response = await Dio().get(
          BASE_URL + fetchComponentListEnd,
          queryParameters: {
            "id": componentId,
          },
          options: Options(
              headers: httpsService!.headersGet
          )
      );
      if (response.statusCode == 200) {
        filterComponentModel = FilterComponentListModel.fromJson(response.data);
         if(filterComponentModel!.components!=null){
           for(int i=0;i<filterComponentModel!.components!.length;i++){
             componentList.insert(i, filterComponentModel!.components![i]);
           }
         }
       if(componentList.isNotEmpty){
         for(int i=0;i<componentList.length;i++){
           componentNameList.insert(i+1, componentList[i].componentName);
         }
       }


        debugPrint("component list is ${filterComponentModel.toString()}");

      }
    }
    catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);
        componentErrorMessages.value = DioException.errorMessage!;
        debugPrint("category  error${componentErrorMessages.value} ");
        componentErrorMessages.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          componentErrorMessages.value = e.response!.data;
        }
        else {

        }
      }
      else {
        componentErrorMessages.value =e.toString();
      }
    }

    return  filterComponentModel!;
  }

   getSubComponentList(selectedComponentIndex){
    if(componentList.isNotEmpty){
      for(int i=0;i<componentList[selectedComponentIndex].subComponent!.length;i++){
        subComponentList.insert(i,componentList[selectedComponentIndex].subComponent![i]);
         }
       }
      if(subComponentList.isNotEmpty){
        for(int i=0;i<subComponentList.length;i++){
            subComponentNameList.insert(i+1, subComponentList[i].subComponentName);
          }
      }

    subComponentSelectFromMenu(0,0);
  //  componentEditController.text=subComponentNameList[0];
    refreshFilterView();
     }

  @override
  void onClose() {
    componentList.clear();
    subComponentList.clear();
    super.onClose();
  }
}