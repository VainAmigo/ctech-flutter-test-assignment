import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/l10n/l10n_extension.dart';
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
        decoration: InputDecoration(
          hintText: context.l10n.searchUsersHint,
          prefixIcon: const Icon(Icons.search, color: AppColors.secondaryText),
        ),
      ),
    );
  }
}
