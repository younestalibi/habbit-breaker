import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _user;

  AuthProvider() {
    // Listen for changes in authentication state
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<String?> signup(String email, String password, String firstName,
      String lastName, String gender) async {
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
      print(e.code);
      return _handleAuthError(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
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
    return _user?.photoURL ?? "No photo";
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
