import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  Future<void> scheduleNotificationInTwoMinutes() async {
    // Initialize the timezone data
    tzData.initializeTimeZones();

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the time that is 2 minutes from now
    DateTime scheduleTime = now.add(Duration(seconds: 5));

    // Convert to timezone-aware DateTime
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduleTime, tz.local);

    // Define Android notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'two_minute_channel_id',
      'Two Minute Notifications',
      channelDescription: 'Channel for notifications after 2 minutes',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification for the next 2 minutes
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'This notification was scheduled 2 minutes from now.',
      scheduledDate,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
