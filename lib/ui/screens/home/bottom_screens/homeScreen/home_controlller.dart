import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:geocoding/geocoding.dart';
import '../../../../models/Playlist.dart';
import '../../../../models/features_schemes_model.dart';
import '../../../../models/mandi_price_model.dart';
import '../../../../models/weather_data_model.dart';
import '../../../../models/youtube_video_model.dart';
import '../../../../networks/dio/error_handling.dart';





class HomeController extends GetxController{
    MainScreenController? mainScreenController;
    WeatherDataModel? weatherModel;
    var address="".obs;
    // var lat=  30.9010.obs;
    // var long=75.8573.obs;
     var lat=   0.0.obs;
     var long=0.0.obs;
    var videoThumbnail;
    LocationPermission? permission;
    Future? futureWeatherData;
    List<DateTime> dateTimeList=[];
    var currentTimeLine=0.obs;

    var mandiApiCount=0;
     var videoApiCount=0;


    MandiPriceModel? mandiPriceModel;
    FeatureSchemesModel? featuresSchemesModel;

   var dateTimeListlocal;
    List<Playlist> playlists = [];
    Playlist? playList;
    List videosIds = [];
    VideosModel? videoModel;
    List videoThumbNail=[];
    List timeAgoList=[];
    List videoViews=[];



  var currentTime=DateTime.now();
    var district;
    HttpsService? httpsService;
     var imagesSchemes=[
       coldStorageIcon,
       nurseryIcon,
     ];

   var featuresSchemesErrorMessage="".obs;
   var mandiRateErrorMessage="".obs;
   var videoFeedErrorMessages="".obs;

   var featuresSchemesPublicSector=[];
   var featuresSchemesPrivateSector=[];

   var featuresSchemesBackImagePath=[];
   var costNormPrice=[];
   var mediaUrl;

  @override
  onInit() async {
     mainScreenController=Get.find<MainScreenController>();
     futureWeatherData=  locationsPermission();


    district=localStorage.read(LocalStorageConstants().userDistrict);
    httpsService=HttpsService();

    debugPrint("district is $district");
     List<Location> locations = await locationFromAddress(district);

     debugPrint("amritsar coodrinate is ${locations[0].latitude}");
     if(address.value==""){
      refreshScreen();
    }
    disableKeyboard();
    super.onInit();
  }

  refreshScreen(){
    update();
  }

