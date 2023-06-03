import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:farmer_app/ui/networks/dio/api_params.dart';

import '../models/fetch_bank_details_model.dart';
import '../networks/dio/error_handling.dart';

class BankDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoadingBankData = false.obs;
  HttpsService? http;
  TextEditingController bankNameEditController = TextEditingController();
  TextEditingController ifscCodeEditController = TextEditingController();
  TextEditingController branchNameEditController = TextEditingController();
  TextEditingController accountNoEditController = TextEditingController();
  TextEditingController confirmAccountNoEditController = TextEditingController();
  TextEditingController farmerNameEditController = TextEditingController();
  TextEditingController bankBranchAddressEditController = TextEditingController();
  var pickedCancelCheckPDfFile;
  var pickedPassbookPDFFile;
  var bankDetailsErrorMessage = "".obs;
  var fetchBankDetailsErrorMessage = "".obs;
  var ispickedCancelCheckPDfFile = false.obs;
  var ispickedPassbookPDFFile = false.obs;

  FetchBankDetailsModel? fetchBankDetailsModel;
  Future<FetchBankDetailsModel>? futureBankDetailsData;

  refreshScreen() {
    update();
  }

  var isBankDetailsFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
    http = HttpsService();
    // getBankDetailsFilledOrNot();
    futureBankDetailsData = fetchBankDetails();
  }

  getBankDetailsFilledOrNot() {
    var bankDetails =
        localStorage.read(LocalStorageConstants().bankDetailsSaved);
    if (bankDetails == true) {
      isBankDetailsFilled.value = true;
      update();
    } else {
      isBankDetailsFilled.value = false;
    }
  }

  bankDetailsPostApiCall() async {
    try {
      var cancelBankMUltiPartFile;
      var passBookBankMultipartFile;

      if (ispickedCancelCheckPDfFile.value == false) {
        if (pickedCancelCheckPDfFile != null) {
          cancelBankMUltiPartFile = await MultipartFile.fromFile(
              pickedCancelCheckPDfFile!.path,
              filename: pickedCancelCheckPDfFile!.path);
        }
      }
      if (ispickedPassbookPDFFile.value == false) {
        if (pickedPassbookPDFFile != null) {
          passBookBankMultipartFile = await MultipartFile.fromFile(
              pickedPassbookPDFFile!.path,
              filename: pickedPassbookPDFFile!.path);
        }
      }
      var farmerID = await localStorage.read(LocalStorageConstants().farmerId);
      var token = localStorage.read(LocalStorageConstants().token);

      debugPrint("farmer id:${farmerID} and token ${token}");

      var bankBody = AuthParams().bankDetailsParam(
          farmerid: farmerID,
          bankName: bankNameEditController.text.trim(),
          ifscCode: ifscCodeEditController.text.trim(),
          branchName: branchNameEditController.text.trim(),
          accountNumber: accountNoEditController.text.trim(),
          holderName: farmerNameEditController.text.trim(),
          bankBranchAddress: bankBranchAddressEditController.text.trim(),
          uploadCancelCheck:
              ispickedCancelCheckPDfFile.value ? "" : cancelBankMUltiPartFile,
          uploadPassbook:
              ispickedPassbookPDFFile.value ? "" : passBookBankMultipartFile);
      isLoadingBankData.value = true;
      update();

      var response = await Dio().post(BASE_URL + bankDetailsEnd,
          data: bankBody, options: Options(headers: http!.headers));
      if (response.statusCode == 200) {
        isLoadingBankData.value = false;
       update();
        toast(successfullyAddedStr.tr);
        isBankDetailsFilled.value = true;
        Get.back();
        localStorage.write(LocalStorageConstants().bankDetailsSaved, true);
        debugPrint("bank details response successfull${response.data}");
      }
    } catch (e) {
      isLoadingBankData.value = false;
      update();

      if (e is DioError) {
        DioException.fromDioError(e);
        // EasyLoading.dismiss();
        bankDetailsErrorMessage.value = DioException.errorMessage!;
        debugPrint("video feed error${bankDetailsErrorMessage.value} ");
        bankDetailsErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
        toast(bankDetailsErrorMessage.value);
        if (e.response!.statusCode == 401) {

        } else {

        }
      }
    }
  }

  Future<FetchBankDetailsModel> fetchBankDetails() async {
    try {
      var farmerid = localStorage.read(LocalStorageConstants().farmerId);
      debugPrint("farmer id $farmerid");
      var response = await Dio().get(BASE_URL + fetchBankEnd,
          queryParameters: {
            "farmer_id": farmerid,
          },
          options: Options(
            headers: http!.headersGet,
          ));

      if (response.statusCode == 200) {
        fetchBankDetailsModel = FetchBankDetailsModel.fromJson(response.data);
        debugPrint("bank detials are ${response.data}");

        if (fetchBankDetailsModel!.data != null) {
          setBankData();
          localStorage.write(LocalStorageConstants().bankDetailsSaved, true);
      //    getBankDetailsFilledOrNot();
        }
      }
    } catch (e) {
      if (e is DioError) {
        DioException.fromDioError(e);
        fetchBankDetailsErrorMessage.value = DioException.errorMessage!;
        debugPrint("video feed error${fetchBankDetailsErrorMessage.value} ");
        fetchBankDetailsErrorMessage.value =
            DioException.handleStatusCode(e.response!.statusCode);
          toast(fetchBankDetailsErrorMessage.value);



      }
      //getBankDetailsFilledOrNot();
    }
    return fetchBankDetailsModel!;
  }

  setBankData() {
    if (fetchBankDetailsModel!.data != null) {
      bankNameEditController.text = fetchBankDetailsModel!.data!.bankName!;
      ifscCodeEditController.text = fetchBankDetailsModel!.data!.ifscCode!;
      branchNameEditController.text = fetchBankDetailsModel!.data!.branchName!;
      accountNoEditController.text = fetchBankDetailsModel!.data!.accountNo!;
      confirmAccountNoEditController.text =
          fetchBankDetailsModel!.data!.accountNo!;
      farmerNameEditController.text = fetchBankDetailsModel!.data!.accountName!;
      bankBranchAddressEditController.text =
          fetchBankDetailsModel!.data!.bankBranchAddress!;
      pickedCancelCheckPDfFile = File(fetchBankDetailsModel!.mediaUrl! +
          fetchBankDetailsModel!.data!.uploadCancelCheck!);

      pickedPassbookPDFFile = File(fetchBankDetailsModel!.mediaUrl! +
          fetchBankDetailsModel!.data!.uploadPassbook!);

      if (fetchBankDetailsModel!.data!.uploadCancelCheck != null) {
        ispickedCancelCheckPDfFile.value = true;
      }
      if (fetchBankDetailsModel!.data!.uploadPassbook != null) {
        ispickedPassbookPDFFile.value = true;
      }

      refreshScreen();
    }
  }
}
