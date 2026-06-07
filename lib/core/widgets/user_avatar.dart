import 'package:ctech_flutter_test_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    required this.login,
    this.radius = 24,
    this.fallbackFontSize,
    this.fallbackFontWeight = FontWeight.w600,
  });

  final String avatarUrl;
  final String login;
  final double radius;
  final double? fallbackFontSize;
  final FontWeight fallbackFontWeight;

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarUrl.isNotEmpty;
    final initial = login.isNotEmpty ? login[0].toUpperCase() : '?';

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceLight,
      backgroundImage: hasAvatar ? NetworkImage(avatarUrl) : null,
      child: hasAvatar
          ? null
          : Text(
              initial,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: fallbackFontSize ?? radius * 0.58,
                fontWeight: fallbackFontWeight,
              ),
            ),
    );
  }
}
