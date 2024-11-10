import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
import 'package:habbit_breaker/widgets/custom_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _profileImagePath;
  bool _isLoading = false;
  bool _isImageLoading = false;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _usernameController.text = authProvider.getUserName();
    _emailController.text = authProvider.getUserEmail();
    _profileImagePath = authProvider.getUserPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile_setting),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 235, 235, 235),
                    offset: Offset(0, 2),
                    blurRadius: 2)
              ], borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () => _changeProfilePicture(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_profileImagePath!),
                    ),
                    if (_isImageLoading) const CircularProgressIndicator(),
                    if (!_isImageLoading)
                      const Icon(Icons.camera_alt, color: Colors.white),
                  ],
                ),
              ),
            ),
            Dimensions.smHeight,
            CustomInputField(
              controller: _usernameController,
              hintText: S.of(context).username,
              label: S.of(context).username,
              icon: Icons.person,
            ),
            Dimensions.smHeight,
            CustomInputField(
              controller: _emailController,
              hintText: S.of(context).email,
              label: S.of(context).email,
              icon: Icons.email,
            ),
            Dimensions.smHeight,
            CustomInputField(
              controller: _passwordController,
              hintText: S.of(context).password,
              label: S.of(context).password,
              obscureText: true,
              icon: Icons.lock,
            ),
            Dimensions.smHeight,
            CustomElevatedButton(
              text: _isLoading ? S.of(context).saving : S.of(context).save,
              onPressed: _isLoading ? () {} : _updateUserProfile,
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).primaryColorLight,
            ),
            Dimensions.smHeight,
            if (_successMessage != null)
              Text(_successMessage!,
                  style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }

  void _changeProfilePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isImageLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.uploadProfilePicture(pickedFile.path);
      setState(() {
        _profileImagePath = authProvider.getUserPhoto();
        _isImageLoading = false;
      });
    }
  }

  void _updateUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    List<String> errorMessages = [];

    if (username != authProvider.getUserName()) {
      String? error = await authProvider.updateUserName(username);
      if (error != null) errorMessages.add(error);
    }

    if (email != authProvider.getUserEmail()) {
      String? error = await authProvider.updateEmail(email);
      if (error != null) errorMessages.add(error);
      _showSnackBar(S.of(context).email_link_sent);
    }

    if (password.isNotEmpty) {
      String? error = await authProvider.updatePassword(password);
      if (error != null) errorMessages.add(error);
    }

    setState(() {
      _isLoading = false;
    });

    if (errorMessages.isNotEmpty) {
      _showSnackBar(errorMessages.join('\n'));
    } else {
      setState(() {
        _successMessage = S.of(context).profile_updated_successfully;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
