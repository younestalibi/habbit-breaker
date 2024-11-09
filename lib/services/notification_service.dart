import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habbit_breaker/main.dart';
import 'package:habbit_breaker/screens/display_payload_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
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
      // iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  // Method to request notification permission
  static Future<void> askForNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print('Notification permission granted.');
    } else if (status.isDenied) {
      print('Notification permission denied.');
    } else if (status.isPermanentlyDenied) {
      print(
          'Notification permission permanently denied. Please go to settings.');
      // await openAppSettings(); // Opens app settings if the permission is permanently denied
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
