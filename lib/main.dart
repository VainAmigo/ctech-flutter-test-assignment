import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  final dioClient = DioClient();
  final repository = AppRepository(dioClient);

  runApp(GitHubUsersApp(repository: repository));
}

class GitHubUsersApp extends StatelessWidget {
  const GitHubUsersApp({super.key, required this.repository});

  final AppRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppRepository>.value(
      value: repository,
      child: BlocProvider<UsersListCubit>(
        create: (_) => UsersListCubit(repository),
        child: MaterialApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: const UsersListPage(),
          title: 'GitHub Users',
          theme: AppTheme.dark,
        ),
      ),
    );
  }
}
