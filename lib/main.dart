import 'dart:async';
import 'package:farmer_app/ui/bindings/AppliedSchemesBinding.dart';
import 'package:farmer_app/ui/bindings/ApplySchemesBinding.dart';
import 'package:farmer_app/ui/bindings/CompleteDetailsBinding.dart';
import 'package:farmer_app/ui/bindings/LoginBinding.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingHandler(RemoteMessage message)async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("message from firebase is ${message.messageId}");
}

var locale= const Locale('en','US');
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
  AllControllerBinding().dependencies();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
  ));




  getLanguagesSelectedIndex();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MyApp());
  });
}


getLanguagesSelectedIndex(){
  var index=localStorage.read(LocalStorageConstants().selectedLanguage);
  if(index!=null){
    if(index==0){
      locale= const Locale('en','US');
    }
    if(index==1){
      locale= const Locale('pa','IN');
    }
    if(index==2){
      locale= const Locale('hi','IN');
    }
  }


}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            smartManagement: SmartManagement.onlyBuilder,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: bgColor,
              primaryColor: primaryColor,
              dividerColor: Colors.transparent,
            ),
            translations: Languages(),
            locale:locale,
            initialRoute: "/",
            defaultTransition: Transition.rightToLeft,
            getPages: [
              GetPage(name: Routes().mainClass, page:()=>  MyApp()),
              GetPage(name:  Routes().splashScreen, page:()=>  SplashScreen()),
              GetPage(name:  Routes().selectLanguage, page:()=> SelectLanguage()),
              GetPage(name:  Routes().registerScreen, page:()=> Register()),
              GetPage(name:  Routes().enterOtp, page:()=> RegisterOtpVerification()),
              GetPage(name:  Routes().loginScreen, page:()=> FarmerLogin(),binding: LoginBinding()),
              GetPage(name:  Routes().enterOtpVerify, page:()=> LoginOtpVerify()),
              GetPage(name:  Routes().mainScreen, page:()=> MainScreen()),
              GetPage(name:  Routes().exploreSchemes, page:()=> ExploreSchemes()),
              GetPage(name:  Routes().search, page:()=> Search()),
              GetPage(name:  Routes().farmerProfile, page:()=> FarmerProfile()),
              GetPage(name:  Routes().completeProfile, page:()=> CompleteProfile()),
              GetPage(name:  Routes().schemesDetails, page:()=> const SchemeDetails()),
              GetPage(name:  Routes().languagesPref, page:()=> LanguagesPreference()),
              GetPage(name:  Routes().notifications, page:()=> const NotificationScreen()),
              GetPage(name:  Routes().videoPlay, page:()=> VideoPlayScreen()),
              GetPage(name:  Routes().todayWeather, page:()=> TodayWeather()),
              GetPage(name:  Routes().updateProfileInfo, page:()=> UpdateProfileInfoScreen()),
              GetPage(name:  Routes().updateAddress, page:()=> UpdateAddressScreen()),
              GetPage(name:  Routes().subSchemesList, page:()=> SubSchemesList()),
              GetPage(name:  Routes().schemesVideoPlay, page:()=> SchemesVideoPlay()),
              GetPage(name:  Routes().completeDetailsScreen, page:()=> CompleteDetailsScreen(),binding: CompleteDetailsBinding()),
              GetPage(name:  Routes().schemesTrackingScreen, page:()=> const SchemesTrackingScreen()),
              GetPage(name:  Routes().bankDetailsScreen, page:()=> BankDetailsScreen()),
              GetPage(name:  Routes().landDetailsScreen, page:()=> LandDetailsScreen()),
              GetPage(name:  Routes().uploadDocumentScreen, page:()=> UploadDocuments(),binding:UploadSchemesBinding()),
              GetPage(name:  Routes().mySchemes, page:()=> MySchemes(),binding: AppliedSchemesBinding()),
              GetPage(name:  Routes().landDetailsFields, page:()=> AddLand()),
              GetPage(name:  Routes().schemesCategoryList, page:()=> SchemesCategoryList()),
              GetPage(name:  Routes().reason, page:()=> const ReasonOfSchemesStatus()),
            ],
            home:SplashScreen(),
          );
        });
  }







}





