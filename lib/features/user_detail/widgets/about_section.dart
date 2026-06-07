import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/l10n/l10n_extension.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.user});

  final GitHubUserDetailModel user;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    final items = <Widget>[
      if (user.company != null && user.company!.isNotEmpty)
        InfoTile(
          icon: Icons.business_outlined,
          title: user.company!,
          subtitle: l10n.company,
        ),
      if (user.location != null && user.location!.isNotEmpty)
        InfoTile(
          icon: Icons.location_on_outlined,
          title: user.location!,
          subtitle: l10n.location,
        ),
      if (user.blog != null && user.blog!.isNotEmpty)
        InfoTile(
          icon: Icons.link,
          title: user.blog!,
          subtitle: l10n.website,
          titleColor: AppColors.accent,
          onTap: () => AppLaunch.launchURL(user.blog!),
        ),
      InfoTile(
        icon: Icons.calendar_today_outlined,
        title: DateFormatsUtil.formatDate(user.createdAt, locale),
        subtitle: l10n.memberSince,
      ),
    ];

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              l10n.about,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
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
