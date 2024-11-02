import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/screens/language_setting_screen.dart';
import 'package:habbit_breaker/screens/profile_setting_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
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
        title: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsScreen()),
                );
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Profile',
                      style: Theme.of(context).textTheme.titleSmall)),
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => LanguageSettingScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Language',
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ),
            Divider(),
            SwitchListTile(
              title: Text('Enable Notifications',
                  style: Theme.of(context).textTheme.titleSmall),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            Divider(),
            SwitchListTile(
              title: Text('Enable Dark Theme',
                  style: Theme.of(context).textTheme.titleSmall),
              value: darkThemeEnabled,
              onChanged: (value) {
                settingsProvider.changeTheme();
                // Call setState() if you need to rebuild the UI,
                // but it's optional since the Provider will notify listeners.
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
