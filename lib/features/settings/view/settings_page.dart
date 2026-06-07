import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/l10n/app_localizations.dart';
import 'package:ctech_flutter_test_app/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  l10n.language,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for (final preference in LocalePreference.values)
                ListTile(
                  title: Text(_languageLabel(l10n, preference)),
                  trailing: state.preference == preference
                      ? const Icon(Icons.check, color: AppColors.accent)
                      : null,
                  onTap: () =>
                      context.read<LocaleCubit>().setPreference(preference),
                ),
            ],
          );
        },
      ),
    );
  }

  String _languageLabel(AppLocalizations l10n, LocalePreference preference) {
    return switch (preference) {
      LocalePreference.system => l10n.languageSystem,
      LocalePreference.en => l10n.languageEnglish,
      LocalePreference.ru => l10n.languageRussian,
    };
  }
}
