import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/networks/dio/api_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import '../models/SchemesModel.dart';
import '../models/applied_schemes_message_model.dart';
import '../models/download_pdf_model.dart';
import '../models/fetch_land_details_model.dart';

import '../models/schmes_status_model.dart';
import '../networks/dio/error_handling.dart';

class UploadDocumentController extends GetxController {
  late bool _isLoading;
  late bool _permissionReady;

  late List<MyItem> itemsList;

  final formkey = GlobalKey<FormState>();

  TextEditingController landApplyEditController = TextEditingController();
  TextEditingController landAddressEditController = TextEditingController();
  var enableApplySchemesButton = false.obs;

  var landDetailsFilled = false.obs;
  var allDocumentUpload = false.obs;
  var isSchemesReApplied = 0;

  var isLoadingAppliedSchemes = false.obs;

  var requiredDocumentList = [];
  HttpsService? httpService;
  FetchLandDetailsModel? fetchLandDetailsModel;
  var landAddressErrorMessage = "".obs;
  var appliedSchemeErrorMessage = "".obs;
  var uploadDocumentList = [];
  var uploadedDocumentFilesList = [];

  var isFileUpdated=[];
  var downloadingFile = false;
  var progressString = "0".obs;
  var currentTimeStamp;
  double progressDownload = 0.0;
  String fileName = "";
  var downloadingProgress = "".obs;
  var filePath;
  var progressCallback = 0.obs;
  var status2 = "".obs;
  var id = 0.obs;

  List<LandData> landAddressList = [];
  var addressList = [];
  var docUrl;

  var selfDeclartionFilePath;
  var detailsProjectReportFilePath;

  var selfDeclarationsFileName;
  var detailsProjectFileName;
  var showPDFFile = [];
  var downloadFileList = [detailsOfExpenditureStr.tr,applicationsFormStr.tr];
  var pickedPDfList = [];
  var selectedSectorValue;
  var farmerId;
  var landAddressId;

  var schemesId;
  Scheme? scheme;

  var schemeName;
  var schemesResubmit;
  SchemesStatusData? schemesStatusData;
  var documentLists = [];
  var isSelfDeclarationPicked = false.obs;
  var isProjectNotePicked = false.obs;
  var isOtherDocumentPicked = false.obs;
  var otherDocumentFilePaths = [];
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;





  @override
  void onInit() {
    httpService = HttpsService();
    fetchLandDetails();
    notificationsPermission();
    scheme = Get.arguments["scheme"];
    schemesResubmit = Get.arguments["isSchemeReApplied"];
    schemesStatusData = Get.arguments["appliedScheme"];

    if (schemesResubmit == SCHEMES_STATUS_RESUBMIT) {
      if (schemesStatusData != null) {
        schemesId = schemesStatusData!.schemeId;
        schemeName = schemesStatusData!.schemeName;
         setReappliedSchemeData();
      }
    } else {
      schemesId = scheme!.id;
      schemeName = scheme!.schemeName;
      landApplyEditController.text="";
      landAddressEditController.text="";
      docUrl = localStorage.read(LocalStorageConstants().docUrl);
      debugPrint("doc url is$docUrl");
      if (scheme!.selfUpload!=null&&scheme!.selfUpload!="") {
        selfDeclartionFilePath = image_url + docUrl + scheme!.selfUpload;
        selfDeclarationsFileName = scheme!.selfUpload;
      }
      if (scheme!.dprUpload!=null&&scheme!.dprUpload!="") {
        detailsProjectReportFilePath = image_url + docUrl + scheme!.dprUpload;
        detailsProjectFileName = scheme!.dprUpload;
      }
      debugPrint(
          "self Declartion File Path $selfDeclartionFilePath   dpr path is  $detailsProjectReportFilePath");
      requiredDocumentList.clear();
      uploadDocumentList.clear();
      getRequiredDocumentList();
    }


    selectedSectorValue =
        localStorage.read(LocalStorageConstants().selectedSector);
    debugPrint("selected Sector is ${selectedSectorValue.toString()}");

    _isLoading = true;
    _permissionReady = false;
    _prepare();

    super.onInit();
  }