  Future<WeatherDataModel>   locationsPermission() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat.value,long.value);
      Placemark place = placemarks[0];
      address.value = '${place.name} ${place.subLocality} ${place.locality},${place.subAdministrativeArea}';
      update();
       toast(pleaseEnableLocationsStr.tr);
       return checkIsTodayVisit();
    }
    permission =await Geolocator.requestPermission();
     if(permission==LocationPermission.always||permission==LocationPermission.whileInUse){
       // Permission.location.
       // Permission.location.serviceStatus.
        await  Geolocator.getCurrentPosition(
           desiredAccuracy: LocationAccuracy.high).then((value) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude,value.longitude);
      Placemark place = placemarks[0];
      lat.value=value.latitude;
      long.value=value.longitude;
      if(place.subLocality==null&&place.locality==null){
        address.value='${place.name},${place.subAdministrativeArea}';
        update();
        debugPrint("address is${place.toString()}");
      }
      else{
        debugPrint("address is${place.name},${place.subAdministrativeArea}");
        address.value = '${place.name} ${place.subLocality} ${place.locality},${place.subAdministrativeArea}';
        update();
      }
           });
         return checkIsTodayVisit();
     }
     if (permission == LocationPermission.denied) {
       permission =await Geolocator.requestPermission();

       debugPrint("district is $district");
       List<Location> locations = await locationFromAddress(district);
       debugPrint(" coodrinate is ${locations[0].latitude}");
       lat.value=locations[0].latitude;
       long.value=locations[0].longitude;
       List<Placemark> placemarks = await placemarkFromCoordinates(lat.value,long.value);
       Placemark place = placemarks[0];
       address.value = '${place.name} ${place.subLocality} ${place.locality},${place.subAdministrativeArea}';
         update();

      if (permission == LocationPermission.denied) {
         permission = await Geolocator.requestPermission();
        List<Placemark> placemarks = await placemarkFromCoordinates(lat.value,long.value);
        Placemark place = placemarks[0];


        if(place.subLocality==null&&place.locality==null){

          debugPrint("address is${place.name}");
          address.value='${place.name}';
          update();
        }
        else{
          debugPrint("address is${place.subLocality}, ${place.locality}");
          address.value = '${place.subLocality}, ${place.locality}';
          update();
        }

        return checkIsTodayVisit();
      }
      else {
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {

          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high).then((value) async {
            List<Placemark> placemarks = await placemarkFromCoordinates(
                value.latitude, value.longitude);

            Placemark place = placemarks[0];
             lat.value=value.latitude;
             long.value=value.longitude;

             if (place.subLocality == null && place.locality == null) {
              address.value = '${place.name},${place.subAdministrativeArea}';
              update();
              debugPrint("address is${place.toString()}");
            }
            else {
              debugPrint(
                  "address is${place.name},${place.subAdministrativeArea}");
              address.value =
              '${place.name} ${place.subLocality} ${place.locality},${place
                  .subAdministrativeArea}';
              update();
            }
          });
          return checkIsTodayVisit();
        }
      }
       return checkIsTodayVisit();
    }

    if (permission == LocationPermission.deniedForever) {
      // toast("allow permission");
      //  await openAppSettings().then((value) async {
      //    permissionServices();
      //  }
      //  );

      permission =await Geolocator.requestPermission();
    // var permission2=await Permission.location.request();
    List<Location> locations = await locationFromAddress(district);
    debugPrint(" coodrinate is ${locations[0].latitude}");
    lat.value=locations[0].latitude;
    long.value=locations[0].longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(
          lat.value, long.value);

      Placemark place = placemarks[0];
      address.value =
      '${place.name} ${place.subLocality} ${place.locality},${place
          .subAdministrativeArea}';
      update();
      return checkIsTodayVisit();
    }
    return checkIsTodayVisit();
  }





 Future<WeatherDataModel> getWeatherAPICall({lat ,long})async {
   WeatherDataModel? model;
   Map<String, dynamic> jsonMap = {
      'lat': lat,
      'lon': long,
      'appid': weatherApiKey,
      'units':weatherUnits
    };
    try{
      var response=  await Dio().get(weatherApiUrl,
        queryParameters:jsonMap,
      );
      if(response.statusCode==200){
        weatherModel=WeatherDataModel.fromJson(response.data);
        String user = jsonEncode(WeatherDataModel.fromJson(response.data));
        localStorage.write(LocalStorageConstants().weatherDataModel,user);
        model=weatherModel;
        fetchTimeLineList(weatherModel!.list!,currentTime);
        debugPrint("weather data is${response.data}");
      }
    }
    catch (e){
      if(e is DioError){
        // toast("${e.response!.data["message"]}");
      }
    }
    return model!;
  }

     Future<WeatherDataModel> checkIsTodayVisit() async {
     var lastVisitDate =await localStorage.read(LocalStorageConstants().todayDate);

   var toDayDate = DateTime.now().day.toString(); // Here is you just get only date not Time.
     if (toDayDate==lastVisitDate) {
    var   weatherData=await  jsonDecode(localStorage.read(LocalStorageConstants().weatherDataModel));
    weatherModel=WeatherDataModel.fromJson(weatherData);
       debugPrint("user visit again");
    dateTimeListlocal= localStorage.read(LocalStorageConstants().weatherDateList);
    fetchTimeLineList(weatherModel!.list!,currentTime);
    debugPrint("locations coordinate again ${lat.value},${long.value}");
    return weatherModel!;
     }
    else {
      debugPrint("user visit first time");
      localStorage.write(LocalStorageConstants().todayDate,toDayDate);
      debugPrint("locations coordinate first ${lat.value},${long.value}");
    return  getWeatherAPICall(lat:lat.value,long:long.value);
    }
  }

  Future<MandiPriceModel>  getMandiPriceApiCall()async{

     var districtName=Get.find<MainScreenController>().districtName;
     debugPrint("district name is $districtName");
      try{
        await Dio().get(BASE_URL+mandiPriceEnd,
          queryParameters:  {
            "market":"",
            "district":districtName==null?"":"$districtName",
            "commodity":"",
          },
          options: Options
            (headers: httpsService?.headers
          ),

        ).then((value){
          if(value.statusCode==200){
            mandiPriceModel=MandiPriceModel.fromJson(value.data);
            mandiApiCount++;
            debugPrint("count api mandi Rate${mandiApiCount.toString()}");
            debugPrint("mandi main price${value.data}");
            var token=localStorage.read(LocalStorageConstants().token);
          debugPrint("token$token");
          }
        });
      }
      catch (e){
        if(e is DioError){
          DioException.fromDioError(e);
          mandiRateErrorMessage.value=DioException.errorMessage!;
          debugPrint("video Error   error${mandiRateErrorMessage.value} ");
          mandiRateErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
          if(e.response!.statusCode==401){
               //toast(tokenExpiredStr.tr);
               localStorage.write(LocalStorageConstants().farmerUniqueId, "null");
            // Get.offAllNamed(Routes().loginScreen);
           // mandiRateErrorMessage.value=e.response!.data;

          }
        }
        else{
          mandiRateErrorMessage.value="Something went wrong";
        }
      }


    return  mandiPriceModel!;
    }

    fetchTimeLineList(list,currentTime){
    if(dateTimeListlocal!=null){
        final removedBrackets = dateTimeListlocal.substring(1, dateTimeListlocal.length - 1);
        final splitDate = removedBrackets.split(', ');
        debugPrint("date is length ${splitDate.length}");
        if(splitDate!=null){
          for(int i=0;i<splitDate.length;i++){
            var date=DateTime.parse(splitDate[i]);
            dateTimeList.insert(i, date);
          }
          debugPrint("date is local ${dateTimeList.length}");
        }
      }
      else{
        if(dateTimeList.isEmpty){
          for(int i=0;i<list.length;i++){
            var timeStamp=weatherModel!.list![i].dt;
            var date = DateTime.fromMillisecondsSinceEpoch(timeStamp! * 1000);
            dateTimeList.insert(i, date);
            debugPrint("date is list${dateTimeList[i]}");
          }
          localStorage.write(LocalStorageConstants().weatherDateList,dateTimeList.toString());

          dateTimeListlocal= localStorage.read(LocalStorageConstants().weatherDateList);
          debugPrint("date is$dateTimeListlocal");
        }
      }

      debugPrint("first date is${dateTimeList[0]}");
        for(int i=0;i<dateTimeList.length;i++){
          if(currentTime.compareTo(dateTimeList[i]) == 0){
            debugPrint("Both date time are at same moment.");
            currentTimeLine.value=i;
            update();
            debugPrint("current weather value first${  currentTimeLine.value}");
            break;
          }
          if(currentTime.isBefore(dateTimeList[i])){
            debugPrint("current  is before weather${dateTimeList[i]},$currentTime");
            currentTimeLine.value=i;
            update();
            debugPrint("current weather value${  currentTimeLine.value}");
            debugPrint("current  is before weather");
            break;
          }
          if(currentTime.isAfter(dateTimeList[i])){
            debugPrint("current is after weather");
          }
        }

      debugPrint("${dateTimeList.length}");
  }

    Future<FeatureSchemesModel> getFeaturesSchemesApiCall()async{
      try{
        await Dio().get(BASE_URL+featuredSchemesEnd,
          options: Options
            (headers: httpsService?.headers
          ),
        ).then((value){
          if(value.statusCode==200){
            featuresSchemesModel=FeatureSchemesModel.fromJson(value.data);
            if(featuresSchemesModel!=null){
              mediaUrl=featuresSchemesModel!.mediaUrl;
              localStorage.write(LocalStorageConstants().docUrl,  featuresSchemesModel!.docUrl);
            }
            for(int i=0;i<featuresSchemesModel!.schemes!.length;i++){
              featuresSchemesPrivateSector.insert(i, featuresSchemesModel!.schemes![i].privateRange);
              featuresSchemesPublicSector.insert(i, featuresSchemesModel!.schemes![i].publicRange);
              featuresSchemesBackImagePath.insert(i, image_url+ mediaUrl+featuresSchemesModel!.schemes![i].schemeImage!);
             var converter=viewsConverterCostNorm(double.parse(featuresSchemesModel!.schemes![i].costNorms!).round());
             debugPrint("cost norm$converter");
             costNormPrice.insert(i,converter);
            }
            debugPrint("features schemes data is${value.data}");
          }
        });
      }
      catch (e){
        if(e is DioError){
          DioException.fromDioError(e);
          featuresSchemesErrorMessage.value=DioException.errorMessage!;
          debugPrint("features schemes  error${featuresSchemesErrorMessage.value} ");
         featuresSchemesErrorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
          if(e.response!.statusCode==401){

          }
        }
        else{
          featuresSchemesErrorMessage.value="Something went wrong";

        }
      }
      return featuresSchemesModel!;
    }





    Future<VideosModel> fetchVideos() async{
      try{
        var response = await Dio().get(BASE_URL+fetchVideoEnd,
            options: Options(
                headers: httpsService!.headersGet)
        );
        if (response.statusCode == 200) {
          // debugPrint("video data is ${response.data}");
          videoModel=VideosModel.fromJson(response.data);
           videoApiCount++;
          // debugPrint("count api videos feed${videoApiCount.toString()}");
          for(int i=0;i<videoModel!.data!.data!.length;i++){
            videosIds.insert(i,videoModel!.data!.data![i].videoId);
            DateTime dt = DateTime.parse(videoModel!.data!.data![i].createdAt!);
            timeAgoList.insert(i, timeago.format(dt));

            videoThumbNail.insert(i,videoModel!.data!.data![i].thumbnail);
            // debugPrint("time ago is${timeago.format(dt)}");
            var formattedNumber =   viewsConverter(int.parse(videoModel!.data!.data![i].views!));
            // debugPrint("views ago is$formattedNumber");
            videoViews.insert(i,formattedNumber);
          }

        }
      }
      catch(e){
        if(e is DioError){
          DioException.fromDioError(e);
          videoFeedErrorMessages.value=DioException.errorMessage!;
          debugPrint("video Error   error${videoFeedErrorMessages.value} ");
          videoFeedErrorMessages.value=DioException.handleStatusCode(e.response!.statusCode);
          if(e.response!.statusCode==401){
             toast(tokenExpiredStr.tr);
           //  Get.offAllNamed(Routes().loginScreen);
          }
        }
        else{

                 videoFeedErrorMessages.value="Something went wrong";
        }
      }
      return videoModel!;
    }




    viewsConverter(num) {
      if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)}K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)}K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)}M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)}B";
      } else {
        return num.toString();
      }
    }

@override
  void onClose() {

    featuresSchemesPrivateSector.clear();
    featuresSchemesPublicSector.clear();
    // TODO: implement onClose
    super.onClose();
  }
}