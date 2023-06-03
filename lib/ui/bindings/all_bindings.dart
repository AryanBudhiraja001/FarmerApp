
import 'package:farmer_app/ui/constants/exports.dart';

class AllControllerBinding extends Bindings{
 @override
  void dependencies() {
  Get.lazyPut<SplashController>(()=>SplashController());
  Get.lazyPut<SelectLanguageController>(()=>SelectLanguageController());
  Get.lazyPut<RegisterController>(()=>RegisterController(),fenix: true);
  Get.lazyPut<MainScreenController>(()=>MainScreenController());
  Get.lazyPut<HomeController>(()=>HomeController());
  Get.lazyPut<FarmerProfileController>(()=>FarmerProfileController());
  Get.lazyPut<CompleteProfileController>(()=>CompleteProfileController());
  Get.lazyPut<UpdateProfileInfoController>(()=>UpdateProfileInfoController());
  Get.lazyPut<UpdateAddressController>(()=>UpdateAddressController());
//  Get.lazyPut<FarmerLoginController>(()=>FarmerLoginController(),fenix: true);
  Get.lazyPut<LoginOtpVerifyController>(()=>LoginOtpVerifyController());
  Get.lazyPut<SchemesController>(()=>SchemesController());
  Get.lazyPut<SubSchemesController>(()=>SubSchemesController());
  Get.lazyPut<SchemesDetailsController>(()=>SchemesDetailsController());
  Get.lazyPut<TodayWeatherController>(()=>TodayWeatherController());
  Get.lazyPut<MandiRateController>(()=>MandiRateController());
  Get.lazyPut<SearchController>(()=>SearchController());
  Get.lazyPut<VideoFeedController>(()=>VideoFeedController());
  Get.lazyPut<SchemesVideoPlayController>(()=>SchemesVideoPlayController());
  // Get.lazyPut<CompleteDetailsScreensController>(()=>CompleteDetailsScreensController());
  Get.lazyPut<SchemeSTrackingController>(()=>SchemeSTrackingController());
  Get.lazyPut<BankDetailsController>(()=>BankDetailsController());
  Get.lazyPut<LandDetailsController>(()=>LandDetailsController());
  // Get.lazyPut<UploadDocumentController>(()=>UploadDocumentController());
  // Get.lazyPut<MySchemesController>(()=>MySchemesController());
  Get.lazyPut<addLandController>(()=>addLandController());
  Get.lazyPut<SchemesCategoryListController>(()=>SchemesCategoryListController());
  Get.lazyPut<DownloadFileController>(()=>DownloadFileController());
  Get.lazyPut<ReasonOfSchemesController>(()=>ReasonOfSchemesController());
  Get.lazyPut<NotificationController>(()=>NotificationController());
 }

}