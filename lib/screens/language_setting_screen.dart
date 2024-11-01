import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../providers/auth_provider.dart';

class LanguageSettingScreen extends StatefulWidget {
  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    String languageCode = SharedPrefs.instance.getStringData('languageCode');
    _selectedLanguage = languageCode.isEmpty ? 'en' : languageCode;
  }

  Future<void> _setLocale(BuildContext context, String languageCode) async {
    SharedPrefs.instance.setStringData('languageCode', languageCode);
    await S.load(Locale(languageCode));
  }

  void _onSelectLanguage(BuildContext context) async {
    await _setLocale(context, _selectedLanguage!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed successfully to $_selectedLanguage.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Intl.getCurrentLocale());
    return Scaffold(
      appBar: AppBar(
        title: Text('Language setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildLanguageTile(
                  context, 'English', 'en', ImageConstants.enFlag),
              Dimensions.smHeight,
              _buildLanguageTile(
                  context, 'Arabic', 'ar', ImageConstants.enFlag),
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
