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

  static String m0(category) => "Article about ${category}";

  static String m1(selectedLanguage) =>
      "Language changed successfully to ${selectedLanguage}";

  static String m2(userName) => "Welcome ${userName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_relapse": MessageLookupByLibrary.simpleMessage("Add relapse"),
        "appName": MessageLookupByLibrary.simpleMessage("Habit Breaker"),
        "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "article_about": m0,
        "articles_for_you":
            MessageLookupByLibrary.simpleMessage("Articles for you"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changed_language_success": m1,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_add_relapse": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to add relapse?"),
        "confirm_reset_counter": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to reset the counter?"),
        "days": MessageLookupByLibrary.simpleMessage("Days"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_link_sent": MessageLookupByLibrary.simpleMessage(
            "A verification link has been sent to your new email. Please verify to complete the update."),
        "enable_dark_theme":
            MessageLookupByLibrary.simpleMessage("Enable Dark Theme"),
        "enable_notifications":
            MessageLookupByLibrary.simpleMessage("Enable Notifications"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enter_email": MessageLookupByLibrary.simpleMessage("Enter your email"),
        "first_name": MessageLookupByLibrary.simpleMessage("First Name"),
        "forget_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "get_started": MessageLookupByLibrary.simpleMessage("Get Started"),
        "have_account":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "have_no_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "home": MessageLookupByLibrary.simpleMessage("Home Page"),
        "hour": MessageLookupByLibrary.simpleMessage(":Hour"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "language_setting":
            MessageLookupByLibrary.simpleMessage("Language setting"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
        "longest": MessageLookupByLibrary.simpleMessage("Longest"),
        "minute": MessageLookupByLibrary.simpleMessage(":Minute"),
        "no_data_available":
            MessageLookupByLibrary.simpleMessage("No data available"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pageHomeWelcomeFullName": m2,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_reset_sent": MessageLookupByLibrary.simpleMessage(
            "Password reset email is sent!"),
        "please_enter_email":
            MessageLookupByLibrary.simpleMessage("Please enter your email."),
        "please_enter_first_name": MessageLookupByLibrary.simpleMessage(
            "Please enter your first name."),
        "please_enter_last_name": MessageLookupByLibrary.simpleMessage(
            "Please enter your last name."),
        "please_enter_password":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profile_setting":
            MessageLookupByLibrary.simpleMessage("Profile settings"),
        "profile_updated_successfully": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully!"),
        "progress": MessageLookupByLibrary.simpleMessage("Progress"),
        "recovery_time": MessageLookupByLibrary.simpleMessage("Recovery time"),
        "relapse": MessageLookupByLibrary.simpleMessage("Relapse"),
        "reset_counter":
            MessageLookupByLibrary.simpleMessage("Reset the counter"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saving": MessageLookupByLibrary.simpleMessage("Saving"),
        "second": MessageLookupByLibrary.simpleMessage(":Second"),
        "see_more": MessageLookupByLibrary.simpleMessage("See more"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "send_reset_link":
            MessageLookupByLibrary.simpleMessage("Send Reset Link"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "special_for_you":
            MessageLookupByLibrary.simpleMessage("Special for you"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "today_quote": MessageLookupByLibrary.simpleMessage("Today\'s quote"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "view_progress":
            MessageLookupByLibrary.simpleMessage("View The Progress"),
        "you_have_relapsed_today":
            MessageLookupByLibrary.simpleMessage("You have relapsed today! 🤡")
      };
}
