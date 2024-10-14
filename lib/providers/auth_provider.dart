import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _user;

  AuthProvider() {
    // Listen for changes in authentication state
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign up function with improved error handling
  Future<String?> signup(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return null; // Sign-up successful
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e); // Handle Firebase-specific errors
    } catch (e) {
      return "An unknown error occurred. Please try again."; // General error
    }
  }

  // Login function with improved error handling
  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return null; // Login successful
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e); // Handle Firebase-specific errors
    } catch (e) {
      return "An unknown error occurred. Please try again."; // General error
    }
  }

  // Logout function
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }

  // Check if the user is authenticated
  bool isAuthenticated() {
    return _user != null;
  }

  // Handle Firebase authentication errors
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "The email is already registered. Please log in.";
      case 'invalid-email':
        return "The email address is not valid.";
      case 'operation-not-allowed':
        return "Email/password accounts are not enabled.";
      case 'weak-password':
        return "The password is too weak. Please use a stronger password.";
      case 'user-disabled':
        return "This account has been disabled.";
      case 'user-not-found':
        return "No account found for this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      default:
        return "An error occurred. Please try again later.";
    }
  }
}
