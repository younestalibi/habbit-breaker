import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/screens/home_screen.dart';
import 'package:habbit_breaker/screens/language_selection_screen.dart';
import 'package:habbit_breaker/screens/onboarding_screen.dart';
import 'package:habbit_breaker/screens/signin_screen.dart';
import 'package:habbit_breaker/screens/signup_screen.dart';
import 'package:habbit_breaker/screens/splash_screen.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String languageCode = SharedPrefs.instance.getStringData('languageCode');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TrackerProvider()),
      ],
      child: MaterialApp(
        title: 'Habit Breaker',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/language': (context) => LanguageSelectionScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
        },
        locale:
            languageCode.isEmpty ? const Locale('en') : Locale(languageCode),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
