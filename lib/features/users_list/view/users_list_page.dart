import 'package:ctech_flutter_test_app/source/models/github_user_model.dart';
import 'package:ctech_flutter_test_app/source/repositories/app_repository.dart';
import 'package:ctech_flutter_test_app/features/user_detail/cubit/user_detail_cubit.dart';
import 'package:ctech_flutter_test_app/features/user_detail/view/user_detail_page.dart';
import 'package:ctech_flutter_test_app/features/users_list/cubit/users_list_cubit.dart';
import 'package:ctech_flutter_test_app/features/users_list/cubit/users_list_state.dart';
import 'package:ctech_flutter_test_app/features/users_list/widgets/user_list_tile.dart';
import 'package:ctech_flutter_test_app/features/users_list/widgets/user_skeleton_tile.dart';
import 'package:ctech_flutter_test_app/features/users_list/widgets/users_bottom_nav.dart';
import 'package:ctech_flutter_test_app/features/users_list/widgets/users_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _scrollController = ScrollController();
  UsersNavTab _activeTab = UsersNavTab.explore;

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

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<UsersListCubit>().loadNextPage();
    }
  }

  void _openUserDetail(GitHubUserModel user) {
    final repository = context.read<AppRepository>();

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) => UserDetailCubit(repository)..loadUser(user.login),
          child: UserDetailPage(login: user.login),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GitHub Users',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          UsersSearchBar(
            onChanged: context.read<UsersListCubit>().search,
          ),
          Expanded(
            child: BlocBuilder<UsersListCubit, UsersListState>(
              builder: (context, state) {
                if (state.status == UsersListStatus.loading &&
                    state.users.isEmpty) {
                  return ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) => const UserSkeletonTile(),
                  );
                }

                if (state.status == UsersListStatus.failure &&
                    state.users.isEmpty) {
                  return _ErrorView(
                    message: state.errorMessage,
                    onRetry: () =>
                        context.read<UsersListCubit>().refresh(),
                  );
                }

                final users = state.visibleUsers;
                if (users.isEmpty) {
                  return const Center(child: Text('Пользователи не найдены'));
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<UsersListCubit>().refresh(),
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: users.length + (state.hasMore ? 2 : 0),
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index >= users.length) {
                        return const UserSkeletonTile();
                      }

                      final user = users[index];
                      return UserListTile(
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
      bottomNavigationBar: UsersBottomNav(
        activeTab: _activeTab,
        onTabSelected: (tab) {
          if (tab != UsersNavTab.explore) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Раздел в разработке')),
            );
            return;
          }
          setState(() => _activeTab = tab);
        },
      ),
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
              'Ошибка загрузки',
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
