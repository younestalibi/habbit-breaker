import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/screens/language_setting_screen.dart';
import 'package:habbit_breaker/screens/profile_setting_screen.dart';
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
        title: Text(S.of(context).settings, style: Theme.of(context).textTheme.titleLarge),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(S.of(context).profile,
                      style: Theme.of(context).textTheme.titleSmall)),
            ),
            const Divider(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => LanguageSettingScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(S.of(context).language,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ),
            const Divider(),
            SwitchListTile(
              title: Text(S.of(context).enable_notifications,
                  style: Theme.of(context).textTheme.titleSmall),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              title: Text(S.of(context).enable_dark_theme,
                  style: Theme.of(context).textTheme.titleSmall),
              value: darkThemeEnabled,
              onChanged: (value) {
                settingsProvider.changeTheme();
                // setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
