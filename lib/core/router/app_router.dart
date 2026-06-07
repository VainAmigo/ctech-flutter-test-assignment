import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
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
