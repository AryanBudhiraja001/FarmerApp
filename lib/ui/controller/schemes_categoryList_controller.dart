import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/schemes_category_model.dart';
import '../networks/dio/error_handling.dart';

class SchemesCategoryListController extends GetxController{


  Cat? schemesCategory;
   HttpsService? httpService;
  ComponentModel? componentModel;
  var isLoadingData=false.obs;
  Future<ComponentModel>? futureComponent;
  var fetchComponentErrorMessage="".obs;
   SubSchemesController? subSchemesController;
  var title;

  var currentPage=1.obs;
  int? totalPages;
    int? nextPage;
  int? previousPage;
  int? countStartFrom;
  List<ComponentData> componentList=[];
  @override
  void onInit() {
    subSchemesController=Get.find<SubSchemesController>();

    schemesCategory=Get.arguments;
    title=schemesCategory!.schemeCatName;
    httpService=HttpsService();
    futureComponent=fetchComponentApi();
    super.onInit();
  }



     goToNextPage(){
        if(currentPage.value!=totalPages){
          currentPage.value++;
          fetchComponentApi();

        }
      }
  goToPreviousPage(){
    if(currentPage.value!=1){
      currentPage.value--;
      fetchComponentApi();

    }
  }


 Future<ComponentModel>fetchComponentApi()async{
       try{
         isLoadingData.value=true;
         update();
         debugPrint("component id is $schemesCategory");
         var response=await Dio().get(
           BASE_URL+fetchComponentTypesEnd,
           queryParameters: {
             "id":schemesCategory!.schemeCatId,
             "page":currentPage.value,
           },
           options: Options(
             headers: httpService!.headersGet
           )
         );
         if(response.statusCode==200){
           componentModel=ComponentModel.fromJson(response.data);
           componentList.clear();
           isLoadingData.value=false;
           update();
           for(int i=0;i<componentModel!.componentTypes!.data!.length;i++){
              componentList.insert(i, componentModel!.componentTypes!.data![i]);
           }
           countStartFrom=componentModel!.componentTypes!.from;
           totalPages=componentModel!.componentTypes!.lastPage;
           debugPrint("component Data is ${response.data}");
           update();
         }
       }

       catch(e){
         if (e is DioError) {
           isLoadingData.value=false;
           update();
           DioException.fromDioError(e);
           fetchComponentErrorMessage.value = DioException.errorMessage!;
           debugPrint("land details  error${fetchComponentErrorMessage.value} ");
           toast(fetchComponentErrorMessage.value);
           fetchComponentErrorMessage.value =
               DioException.handleStatusCode(e.response!.statusCode);
           if (e.response!.statusCode == 401) {
             fetchComponentErrorMessage.value = e.response!.data;
             toast(e.response!.data);
           }
           else {

           }
         }
         else{
           isLoadingData.value=false;
           update();
         }
       }

       return  componentModel!;
   }
}