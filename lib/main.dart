import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/screens/home_screen.dart';
import 'package:habbit_breaker/screens/signin_screen.dart';
import 'package:habbit_breaker/screens/signup_screen.dart';
import 'package:habbit_breaker/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
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
        },
      ),
    );
  }
}
