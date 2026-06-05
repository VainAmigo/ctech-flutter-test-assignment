import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:flutter/material.dart';

class UsersSearchBarWidget extends StatelessWidget {
  const UsersSearchBarWidget({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.primaryText),
        decoration: const InputDecoration(
          hintText: 'Поиск пользователей...',
          prefixIcon: Icon(Icons.search, color: AppColors.secondaryText),
        ),
      ),
    );
  }
}
