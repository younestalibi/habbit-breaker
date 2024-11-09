import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/main.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/screens/language_setting_screen.dart';
import 'package:habbit_breaker/screens/profile_setting_screen.dart';
import 'package:habbit_breaker/services/notification_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool darkThemeEnabled = settingsProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(S.of(context).profile),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).language),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => LanguageSettingScreen()),
                );
              },
            ),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  NotificationService(flutterLocalNotificationsPlugin)
                      .scheduleNotificationIn10Seconds();
                },
                child: Text('notiviat')),
            SwitchListTile(
              title: Text(S.of(context).enable_notifications),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              title: Text(S.of(context).enable_dark_theme),
              value: darkThemeEnabled,
              onChanged: (value) {
                settingsProvider.changeTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
