import 'package:flutter/material.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../providers/auth_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en'; // Initial selected language

  Future<void> _setLocale(BuildContext context, String languageCode) async {
    SharedPrefs.instance.setStringData('languageCode', languageCode);
    await S.load(Locale(languageCode));
  }

  void _onSelectLanguage(BuildContext context) async {
    await _setLocale(context,
        _selectedLanguage); // Set the locale based on selected language

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated()) {
      Navigator.pushReplacementNamed(context, '/layout');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildLanguageTile(context, 'English', 'en', 'assets/logo.png'),
            Dimensions.smHeight,
            _buildLanguageTile(context, 'Arabic', 'ar', 'assets/logo.png'),
            Dimensions.smHeight,
            CustomElevatedButton(
              text: S.of(context).selectLanguage,
              onPressed: () => _onSelectLanguage(context),
              backgroundColor: Colors.black,
              padding: 20,
              borderRadius: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, String languageName,
      String languageCode, String logoPath) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          logoPath,
          width: 30,
          height: 30,
        ),
        title: Text(
          languageName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Radio<String>(
          value: languageCode,
          groupValue: _selectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                _selectedLanguage = value;
              });
            }
          },
        ),
        onTap: () {
          setState(() {
            _selectedLanguage = languageCode;
          });
        },
      ),
    );
  }
}
