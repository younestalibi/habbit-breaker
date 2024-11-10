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
      case '/dd':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/layout':
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case '/language':
        return MaterialPageRoute(
            builder: (_) => const LanguageSelectionScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/tracker':
        return MaterialPageRoute(builder: (_) => const TrackerScreen());
      case '/settings/profile':
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/articles':
        return MaterialPageRoute(builder: (_) => const ArticlesListScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
