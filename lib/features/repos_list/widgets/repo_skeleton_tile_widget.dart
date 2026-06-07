import 'package:ctech_flutter_test_app/components/components.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:flutter/material.dart';

class RepoSkeletonTileWidget extends StatelessWidget {
  const RepoSkeletonTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 14,
              width: 160,
              decoration: BoxDecoration(
                color: AppColors.skeleton,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.skeleton,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 12,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.skeleton,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
