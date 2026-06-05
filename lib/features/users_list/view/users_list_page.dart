import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UsersListCubit>().loadFirstPage();
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
        title: const Text(
          'GitHub Users',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          UsersSearchBarWidget(
            onChanged: context.read<UsersListCubit>().search,
          ),
          Expanded(
            child: BlocBuilder<UsersListCubit, UsersListState>(
              builder: (context, state) {
                if (state.status == UsersListStatus.loading &&
                    state.users.isEmpty) {
                  return ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) =>
                        const UserSkeletonTileWidget(),
                  );
                }

                if (state.status == UsersListStatus.failure &&
                    state.users.isEmpty) {
                  return _ErrorView(
                    message: state.errorMessage,
                    onRetry: () => context.read<UsersListCubit>().refresh(),
                  );
                }

                final users = state.visibleUsers;
                if (users.isEmpty) {
                  return const Center(child: Text('Пользователи не найдены'));
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<UsersListCubit>().refresh(),
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: users.length + (state.hasMore ? 2 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      if (index >= users.length) {
                        return const UserSkeletonTileWidget();
                      }

                      final user = users[index];
                      return UserListTileWidget(
                        user: user,
                        onTap: () => _openUserDetail(user),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<UsersListCubit>().loadNextPage();
    }
  }

  void _openUserDetail(GitHubUserModel user) {
    Navigator.pushNamed(
      context,
      AppRouter.userDetailPage,
      arguments: user.login,
    );
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
              'Ошибка загрузки',
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
