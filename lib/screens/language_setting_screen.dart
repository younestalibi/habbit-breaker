import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_dialog.dart';
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

  void _onSelectLanguage(BuildContext context) {
    Provider.of<SettingsProvider>(context, listen: false)
        .changeLanguage(_selectedLanguage);
    CustomDialog.show(context,
        title: S.of(context).success,
        textConfirm: S.of(context).ok,
        content: Text(
          S
              .of(context)
              .changed_language_success(_getLanguageName(_selectedLanguage)),
          textAlign: TextAlign.center,
        ),
        dialogType: DialogType.info);
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
                onPressed: () => _onSelectLanguage(context),
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

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return 'Unknown Language';
    }
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
