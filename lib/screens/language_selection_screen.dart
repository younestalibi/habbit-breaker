import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../providers/auth_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage =
        Provider.of<SettingsProvider>(context, listen: false).languageCode;
  }

  void _onSelectLanguage(BuildContext context) async {
    Provider.of<SettingsProvider>(context, listen: false)
        .changeLanguage(_selectedLanguage);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated()) {
      Navigator.pushReplacementNamed(context, '/layout');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).language_setting),
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
                  context, 'Arabic', 'ar', ImageConstants.arFlag),
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
