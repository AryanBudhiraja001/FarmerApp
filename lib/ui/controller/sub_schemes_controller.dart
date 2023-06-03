import 'package:farmer_app/ui/constants/exports.dart';


import '../models/SchemesModel.dart';
import '../models/schemes_category_model.dart';


class SubSchemesController extends GetxController{
  SchemesCategoryModel? schemesSubCategory;
  List<Cat> subSchemesList=[];

 var title;
  @override
  void onInit() {

    schemesSubCategory=Get.arguments;


    title=schemesSubCategory!.govtSchemeCatName;
    getSubCategoryList();

    super.onInit();
  }




     getSubCategoryList(){
       if(schemesSubCategory!=null){
         for(int i=0;i<schemesSubCategory!.cat!.length;i++){
           subSchemesList.insert(i, schemesSubCategory!.cat![i]);

         }
       }


     }



  @override
  void onClose() {
     subSchemesList.clear();
    super.onClose();
  }

}