  setReappliedSchemeData() {
    landApplyEditController.text = "${schemesStatusData!.landApplied!}";
    landAddressEditController.text = schemesStatusData!.landAddress!;
    landAddressId = schemesStatusData!.landAddressId;
    docUrl = localStorage.read(LocalStorageConstants().docUrl);
    debugPrint("doc url is$docUrl");
    if (schemesStatusData!.selfUpload != null&&schemesStatusData!.selfUpload!="") {
      selfDeclartionFilePath =
          image_url + docUrl + schemesStatusData!.selfUpload!;
      selfDeclarationsFileName = schemesStatusData!.selfUpload!;

    }
    isSelfDeclarationPicked.value = true;
    isProjectNotePicked.value = true;
    if (schemesStatusData!.dprUpload != null&&schemesStatusData!.dprUpload!="") {
      detailsProjectReportFilePath =
          image_url + docUrl + schemesStatusData!.dprUpload!;
      detailsProjectFileName = schemesStatusData!.dprUpload!;

    }

    if (schemesStatusData != null) {
      isSchemesReApplied = 1;
      requiredDocumentList.clear();

      uploadDocumentList.clear();
      documentLists = json.decode(schemesStatusData!.terms!).toList();
      if (documentLists.isNotEmpty&&!documentLists.contains(null)) {
        for (int i = 0; i < documentLists.length; i++) {
          uploadDocumentList.insert(i, documentLists[i]);
        }
      }
      uploadDocumentList.addAll(downloadFileList);
      otherDocumentFilePaths = json.decode(schemesStatusData!.otherDocuments!).toList();
      if (otherDocumentFilePaths.isNotEmpty&&documentLists.length==otherDocumentFilePaths.length) {
        isOtherDocumentPicked.value = true;
        for (int i = 0; i < otherDocumentFilePaths.length; i++) {
          uploadedDocumentFilesList.insert(i, File(image_url+docUrl+otherDocumentFilePaths[i]));
        }
        uploadedDocumentFilesList.add(File(image_url+docUrl + schemesStatusData!.projectNote!));
        uploadedDocumentFilesList.add(File(image_url+docUrl + schemesStatusData!.selfDeclaration!));


       if(otherDocumentFilePaths.isNotEmpty){
         for(int i=0;i<otherDocumentFilePaths.length;i++){
           isFileUpdated.insert(i,false);
         }
       }


      }
      else{
        uploadedDocumentFilesList.add(File(image_url+docUrl + schemesStatusData!.projectNote!));
        uploadedDocumentFilesList.add(File(image_url+docUrl + schemesStatusData!.selfDeclaration!));
        // for(int i=0;i<documentLists.length+2;i++){
        //   uploadedDocumentFilesList.insert(i,File("null"));
        // }
        // update(["uploads"]);
      }

      isFileUpdated.add(false);
      isFileUpdated.add(false);
    }
    for (int i = 0; i < uploadDocumentList.length; i++) {
      showPDFFile.insert(i, true);
      if(uploadedDocumentFilesList.isNotEmpty){
        pickedPDfList.insert(i,uploadedDocumentFilesList[i]);
      }
    }
    enableApplySchemesButton.value = !pickedPDfList.contains("null");
    // showPDFFileList();
  }


  getRequiredDocumentList() {
    if (scheme != null) {
      for (int i = 0; i < scheme!.terms!.length; i++) {
        if(scheme!.terms![i].terms!=null){
          requiredDocumentList.insert(i, scheme!.terms![i]);
        }

      }
    }
    if (requiredDocumentList.isNotEmpty) {
      for (int i = 0; i < requiredDocumentList.length; i++) {
        uploadDocumentList.insert(i, requiredDocumentList[i].terms);
      }
    }
    uploadDocumentList.addAll(downloadFileList);
    showPDFFileList();
  }

  showPDFFileList() {
    for (int i = 0; i < uploadDocumentList.length; i++) {
      showPDFFile.insert(i, false);
      pickedPDfList.insert(i, "null");
    }
  }

  refreshButton() {
    update(["applyButton"]);
  }

  refreshScreen() {
    update(["uploads"]);
  }

  landAddressValue(value) {
    landAddressEditController.text = value;
    var selectedAddressIndex = addressList.indexOf(value);
    landAddressId = landAddressList[selectedAddressIndex].id;
    debugPrint("land id $landAddressId");
    update();
  }

