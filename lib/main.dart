import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habbit_breaker/data/quotes.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/router/router.dart';
import 'package:habbit_breaker/services/notification_service.dart';
// import 'package:habbit_breaker/services/notification_service.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/auth_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharedPrefs.instance.init();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await NotificationService.init();
    await NotificationService.askForNotificationPermission();

    runApp(const MyApp());
  } catch (e) {
    print("Error during app initialization: $e");
  }
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final random = Random();
    // Get a random index within the range of the list length
    int randomIndex = random.nextInt(quotes['en']!.length);
    // Access the list element at the random index
    String randomElement = quotes['en']![randomIndex];
    print('hello world');
    print(randomElement);
    NotificationService.sendInstantNotification(
      title: "Reminder",
      body: 'hiii',
      payload: "Test payload 2",
    );
    print(
        "Native called kkbackground task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
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
