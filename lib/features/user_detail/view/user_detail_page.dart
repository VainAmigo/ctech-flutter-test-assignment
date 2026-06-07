import 'package:ctech_flutter_test_app/components/components.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/l10n/l10n_extension.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key, required this.login});

  final String login;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailCubit>().loadUser(widget.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
            return LoadErrorWidget(
              title: l10n.profileLoadError,
              message: NetworkErrorMapper.message(state.error),
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
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProfileHeaderCard(user: user),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StatCard(
                icon: Icon(
                  Icons.people_outline,
                  color: AppColors.secondaryText,
                  size: 20,
                ),
                value: CountFormatingUtill.compactCount(user.followers),
                label: l10n.followers,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.secondaryText,
                  size: 20,
                ),
                value: CountFormatingUtill.compactCount(user.following),
                label: l10n.following,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StatCard(
          icon: SvgPicture.asset(
            'assets/icons/repos_icon.svg',
            colorFilter: const ColorFilter.mode(
              AppColors.secondaryText,
              BlendMode.srcIn,
            ),
          ),
          value: CountFormatingUtill.compactCount(user.publicRepos),
          label: l10n.publicRepos,
          onTap: () => Navigator.pushNamed(
            context,
            AppRouter.reposListPage,
            arguments: ReposListPageArgs(
              login: user.login,
              reposUrl: user.reposUrl,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AboutSection(user: user),
        const SizedBox(height: 16),
      ],
    );
  }
}