  Future<FetchLandDetailsModel> fetchLandDetails() async {
    // Response? response;
    try {
      farmerId = await localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id:${farmerId}");
      var response = await Dio().get(BASE_URL + fetchLandDetailsEnd,
          queryParameters: {"farmer_id": farmerId},
          options: Options(headers: httpService?.headersGet));
      if (response.statusCode == 200) {
        debugPrint("land details data is  ${response.data}");
        fetchLandDetailsModel = FetchLandDetailsModel.fromJson(response.data);
        // mediaUrl=fetchLandDetailsModel!.mediaUrl;
        for (int i = 0; i < fetchLandDetailsModel!.data!.length; i++) {
          landAddressList.insert(i, fetchLandDetailsModel!.data![i]);
          addressList.insert(i, fetchLandDetailsModel!.data![i].landAddress);
          // uploadDocumentList.insert(i, element)
          // refreshScreen();
        }
        if (fetchLandDetailsModel!.data!.isEmpty) {
          localStorage.write(LocalStorageConstants().landDetailsSaved, false);
        } else {
          localStorage.write(LocalStorageConstants().landDetailsSaved, true);
        }
      }
    } catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);
        landAddressErrorMessage.value = DioException.errorMessage!;
        toast(landAddressErrorMessage.value);
        debugPrint("land details error is  ${landAddressErrorMessage.value} ");
        landAddressErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        if (e.response!.statusCode == 401) {
          landAddressErrorMessage.value = e.response!.data;
          // toast(e.response!.data);
        } else {
          toast(e.toString());
        }
      }
    }
    return fetchLandDetailsModel!;
  }

  Future<void> _prepare() async {
    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      // await _prepareSaveDir();
    }
    _isLoading = false;
    update();
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;

   // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
 //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // final platform = Theme.of(context).platform;
    if (Platform.isAndroid)
    // && androidInfo.version.sdkInt! <= 28)
    {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }






  Future<void> downloadFile(index) async {

    String? url;
    var current = DateTime.now();
    Timestamp timeStamp = Timestamp.fromDate(current);
    debugPrint("current timeStamp is ${timeStamp.seconds}");
    if (index == 0) {
      if (detailsProjectReportFilePath != null &&
          detailsProjectReportFilePath != "") {
        url = detailsProjectReportFilePath;
        fileName = timeStamp.seconds.toString() + detailsProjectFileName;
      }
    }
    if (index == 1) {
      if (selfDeclartionFilePath != null && selfDeclartionFilePath != "") {
        url = selfDeclartionFilePath;
        fileName = timeStamp.seconds.toString() + selfDeclarationsFileName;
      }
    }


    try {
      debugPrint("url is$url");

      if(Platform.isAndroid){
        await Dio().download(
            url!,
            "/storage/emulated/0/Download/$fileName",
            onReceiveProgress: (rec, total) async {
              debugPrint("Rec: $rec , Total: $total");
              downloadingFile = true;
              progressString.value = "${((rec / total) * 100).toStringAsFixed(0)}%";
              debugPrint("downloading${progressString.value}");
              if (progressString.value == "100%") {
                LocalNotificationService().initialize();
                LocalNotificationService().showNotifications(title: "File Downloaded",message: "$fileName Downloaded successfully");
              }
              update();
            });
      }
      if(Platform.isIOS){
        var iosDirectory=  await getApplicationDocumentsDirectory();
        await Dio().download(
            url!,
            "${iosDirectory.path}/$fileName",
            onReceiveProgress: (rec, total) async {
              debugPrint("Rec: $rec , Total: $total");
              downloadingFile = true;
              progressString.value = "${((rec / total) * 100).toStringAsFixed(0)}%";
              debugPrint("downloading${progressString.value}");
              if (progressString.value == "100%") {
                LocalNotificationService().initialize();
                LocalNotificationService().showNotifications(title: "Downloaded",message: "$fileName Downloaded successfully");
              }
              update();
            });
      }
    } catch (e) {
      toast(fileNotDownloadedStr.tr);
      debugPrint("$e");
    }
  }


  appliedSchemesApiCall() async {

    var indexListUpdated=[];
    var selfDeclarationsMultiPartFile;
    var detailsProjectReportMultipartFile;
    var otherDocumentMultiPartFileList = [];

    if (isOtherDocumentPicked.value == false) {
      for (int i = 0; i < requiredDocumentList.length; i++) {
        otherDocumentMultiPartFileList.add(await MultipartFile.fromFile(
            pickedPDfList[i].path,
            filename: pickedPDfList[i].path));
      }
    }
    else{
      for(int i=0;i<otherDocumentFilePaths.length;i++){
          if(isFileUpdated[i]==true){
            indexListUpdated.add(i);
            otherDocumentMultiPartFileList.add(await MultipartFile.fromFile(
                pickedPDfList[i].path,
                filename: pickedPDfList[i].path));
          }
          else{
            otherDocumentMultiPartFileList.add("");
          }


      }
    }
    debugPrint("last index${pickedPDfList.last}");
      if(pickedPDfList.length>2){
        if (isProjectNotePicked.value == false) {
          detailsProjectReportMultipartFile = await MultipartFile.fromFile(
              pickedPDfList[pickedPDfList.length - 2].path,
              filename: pickedPDfList[pickedPDfList.length - 2].path);
        }
        else{
          if(isFileUpdated[pickedPDfList.length - 2]==true){
            isProjectNotePicked.value=false;
            detailsProjectReportMultipartFile = await MultipartFile.fromFile(
                pickedPDfList[pickedPDfList.length - 2].path,
                filename: pickedPDfList[pickedPDfList.length - 2].path);
          }
        }
        if (isSelfDeclarationPicked.value == false) {
          selfDeclarationsMultiPartFile = await MultipartFile.fromFile(
              pickedPDfList[pickedPDfList.length - 1].path,
              filename: pickedPDfList[pickedPDfList.length - 1].path);
        }
        else{
          if(isFileUpdated[pickedPDfList.length - 1]==true){
            isSelfDeclarationPicked.value=false;
            selfDeclarationsMultiPartFile = await MultipartFile.fromFile(
                pickedPDfList[pickedPDfList.length - 1].path,
                filename: pickedPDfList[pickedPDfList.length - 1].path);
          }
        }
      }

      else{
        if (isProjectNotePicked.value == false) {
          detailsProjectReportMultipartFile = await MultipartFile.fromFile(
              pickedPDfList[0].path,
              filename: pickedPDfList[0].path);
        }
        else{
          if(isFileUpdated[0]==true){
            isProjectNotePicked.value=false;
            detailsProjectReportMultipartFile = await MultipartFile.fromFile(
                pickedPDfList[0].path,
                filename: pickedPDfList[0].path);
          }
        }
        if (isSelfDeclarationPicked.value == false) {
          selfDeclarationsMultiPartFile = await MultipartFile.fromFile(
              pickedPDfList[1].path,
              filename: pickedPDfList[1].path);
        }
        else{
          if(isFileUpdated[1]==true){
            isSelfDeclarationPicked.value=false;
            selfDeclarationsMultiPartFile = await MultipartFile.fromFile(
                pickedPDfList[1].path,
                filename: pickedPDfList[1].path);
          }
        }

      }




    var appliedSchemesData = AuthParams().appliedSchemesParam(
      farmerId: farmerId,
      landId: landAddressId,
      landApplied: landApplyEditController.text.trim(),
      schemeId: schemesId,
      publicPrivate: selectedSectorValue,
      selfDeclarationFile:isSelfDeclarationPicked.value?"":selfDeclarationsMultiPartFile,
      projectDetailsFile:isProjectNotePicked.value?"":detailsProjectReportMultipartFile,
      reject: isSchemesReApplied,
      index:indexListUpdated,
      othersDocuments: otherDocumentMultiPartFileList,
    );

    try {
      isLoadingAppliedSchemes.value = true;
      update();
      debugPrint("list length${isFileUpdated.length} $selfDeclarationsMultiPartFile  $detailsProjectReportMultipartFile");

      var response = await Dio().post(BASE_URL + appliedSchemeEnd,
          data: appliedSchemesData,
          options: Options(
            headers: httpService!.headers,
              sendTimeout: Duration(seconds: 60), // 60 seconds
              receiveTimeout:  Duration(seconds: 60),
          ));
      var token = localStorage.read(LocalStorageConstants().token);
      debugPrint("token is $token");
      if (response.statusCode == 200) {
        isLoadingAppliedSchemes.value = false;
        update();
        MessageResponseModel? messageModel=MessageResponseModel.fromJson(response.data);
        toast(messageModel.message);
        Get.delete<MySchemesController>();
        // Navigator.pushAndRemoveUntil<void>(
        //   Get.context!,
        //   MaterialPageRoute<void>(builder: (BuildContext context) =>  MySchemes()),
        //   ModalRoute.withName('/mainScreen'),
        // );

        Get.offNamedUntil(Routes().mySchemes,ModalRoute.withName(Routes().mainScreen));
        debugPrint("applied schemes data ${response.data}");
      }
    } catch (e) {
      if (e is DioError) {
        isLoadingAppliedSchemes.value = false;
        update();
        DioException.fromDioError(e);
        appliedSchemeErrorMessage.value = DioException.errorMessage!;
        // toast(appliedSchemeErrorMessage.value);
        debugPrint(
            "land details error is  ${appliedSchemeErrorMessage.value} ");
        appliedSchemeErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        MessageResponseModel? messageModel=MessageResponseModel.fromJson(e.response!.data);
        if (e.response!.statusCode == 401) {
            toast(messageModel.message);
        } else {
          isLoadingAppliedSchemes.value = false;
          update();
          toast(appliedSchemeErrorMessage.value);
        }
      }
      else{
        isLoadingAppliedSchemes.value = false;
        update();
        toast(e.toString());
      }
    }
  }



  @override
  void onClose() {
    requiredDocumentList.clear();
    showPDFFile.clear();
    pickedPDfList.clear();
    uploadDocumentList.clear();
    uploadedDocumentFilesList.clear();
    isFileUpdated.clear();
  }
}
