import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileController extends GetxController{
  var fileUrl;

  double progress = 0.0;
   String fileName = "TV.jpg";
  String? downloadingProgress;
  var filePath;

   @override
   onInit(){
     // startDownloading();


     super.onInit();
   }







}