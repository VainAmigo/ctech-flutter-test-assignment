import 'package:ctech_flutter_test_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppMessenger {
  const AppMessenger._();

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    _show(message, backgroundColor: AppColors.error);
  }

  static void showInfo(String message) {
    _show(message, backgroundColor: AppColors.accent);
  }

  static void showSuccess(String message) {
    _show(message, backgroundColor: AppColors.accentGreen);
  }

  static void _show(String message, {required Color backgroundColor}) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
