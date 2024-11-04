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

  /// `Password reset email is sent!`
  String get password_reset_sent {
    return Intl.message(
      'Password reset email is sent!',
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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get home {
    return Intl.message(
      'Home Page',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Relapse`
  String get relapse {
    return Intl.message(
      'Relapse',
      name: 'relapse',
      desc: '',
      args: [],
    );
  }

  /// `Recovery time`
  String get recovery_time {
    return Intl.message(
      'Recovery time',
      name: 'recovery_time',
      desc: '',
      args: [],
    );
  }

  /// `Longest`
  String get longest {
    return Intl.message(
      'Longest',
      name: 'longest',
      desc: '',
      args: [],
    );
  }

  /// `Enable Dark Theme`
  String get enable_dark_theme {
    return Intl.message(
      'Enable Dark Theme',
      name: 'enable_dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get enable_notifications {
    return Intl.message(
      'Enable Notifications',
      name: 'enable_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings`
  String get profile_setting {
    return Intl.message(
      'Profile settings',
      name: 'profile_setting',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Article about {category}`
  String article_about(Object category) {
    return Intl.message(
      'Article about $category',
      name: 'article_about',
      desc: '',
      args: [category],
    );
  }

  /// `Articles for you`
  String get articles_for_you {
    return Intl.message(
      'Articles for you',
      name: 'articles_for_you',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get see_more {
    return Intl.message(
      'See more',
      name: 'see_more',
      desc: '',
      args: [],
    );
  }

  /// `Today's quote`
  String get today_quote {
    return Intl.message(
      'Today\'s quote',
      name: 'today_quote',
      desc: '',
      args: [],
    );
  }

  /// `Language setting`
  String get language_setting {
    return Intl.message(
      'Language setting',
      name: 'language_setting',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Special for you`
  String get special_for_you {
    return Intl.message(
      'Special for you',
      name: 'special_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message(
      'Saving',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `View The Progress`
  String get view_progress {
    return Intl.message(
      'View The Progress',
      name: 'view_progress',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Language changed successfully to {selectedLanguage}`
  String changed_language_success(Object selectedLanguage) {
    return Intl.message(
      'Language changed successfully to $selectedLanguage',
      name: 'changed_language_success',
      desc: '',
      args: [selectedLanguage],
    );
  }

  /// `A verification link has been sent to your new email. Please verify to complete the update.`
  String get email_link_sent {
    return Intl.message(
      'A verification link has been sent to your new email. Please verify to complete the update.',
      name: 'email_link_sent',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully!`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile updated successfully!',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get no_data_available {
    return Intl.message(
      'No data available',
      name: 'no_data_available',
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
