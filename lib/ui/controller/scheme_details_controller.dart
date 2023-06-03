import 'package:farmer_app/ui/constants/exports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/SchemesModel.dart';




class SchemesDetailsController extends GetxController{

var termsExpansion=false.obs;
var detailsExpansion=false.obs;
var videosExpansion=false.obs;
var selectedIndex=0.obs;
Scheme? scheme;
var costNorm;
var index;

  var selectedTile = 0.obs;

 List<Terms> terms=[];
 List<Video> video=[];

final List<String> ids = [];

@override
void onInit() {
  scheme=Get.arguments;
  costNorm=viewsConverterCostNorm(double.parse(scheme!.costNorms!).round());
  debugPrint("cost norm$costNorm");

  localStorage.write(LocalStorageConstants().selectedSector, selectedIndex.value);

  var saveValue=localStorage.read(LocalStorageConstants().selectedSector);
  debugPrint("selected Sector is ${saveValue.toString()}");
  getRequiredDocumentList();
  getIds();

  super.onInit();
}

   selectedSubsidySector(index){
     selectedIndex.value=index;
     update();
   }

  getRequiredDocumentList(){
    if(scheme!=null){
    for(int i=0;i<scheme!.terms!.length;i++){
      terms.insert(i,scheme!.terms![i]);
    }
    for(int i=0;i<scheme!.video!.length;i++){
      video.insert(i,scheme!.video![i]);
    }
    getIds();
     }



  }



  getIds(){
    if(scheme!.video!.isNotEmpty){
          for(int i=0;i<scheme!.video!.length;i++){

            try {
              var id=     YoutubePlayer.convertUrlToId("${scheme!.video![i].video}");
              if(id!=null){
                ids.insert(i, id);
                debugPrint('this is video ids ${ids[i]}');
              }

            } on Exception catch (exception) {

              // only executed if error is of type Exception
              debugPrint('exception');

            } catch (error) {

              // executed for errors of all types other than Exception
              debugPrint('catch error');
              //  videoIdd="error";
            }
          }

        }
}






@override
void dispose() {
  ids.clear();
  super.dispose();
}



  updateTerms(value){
  termsExpansion.value=value;
  if(value){
    selectedTile.value=1;
  }
  else{
    selectedTile.value=0;
  }
   update(["requiredDocuments"]);
}

updateDetails(value){
  detailsExpansion.value=value;
  if(value){
    selectedTile.value=2;
  }
  else{
    selectedTile.value=0;
  }
   update(["Details"]);
}

updateVideos(value){
  videosExpansion.value=value;
  if(value){
    selectedTile.value=3;
  }
  else{
    selectedTile.value=0;
  }
   update(["Video"]);
}


}