import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/router/router.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  print('notification is presssed');
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
}

class MyApp extends StatelessWidget {
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
