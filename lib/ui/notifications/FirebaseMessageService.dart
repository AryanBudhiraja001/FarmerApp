import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constants/exports.dart';

class FirebaseMessagingService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel =  const AndroidNotificationChannel(
    'farmer app status', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );




  final StreamController<String?> selectNotificationStream =
  StreamController<String?>.broadcast();




  void initialize() {
    // initializationSettings  for Android

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        requestCriticalPermission: true
    );
    AndroidInitializationSettings androidInitialNoti= AndroidInitializationSettings("@mipmap/horiculture_logo");


    InitializationSettings initializationSettings =
    InitializationSettings(
        android: androidInitialNoti,
        iOS:  initializationSettingsDarwin
    );

    // const iosInitializationSetting = DarwinInitializationSettings();

    _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:(NotificationResponse response){
             Get.offNamed(Routes().mySchemes);
        }
        );

  }
  void createanddisplaynotification(RemoteMessage message) async {
    try {
      AndroidNotificationDetails androidDetails=AndroidNotificationDetails(
          "Notification",
          "show Notifications",
          priority: Priority.high,
          importance: Importance.max,
          icon: "@mipmap/horiculture_logo"
      );

      DarwinNotificationDetails iosDetails=DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true
      );

      NotificationDetails notiDetails=NotificationDetails(
          android: androidDetails,
          iOS: iosDetails
      );

      _notificationsPlugin.show(0, message.notification!.title??"first", message.notification!.body??"file Downloaded successfully", notiDetails);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


}






