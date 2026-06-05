import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:flutter/material.dart';

enum UsersNavTab { explore, favorites, settings }

class UsersBottomNav extends StatelessWidget {
  const UsersBottomNav({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final UsersNavTab activeTab;
  final ValueChanged<UsersNavTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            label: 'Explore',
            icon: Icons.explore_outlined,
            isActive: activeTab == UsersNavTab.explore,
            onTap: () => onTabSelected(UsersNavTab.explore),
          ),
          _NavItem(
            label: 'Favorites',
            icon: Icons.star_outline,
            isActive: activeTab == UsersNavTab.favorites,
            onTap: () => onTabSelected(UsersNavTab.favorites),
          ),
          _NavItem(
            label: 'Settings',
            icon: Icons.settings_outlined,
            isActive: activeTab == UsersNavTab.settings,
            onTap: () => onTabSelected(UsersNavTab.settings),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primaryText : AppColors.secondaryText;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.surfaceLight : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
