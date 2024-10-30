import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/screens/profile_setting_screen.dart';
import 'package:habbit_breaker/utils/dimensions.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true; // Toggle for notifications
  bool darkThemeEnabled = false; // Toggle for dark theme

  @override
  Widget build(BuildContext context) {
    print(Dimensions.mdHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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

                // Navigator.of(context).pushNamed('/settings/profile');
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: ColorConstants.dark,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Divider(),
            SwitchListTile(
              title: Text(
                'Enable Notifications',
                style: TextStyle(
                  color: ColorConstants.dark,
                  fontSize: 16,
                ),
              ),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            Divider(),
            // Dimensions.mdHeight,

            // Dark Theme Toggle
            SwitchListTile(
              title: Text(
                'Enable Dark Theme',
                style: TextStyle(
                  color: ColorConstants.dark,
                  fontSize: 16,
                ),
              ),
              value: darkThemeEnabled,
              onChanged: (value) {
                setState(() {
                  darkThemeEnabled = value;
                  // You can also add code here to apply the theme change
                });
              },
            ),
            Divider(),

            ListTile(
              title: Text('Reset All Data'),
              subtitle: Text('Clear all habit tracking data'),
              leading: Icon(Icons.refresh, color: Colors.red),
              onTap: () {
                _showResetConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Confirmation dialog for reset
  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Reset'),
        content: Text(
            'Are you sure you want to reset all data? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add reset logic here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All data reset successfully.')),
              );
            },
            child: Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
