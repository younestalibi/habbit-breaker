// import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habbit_breaker/services/display_payload_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  // Initialize FlutterLocalNotificationsPlugin
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // GlobalKey for navigation
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  // Notification details
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      priority: Priority.high,
      importance: Importance.high,
      icon: "@mipmap/ic_launcher",
    ),
  );

  // Initialize method
  static Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  // Method to request notification permission
  static void askForNotificationPermission() async {
    // For Android, request permissions if necessary (required in some cases for newer Android versions).
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    } else {
      print('androidn not aworking');
    }

    // Permission.notification.request().then((permissionStatus) {
    //   if (permissionStatus != PermissionStatus.granted) {
    //     // AppSettings.openAppSettings(type: AppSettingsType.notification);
    //     print('persmission not gartuent');
    //   }
    //   print('persmission is gartuent');
    // });
  }

  // Method to send instant notification
  static void sendInstantNotification(
      {required String title, required String body, required String payload}) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Method to send periodic notification
  static void sendPeriodicNotification(
      {required String title, required String body, required String payload}) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Method to cancel periodic notification
  static Future<void> cancelPeriodicNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }

  // Method to handle notification response
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint("onDidReceiveNotificationResponse");
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayPayload(
          payloadData: response.payload,
        ),
      ),
    );
  }

  // Method to handle background notification response
  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) {
    debugPrint("onDidReceiveBackgroundNotificationResponse");
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayPayload(
          payloadData: response.payload,
        ),
      ),
    );
  }
}
