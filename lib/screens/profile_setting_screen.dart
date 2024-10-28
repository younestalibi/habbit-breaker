import 'package:flutter/material.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'dart:io'; // Import for using File

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker
  String? _profileImagePath; // Variable to hold the image path

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _usernameController.text = authProvider.getUserName();
    _emailController.text = authProvider.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            GestureDetector(
              onTap: () {
                _changeProfilePicture();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : NetworkImage(authProvider.getUserPhoto())
                        as ImageProvider,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),

            // Username Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateUsername(authProvider);
              },
              child: Text('Save Username'),
            ),
            SizedBox(height: 16),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateEmail(authProvider);
              },
              child: Text('Save Email'),
            ),
            SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updatePassword(authProvider);
              },
              child: Text('Save Password'),
            ),
            SizedBox(height: 24),

            // Delete Account Button
            TextButton(
              onPressed: () {
                _showDeleteConfirmation();
              },
              child: Text(
                'Delete Accountt',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeProfilePicture() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource
            .gallery, // Change this to ImageSource.camera to take a photo
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 600);

    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path; // Update the profile image path
      });

      print(_profileImagePath);
      // Ensure _profileImagePath is not null before passing it

      if (_profileImagePath != null) {
        print('yes1');
        String? errorMessage =
            await Provider.of<AuthProvider>(context, listen: false)
                .uploadProfilePicture(
                    _profileImagePath!); // Use ! to assert it's not null
        print('yes2');

        if (errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile picture updated successfully.')),
          );
        }
      }
    }
  }

  void _updateUsername(AuthProvider authProvider) {
    // Update username logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Username updated successfully.')),
    );
  }

  void _updateEmail(AuthProvider authProvider) {
    // Update email logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email updated successfully.')),
    );
  }

  void _updatePassword(AuthProvider authProvider) {
    // Update password logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password updated successfully.')),
    );
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
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle account deletion
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account deleted successfully.')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
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
