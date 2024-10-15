import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated()) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello and Welcome')),
    );
  }
}
