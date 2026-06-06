import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';

class RepoListTileWidget extends StatelessWidget {
  const RepoListTileWidget({
    super.key,
    required this.repo,
    required this.onTap,
  });

  final GitHubRepoModel repo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    repo.name,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (repo.fork)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Text(
                      'Fork',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            if (repo.description != null && repo.description!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                repo.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                if (repo.language != null && repo.language!.isNotEmpty) ...[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.accentGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    repo.language!,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                const Icon(
                  Icons.star_outline,
                  color: AppColors.secondaryText,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  CountFormatingUtill.compactCount(repo.stargazersCount),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
