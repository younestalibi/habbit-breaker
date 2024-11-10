import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/router/router.dart';
import 'package:habbit_breaker/services/notification_service.dart';
import 'package:habbit_breaker/services/workmanger_service.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/auth_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharedPrefs.instance.init();
    debugPrint("Shared Preferences initialized.");
  } catch (e) {
    debugPrint("Error initializing Shared Preferences: $e");
  }

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint("Firebase initialized.");
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }

  try {
    Workmanager()
        .initialize(ManagerService.callbackDispatcher, isInDebugMode: true);
    debugPrint("Workmanager initialized.");
  } catch (e) {
    debugPrint("Error initializing Workmanager: $e");
  }

  try {
    await NotificationService.init();
    debugPrint("Notification Service initialized.");
  } catch (e) {
    debugPrint("Error initializing Notification Service: $e");
  }

  try {
    await NotificationService.askForNotificationPermission();
    debugPrint("Notification permission requested.");
  } catch (e) {
    debugPrint("Error requesting notification permission: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => TrackerProvider()),
          ChangeNotifierProvider(
              create: (context) => SettingsProvider()..init()),
        ],
        child: Consumer<SettingsProvider>(builder: (context, settings, child) {
          return MaterialApp(
            title: 'Habit Breaker',
            initialRoute: '/',
            onGenerateRoute: CustomeRouter.generateRoute,
            theme: settings.isDark ? settings.darkTheme : settings.lightTheme,
            debugShowCheckedModeBanner: false,
            locale: Locale(settings.languageCode),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            navigatorKey: navigatorKey,
          );
        }));
  }
}
