import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  // Initialize the timezone
  Future<void> init() async {
    tzData.initializeTimeZones();
  }

  // Schedule notification in 10 seconds
  Future<void> scheduleNotificationIn10Seconds() async {
    // Initialize the timezone data
    tzData.initializeTimeZones();

    // Get the current time and add 10 seconds to it
    DateTime now = DateTime.now();
    DateTime scheduleTime = now.add(Duration(seconds: 10)); // 10 seconds later

    // Convert to timezone-aware DateTime
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduleTime, tz.local);

    // Define Android notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '10_second_channel_id',
      '10 Second Notifications',
      channelDescription: 'Channel for notifications every 10 seconds',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification for 10 seconds from now
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   0,
    //   'Reminder',
    //   'This notification was scheduled 10 seconds from now.',
    //   scheduledDate,
    //   platformChannelSpecifics,
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );
    print('hell owrld');
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'السلام عليكم',
      'This notification was scheduled 10 seconds from now.',
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
