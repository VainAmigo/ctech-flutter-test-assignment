import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/user_detail/widgets/section_card.dart';
import 'package:ctech_flutter_test_app/source/models/github_user_detail_model.dart';
import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final GitHubUserDetailModel user;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              UserAvatar(
                avatarUrl: user.avatarUrl,
                login: user.login,
                radius: 52,
                fallbackFontSize: 28,
                fallbackFontWeight: FontWeight.w700,
              ),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            user.displayName,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => AppLaunch.launchURL(user.htmlUrl),
            child: Text(
              '@${user.login}',
              style: const TextStyle(color: AppColors.accent, fontSize: 15),
            ),
          ),
          if (user.bio != null && user.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              user.bio!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.secondaryText),
            ),
          ],
        ],
      ),
    );
  }
}
