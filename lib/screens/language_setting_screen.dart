import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';

class LanguageSettingScreen extends StatefulWidget {
  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage =
        Provider.of<SettingsProvider>(context, listen: false).languageCode;
  }

  void _onSelectLanguage() {
    Provider.of<SettingsProvider>(context, listen: false)
        .changeLanguage(_selectedLanguage);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed successfully to $_selectedLanguage.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectLanguage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildLanguageTile(
                  context, S.of(context).english, 'en', ImageConstants.enFlag),
              Dimensions.smHeight,
              _buildLanguageTile(
                  context, S.of(context).arabic, 'ar', ImageConstants.arFlag),
              Dimensions.smHeight,
              CustomElevatedButton(
                text: S.of(context).selectLanguage,
                onPressed: _onSelectLanguage,
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColorLight,
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
