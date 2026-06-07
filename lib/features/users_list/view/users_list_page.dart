import 'package:ctech_flutter_test_app/components/components.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/l10n/l10n_extension.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  late final ScrollPaginationController _pagination;

  @override
  void initState() {
    super.initState();
    _pagination = ScrollPaginationController(
      onLoadMore: () => context.read<UsersListCubit>().loadNextPage(),
    )..attach();
    context.read<UsersListCubit>().loadFirstPage();
  }

  @override
  void dispose() {
    _pagination.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouter.settingsPage),
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settings,
          ),
        ],
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
                  return LoadErrorWidget(
                    title: l10n.loadError,
                    message: NetworkErrorMapper.message(state.error),
                    onRetry: () => context.read<UsersListCubit>().refresh(),
                  );
                }

                if (state.users.isEmpty) {
                  return Center(child: Text(l10n.usersNotFound));
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<UsersListCubit>().refresh(),
                  child: ListView.separated(
                    controller: _pagination.controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.users.length + (state.hasMore ? 2 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      if (index >= state.users.length) {
                        return const UserSkeletonTileWidget();
                      }

                      final user = state.users[index];
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

  void _openUserDetail(GitHubUserModel user) {
    Navigator.pushNamed(
      context,
      AppRouter.userDetailPage,
      arguments: user.login,
    );
  }
}
