import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class DateFormatsUtil {
  static String formatDate(DateTime date, Locale locale) {
    return DateFormat.yMMMd(locale.toLanguageTag()).format(date);
  }
}
