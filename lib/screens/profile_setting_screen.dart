import 'package:flutter/material.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
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
        title: Text("Profile Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _changeProfilePicture(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_profileImagePath!),
                  ),
                  if (_isImageLoading) CircularProgressIndicator(),
                  if (!_isImageLoading)
                    Icon(Icons.camera_alt, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildTextField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.person),
            SizedBox(height: 16),
            _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email),
            SizedBox(height: 16),
            _buildTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock,
                isObscured: true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _updateUserProfile,
              child: _isLoading ? Text('Saving...') : Text('Save'),
            ),
            SizedBox(height: 24),
            if (_successMessage != null)
              Text(_successMessage!, style: TextStyle(color: Colors.green)),
            TextButton(
              onPressed: _showDeleteConfirmation,
              child:
                  Text('Delete Account', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscured = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
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

    // Check if username is different before updating
    if (username != authProvider.getUserName()) {
      String? error = await authProvider.updateUserName(username);
      if (error != null) errorMessages.add(error);
    }

    // Check if email is different before updating
    if (email != authProvider.getUserEmail()) {
      String? error = await authProvider.updateEmail(email);
      if (error != null) errorMessages.add(error);
      _showSnackBar(
          'A verification link has been sent to your new email. Please verify to complete the update.');
    }

    // Update password only if provided
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
        _successMessage = 'Profile updated successfully!';
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
            'Are you sure you want to delete your account? This action is irreversible.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          TextButton(
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              String? result = await authProvider.deleteAccount();
              Navigator.of(context).pop();
              _showSnackBar(result ?? 'Account deleted successfully.');
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
