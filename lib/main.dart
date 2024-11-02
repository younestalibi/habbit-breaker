import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habbit_breaker/firebase_options.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/setting_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/providers/ui_provider.dart';
import 'package:habbit_breaker/router/router.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String languageCode = SharedPrefs.instance.getStringData('languageCode');
  bool isDark = SharedPrefs.instance.getBoolData('isDark');

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => TrackerProvider()),
          // ChangeNotifierProvider(create: (context) => UiProvider()..init()),
          ChangeNotifierProvider(
              create: (context) => SettingsProvider()..init()),
        ],
        child: Consumer<SettingsProvider>(builder: (context, settings, child) {
          return MaterialApp(
            theme: settings.isDark ? settings.darkTheme : settings.lightTheme,
            title: 'Habit Breaker',
            initialRoute: '/home',
            onGenerateRoute: CustomeRouter.generateRoute,
            locale: languageCode.isEmpty
                ? const Locale('en')
                : Locale(languageCode),
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
