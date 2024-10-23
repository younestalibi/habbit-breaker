// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(userName) => "Welcome ${userName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_relapse": MessageLookupByLibrary.simpleMessage("Add relapse"),
        "appName": MessageLookupByLibrary.simpleMessage("Habit Breaker"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_add_relapse": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to add relapse?"),
        "confirm_reset_counter": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to reset the counter?"),
        "days": MessageLookupByLibrary.simpleMessage("Days"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enter_email": MessageLookupByLibrary.simpleMessage("Enter your email"),
        "first_name": MessageLookupByLibrary.simpleMessage("First Name"),
        "forget_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "have_account":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "have_no_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "hour": MessageLookupByLibrary.simpleMessage(":Hour"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
        "minute": MessageLookupByLibrary.simpleMessage(":Minute"),
        "pageHomeWelcomeFullName": m0,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_reset_sent":
            MessageLookupByLibrary.simpleMessage("Password reset email sent!"),
        "please_enter_email":
            MessageLookupByLibrary.simpleMessage("Please enter your email."),
        "please_enter_first_name": MessageLookupByLibrary.simpleMessage(
            "Please enter your first name."),
        "please_enter_last_name": MessageLookupByLibrary.simpleMessage(
            "Please enter your last name."),
        "please_enter_password":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "please_select_gender":
            MessageLookupByLibrary.simpleMessage("Please select your gender."),
        "reset_counter":
            MessageLookupByLibrary.simpleMessage("Reset the counter"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "second": MessageLookupByLibrary.simpleMessage(":Second"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "select_gender": MessageLookupByLibrary.simpleMessage("Select Gender"),
        "send_reset_link":
            MessageLookupByLibrary.simpleMessage("Send Reset Link"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "you_have_relapsed_today":
            MessageLookupByLibrary.simpleMessage("You have relapsed today! 🤡")
      };
}
