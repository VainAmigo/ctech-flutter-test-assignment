import 'package:ctech_flutter_test_app/core/theme/app_colors.dart';
import 'package:ctech_flutter_test_app/features/user_detail/widgets/section_card.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  final Widget? icon;
  final String value;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SectionCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceLight,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: icon!,
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (onTap != null)
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.secondaryText,
                    size: 16,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
