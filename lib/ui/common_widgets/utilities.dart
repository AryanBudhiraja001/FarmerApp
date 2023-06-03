

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/exports.dart';



final localStorage = GetStorage();

newScreen({screenRoutes}){
  return  Get.toNamed(screenRoutes);

}

void logPrint(String s) {
  debugPrint("log:$s");
}
moveToBackScreen(){
  return Get.back();
}

var phoneNumberFormatter =  MaskTextInputFormatter(
    mask: '##########',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
);

var aadhaarNumberFormatter =  MaskTextInputFormatter(
    mask: '############',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
);

var panFormatter =  MaskTextInputFormatter(
    mask: '##########',
    filter: { "#": RegExp(r'[A-Za-z0-9]') },
    type: MaskAutoCompletionType.lazy
);

var ifscCodeFormatter =  MaskTextInputFormatter(
    mask: '###########',
    filter: { "#": RegExp(r'[A-Za-z0-9]') },
    type: MaskAutoCompletionType.lazy
    );

var pinCodeFormatter =  MaskTextInputFormatter(
    mask: '######',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
);

var accountNumberFormatter =  MaskTextInputFormatter(
    filter: { "#": RegExp('r^\d{9,18}') },
    type: MaskAutoCompletionType.lazy
);



   disableKeyboard(){
  return FocusManager.instance.primaryFocus?.unfocus();
   }

   //notifications permission for android 13


    notificationsPermission()async{
     if(Platform.isAndroid){
       DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
        final androidInfo = await deviceInfoPlugin.androidInfo;
        if(androidInfo.version.sdkInt>32){
          PermissionStatus status = await Permission.notification.request();
          if(status.isDenied){
            Permission.notification.request();
          }
        }
      }
   }


