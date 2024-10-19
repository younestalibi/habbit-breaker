// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Habit Breaker`
  String get appTitle {
    return Intl.message(
      'Habit Breaker',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Habit Breaker`
  String get welcomeMessage {
    return Intl.message(
      'Welcome to Habit Breaker',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `:Hour`
  String get hour {
    return Intl.message(
      ':Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `:Minute`
  String get minute {
    return Intl.message(
      ':Minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `:Second`
  String get second {
    return Intl.message(
      ':Second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `You have relapsed today! 🤡`
  String get you_have_relapsed_today {
    return Intl.message(
      'You have relapsed today! 🤡',
      name: 'you_have_relapsed_today',
      desc: '',
      args: [],
    );
  }

  /// `Reset the counter`
  String get reset_counter {
    return Intl.message(
      'Reset the counter',
      name: 'reset_counter',
      desc: '',
      args: [],
    );
  }

  /// `Add relapse`
  String get add_relapse {
    return Intl.message(
      'Add relapse',
      name: 'add_relapse',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset the counter?`
  String get confirm_reset_counter {
    return Intl.message(
      'Are you sure you want to reset the counter?',
      name: 'confirm_reset_counter',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to add relapse?`
  String get confirm_add_relapse {
    return Intl.message(
      'Are you sure you want to add relapse?',
      name: 'confirm_add_relapse',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
