import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habbit_breaker/data/dailyReminders.dart';
import 'package:habbit_breaker/main.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/screens/display_payload_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class NotificationService {
  // Initialize FlutterLocalNotificationsPlugin
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification details
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails("channelId", "channelName",
        priority: Priority.high,
        importance: Importance.high,
        icon: "@mipmap/ic_launcher"),
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
      debugPrint('Notification permission granted.');
    } else if (status.isDenied) {
      debugPrint('Notification permission denied.');
    } else if (status.isPermanentlyDenied) {
      debugPrint(
          'Notification permission permanently denied. Please go to settings.');
    }
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

  // Method to send daily notification
  static void sendDailyNotification() {
    BuildContext context = navigatorKey.currentContext!;
    final String selectedLanguage =
        Provider.of<SettingsProvider>(context).languageCode;
    final List<String> listReminders =
        dailyReminders[selectedLanguage] ?? dailyReminders['en']!;

    final random = Random();
    int randomIndex = random.nextInt(listReminders.length);
    String randomReminder = listReminders[randomIndex];
    print(selectedLanguage);
    print(randomReminder);

    flutterLocalNotificationsPlugin.show(
        randomIndex, "Reminder", randomReminder, notificationDetails,
        payload: randomReminder);
  }

  // Method to send periodic notification
  static void sendPeriodicNotification(
      {required String title, required String body, required String payload}) {
    debugPrint("period notification is enabled");
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
    navigatorKey.currentState?.pushReplacement(
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
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayPayload(
          payloadData: response.payload,
        ),
      ),
    );
  }
}
