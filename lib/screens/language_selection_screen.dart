import 'package:flutter/material.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../providers/auth_provider.dart';

class LanguageSelectionScreen extends StatelessWidget {
  Future<void> _setLocale(BuildContext context, String languageCode) async {
    SharedPrefs.instance.setStringData('languageCode', languageCode);
    S.load(Locale(languageCode));

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated()) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).selectLanguage)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _setLocale(context, 'en'),
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () => _setLocale(context, 'ar'),
              child: Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
