import 'package:ctech_flutter_test_app/core/utils/platform/adaptive_navigation_util.dart';
import 'package:ctech_flutter_test_app/features/repos_list/cubit/repos_list_cubit.dart';
import 'package:ctech_flutter_test_app/features/repos_list/view/repos_list_page.dart';
import 'package:ctech_flutter_test_app/features/user_detail/cubit/user_detail_cubit.dart';
import 'package:ctech_flutter_test_app/features/user_detail/view/user_detail_page.dart';
import 'package:ctech_flutter_test_app/features/users_list/view/users_list_page.dart';
import 'package:ctech_flutter_test_app/source/repositories/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class AppRouter {
  const AppRouter._();

  static const usersListPage = '/users-list-page';
  static const userDetailPage = '/user-detail-page';
  static const reposListPage = '/repos-list-page';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      usersListPage || '/' => platformRoute(
        settings: settings,
        builder: (_) => const UsersListPage(),
      ),
      userDetailPage => platformRoute(
        settings: settings,
        builder: (context) => BlocProvider(
          create: (context) => UserDetailCubit(context.read<AppRepository>()),
          child: UserDetailPage(login: settings.arguments! as String),
        ),
      ),
      reposListPage => platformRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments! as ReposListPageArgs;
          return BlocProvider(
            create: (context) => ReposListCubit(context.read<AppRepository>()),
            child: ReposListPage(
              login: args.login,
              reposUrl: args.reposUrl,
            ),
          );
        },
      ),
      _ => throw Exception(
        'No builder specified for route named: [${settings.name}]',
      ),
    };
  }
}
