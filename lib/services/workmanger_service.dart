import 'package:flutter/material.dart';
import 'package:habbit_breaker/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';

class ManagerService {
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == "showDailyNotification") {
        try {
          NotificationService.sendDailyNotification();
          NotificationService.sendInstantNotification(
              body: 'hiii', title: 'title', payload: 'payloda');
          print('hi notificaitno');
          debugPrint('her in notification');
        } catch (e) {
          print(e);
        }
      }
      debugPrint("Native called background task: $task");
      return Future.value(true);
    });
  }

  static void registerToDailyNotification() {
    Workmanager().registerPeriodicTask(
      "dailyNotificationTask",
      "showDailyNotification",
      frequency: const Duration(minutes: 15),
    );
  }

  static void cancelDailyNotification() {
    Workmanager().cancelByUniqueName("dailyNotificationTask");
  }
}
