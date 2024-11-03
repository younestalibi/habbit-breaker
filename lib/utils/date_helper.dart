import 'package:flutter/material.dart';
import 'package:habbit_breaker/generated/l10n.dart';

class DateHelper {
  static String formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  static String formatDays(int days) {
    if (days >= 500) {
      return "$days/1000";
    } else if (days >= 400) {
      return "$days/500";
    } else if (days >= 300) {
      return "$days/400";
    } else if (days >= 200) {
      return "$days/300";
    } else if (days >= 120) {
      return "$days/200";
    } else if (days >= 90) {
      return "$days/120";
    } else if (days >= 30) {
      return "$days/90";
    } else if (days >= 15) {
      return "$days/30";
    } else if (days >= 7) {
      return "$days/15";
    } else if (days < 7) {
      return "$days/7";
    } else {
      return days.toString();
    }
  }

  static String getLocalizedLabel(BuildContext context, String label) {
    switch (label) {
      case 'hour':
        return S.of(context).hour;
      case 'minute':
        return S.of(context).minute;
      case 'second':
        return S.of(context).second;
      default:
        return '';
    }
  }

  static bool isAtLeast24HoursApart(DateTime? firstDate, DateTime? secondDate) {
    if (firstDate == null || secondDate == null) {
      return false;
    }
    Duration difference = secondDate.difference(firstDate);
    return difference.inHours >= 24;
  }
}
