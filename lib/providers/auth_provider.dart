import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:habbit_breaker/main.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/services/workmanger_service.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  User? get user => _user;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<String?> signup(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      if (_user != null) {
        await _user?.updateProfile(
            displayName: '$firstName $lastName',
            photoURL: 'https://www.gravatar.com/avatar/placeholder');

        await _user?.reload();
        _user = _firebaseAuth.currentUser;

        notifyListeners();
        return null;
      } else {
        return "User creation failed. Please try again.";
      }
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      BuildContext context = navigatorKey.currentContext!;
      final settingsProvider = Provider.of<SettingsProvider>(context);
      settingsProvider.resetDailyNotification();
      ManagerService.cancelDailyNotification();
      _user = null;
      notifyListeners();
    } catch (e) {
      debugPrint("error in the logout");
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  Future<String?> uploadProfilePicture(String filePath) async {
    File file = File(filePath);
    if (!await file.exists()) {
      return "File does not exist.";
    }

    String filePathInStorage = 'user_profile_pictures/${_user?.uid}.png';

    try {
      TaskSnapshot snapshot =
          await _firebaseStorage.ref(filePathInStorage).putFile(file);

      if (snapshot.state == TaskState.success) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _user?.updatePhotoURL(downloadUrl);
        await _user?.reload();
        _user = _firebaseAuth.currentUser;
        notifyListeners();
        return null;
      } else {
        return "Failed to upload profile picture: ${snapshot.state}";
      }
    } catch (e) {
      return "Failed to upload profile picture: $e";
    }
  }

  Future<String?> updateProfile({
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      if (username != null && username.isNotEmpty) {
        await _user!.updateDisplayName(username);
      }
      if (password != null && password.isNotEmpty) {
        await _user!.updatePassword(password);
      }
      if (email != null && email.isNotEmpty) {
        await _user!.verifyBeforeUpdateEmail(email);
        return "A verification link has been sent to your new email. Please verify to complete the update.";
      }
      await _user!.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();

      return null;
    } catch (e) {
      return "Failed to update profile: $e";
    }
  }

  Future<String?> updateUserName(String username) async {
    try {
      await _user!.updateDisplayName(username);
      await _user!.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
      return null;
    } catch (e) {
      return "Failed to update user name: $e";
    }
  }

  Future<String?> deleteAccount() async {
    try {
      notifyListeners();
      return null;
    } catch (e) {
      return "Failed to delete account: $e";
    }
  }

  Future<String?> updateEmail(String email) async {
    try {
      await _user!.verifyBeforeUpdateEmail(email);
      await _user!.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
      return null;
    } catch (e) {
      return "Failed to update user name: $e";
    }
  }

  Future<String?> updatePassword(String password) async {
    try {
      await _user!.updatePassword(password);
      await _user!.reload();
      _user = _firebaseAuth.currentUser;
      notifyListeners();
      return null;
    } catch (e) {
      return "Failed to update user name: $e";
    }
  }

  bool isAuthenticated() {
    return _user != null;
  }

  String getUserEmail() {
    return _user?.email ?? "No Email";
  }

  String getUserName() {
    return _user?.displayName ?? "No Name";
  }

  String getUserPhoto() {
    return _user?.photoURL ?? "https://www.gravatar.com/avatar/placeholder";
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "The email is already registered. Please log in.";
      case 'invalid-email':
        return "The email address is not valid.";
      case 'weak-password':
        return "The password is too weak. Please use a stronger password.";
      case 'user-disabled':
        return "This account has been disabled.";
      case 'invalid-credential':
        return "Oops! Those credentials don't seem to match. Try again.";
      default:
        return "An error occurred. Please try again later.";
    }
  }
}
