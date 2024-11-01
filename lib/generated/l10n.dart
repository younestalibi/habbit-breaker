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
  String get appName {
    return Intl.message(
      'Habit Breaker',
      name: 'appName',
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

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forget_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent!`
  String get password_reset_sent {
    return Intl.message(
      'Password reset email sent!',
      name: 'password_reset_sent',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get send_reset_link {
    return Intl.message(
      'Send Reset Link',
      name: 'send_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get have_no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'have_no_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email.`
  String get please_enter_email {
    return Intl.message(
      'Please enter your email.',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name.`
  String get please_enter_first_name {
    return Intl.message(
      'Please enter your first name.',
      name: 'please_enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name.`
  String get please_enter_last_name {
    return Intl.message(
      'Please enter your last name.',
      name: 'please_enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get select_gender {
    return Intl.message(
      'Select Gender',
      name: 'select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gender.`
  String get please_select_gender {
    return Intl.message(
      'Please select your gender.',
      name: 'please_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get have_account {
    return Intl.message(
      'Already have an account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {userName}`
  String pageHomeWelcomeFullName(Object userName) {
    return Intl.message(
      'Welcome $userName',
      name: 'pageHomeWelcomeFullName',
      desc: '',
      args: [userName],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
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
