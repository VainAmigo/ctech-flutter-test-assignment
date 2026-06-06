import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class ReposListPageArgs {
  const ReposListPageArgs({
    required this.login,
    required this.reposUrl,
  });

  final String login;
  final String reposUrl;
}

class ReposListPage extends StatefulWidget {
  const ReposListPage({
    super.key,
    required this.login,
    required this.reposUrl,
  });

  final String login;
  final String reposUrl;

  @override
  State<ReposListPage> createState() => _ReposListPageState();
}

class _ReposListPageState extends State<ReposListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ReposListCubit>().loadRepos(widget.reposUrl);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Repos · ${widget.login}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<ReposListCubit, ReposListState>(
        builder: (context, state) {
          if (state.status == ReposListStatus.loading && state.repos.isEmpty) {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => const RepoSkeletonTileWidget(),
            );
          }

          if (state.status == ReposListStatus.failure && state.repos.isEmpty) {
            return _ErrorView(
              message: state.errorMessage,
              onRetry: () => context.read<ReposListCubit>().refresh(),
            );
          }

          if (state.repos.isEmpty) {
            return const Center(child: Text('Репозитории не найдены'));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<ReposListCubit>().refresh(),
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.repos.length + (state.hasMore ? 2 : 0),
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.border,
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                if (index >= state.repos.length) {
                  return const RepoSkeletonTileWidget();
                }

                final repo = state.repos[index];
                return RepoListTileWidget(
                  repo: repo,
                  onTap: () => AppLaunch.launchURL(repo.htmlUrl),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<ReposListCubit>().loadNextPage();
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

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
              'Не удалось загрузить репозитории',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(message ?? 'Unknown error', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Повторить')),
          ],
        ),
      ),
    );
  }
}
