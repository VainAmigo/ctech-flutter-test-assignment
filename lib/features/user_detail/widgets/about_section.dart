import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/models/github_user_detail_model.dart';
import 'package:ctech_flutter_test_app/features/user_detail/widgets/info_tile.dart';
import 'package:ctech_flutter_test_app/features/user_detail/widgets/section_card.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.user});

  final GitHubUserDetailModel user;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      if (user.company != null && user.company!.isNotEmpty)
        InfoTile(
          icon: Icons.business_outlined,
          title: user.company!,
          subtitle: 'Company (Компания)',
        ),
      if (user.location != null && user.location!.isNotEmpty)
        InfoTile(
          icon: Icons.location_on_outlined,
          title: user.location!,
          subtitle: 'Location (Местоположение)',
        ),
      if (user.blog != null && user.blog!.isNotEmpty)
        InfoTile(
          icon: Icons.link,
          title: user.blog!,
          subtitle: 'Website (Веб-сайт)',
          titleColor: AppColors.accent,
        ),
      InfoTile(
        icon: Icons.calendar_today_outlined,
        title: FormatUtils.joinedDate(user.createdAt),
        subtitle: 'Member since (В команде с)',
      ),
    ];

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1)
              const Divider(color: AppColors.border, height: 1),
          ],
        ],
      ),
    );
  }
}
