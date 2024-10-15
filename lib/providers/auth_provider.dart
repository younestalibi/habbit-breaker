import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habbit_breaker/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  UserModel? _userModel;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _user;
  UserModel? get userModel => _userModel;

  AuthProvider() {
    // Listen for changes in authentication state
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  String getUserEmail() {
    return _user?.email ?? "No Email";
  }

  String getUserName() {
    return _userModel?.firstName ?? "No Name";
  }

  String getUserImage() {
    return _user?.photoURL ?? 'https://www.gravatar.com/avatar/placeholder';
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
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
        await _firestore.collection('users').doc(_user!.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender,
          'email': email,
        });

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

  // Login function
  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      if (_user != null) {
        await _fetchUserData(_user!.uid);
      }

      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        _userModel = UserModel(
          firstName: data?['firstName'] ?? '',
          lastName: data?['lastName'] ?? '',
          gender: data?['gender'] ?? '',
          email: data?['email'] ?? '',
        );
        notifyListeners();
      }
    } catch (e) {
      throw "Error fetching user data";
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _user = null;
    _userModel = null;
    notifyListeners();
  }

  bool isAuthenticated() {
    return _user != null;
  }

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
