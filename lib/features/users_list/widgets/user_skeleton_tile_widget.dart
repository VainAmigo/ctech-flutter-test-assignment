import 'package:ctech_flutter_test_app/components/components.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:flutter/material.dart';

class UserSkeletonTileWidget extends StatelessWidget {
  const UserSkeletonTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.skeleton,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 14),
            Container(
              height: 14,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.skeleton,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Spacer(),
            Container(
              height: 24,
              width: 24,
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
