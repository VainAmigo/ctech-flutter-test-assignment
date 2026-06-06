import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
final class AppLaunch {
  const AppLaunch._();

  static Future<void> sendEmail(
    String email, {
    String? snackBarText,
    BuildContext? context,
  }) async {
    try {
      final isSuccess = await launchUrl(Uri(scheme: 'mailto', path: email));
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> call(
    String phone, {
    String? snackBarText,
    BuildContext? context,
  }) async {
    try {
      final isSuccess = await launchUrl(Uri.parse('tel:$phone'));
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> sendTelegram(
    String username, {
    String? snackBarText,
    BuildContext? context,
  }) async {
    try {
      final isSuccess = await launchUrl(
        Uri.parse('https://telegram.me/$username'),
        mode: LaunchMode.externalApplication,
      );
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> sendWhatsApp(
    String whatsapp, {
    String? defaultText,
    String? snackBarText,
    BuildContext? context,
  }) async {
    try {
      final isSuccess = await launchUrl(
        Uri.parse(
          'whatsapp://send?phone=$whatsapp${defaultText != null ? '&text=${Uri.encodeComponent(defaultText)}' : ''}',
        ),
        mode: LaunchMode.externalApplication,
      );
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> launchURL(
    String url, {
    String? snackBarText,
    BuildContext? context,
  }) async {
    try {
      final isSuccess = await launchUrl(Uri.parse(url));
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }
}
