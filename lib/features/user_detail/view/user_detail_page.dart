import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key, required this.login});

  final String login;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.login,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<UserDetailCubit, UserDetailState>(
        builder: (context, state) {
          if (state.status == UserDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == UserDetailStatus.failure || state.user == null) {
            return _ErrorView(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<UserDetailCubit>().loadUser(widget.login),
            );
          }

          return _UserDetailContent(user: state.user!);
        },
      ),
    );
  }
}

class _UserDetailContent extends StatelessWidget {
  const _UserDetailContent({required this.user});

  final GitHubUserDetailModel user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProfileHeaderCard(user: user),
        const SizedBox(height: 16),
        Row(
          children: [
            StatCard(
              icon: Icons.people_outline,
              value: CountFormatingUtill.compactCount(user.followers),
              label: 'Followers (Подписчики)',
            ),
            const SizedBox(width: 12),
            StatCard(
              icon: Icons.person_add_alt_1_outlined,
              value: CountFormatingUtill.compactCount(user.following),
              label: 'Following (Подписки)',
            ),
          ],
        ),
        const SizedBox(height: 16),
        AboutSection(user: user),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Не удалось загрузить профиль',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message ?? 'Unknown error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
