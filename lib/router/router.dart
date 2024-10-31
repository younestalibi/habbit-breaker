import 'package:flutter/material.dart';
import 'package:habbit_breaker/screens/articles_list_screen.dart';
import 'package:habbit_breaker/screens/language_selection_screen.dart';
import 'package:habbit_breaker/screens/layout_screen.dart';
import 'package:habbit_breaker/screens/onboarding_screen.dart';
import 'package:habbit_breaker/screens/profile_setting_screen.dart';
import 'package:habbit_breaker/screens/setting_screen.dart';
import 'package:habbit_breaker/screens/signin_screen.dart';
import 'package:habbit_breaker/screens/signup_screen.dart';
import 'package:habbit_breaker/screens/splash_screen.dart';
import 'package:habbit_breaker/screens/tracker_screen.dart';

class CustomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/layout':
        return MaterialPageRoute(builder: (_) => LayoutScreen());
      case '/language':
        return MaterialPageRoute(builder: (_) => LanguageSelectionScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/tracker':
        return MaterialPageRoute(builder: (_) => TrackerScreen());
      case '/settings/profile':
        return MaterialPageRoute(builder: (_) => ProfileSettingsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/articles':
        return MaterialPageRoute(builder: (_) => ArticlesListScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => SplashScreen()); // or an error page
    }
  }
}
