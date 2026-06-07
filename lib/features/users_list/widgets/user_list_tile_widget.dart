import 'package:ctech_flutter_test_app/components/components.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';

class UserListTileWidget extends StatelessWidget {
  const UserListTileWidget({super.key, required this.user, required this.onTap});

  final GitHubUserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            UserAvatar(
              avatarUrl: user.avatarUrl,
              login: user.login,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                user.login,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.secondaryText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
