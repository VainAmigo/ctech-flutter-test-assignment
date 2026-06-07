import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dioClient = DioClient();
  final connectivityService = ConnectivityService();
  final repository = AppRepository(dioClient, connectivityService);

  runApp(
    GitHubUsersApp(
      repository: repository,
      connectivityService: connectivityService,
    ),
  );
}

class GitHubUsersApp extends StatelessWidget {
  const GitHubUsersApp({
    super.key,
    required this.repository,
    required this.connectivityService,
  });

  final AppRepository repository;
  final ConnectivityService connectivityService;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppRepository>.value(
      value: repository,
      child: BlocProvider<UsersListCubit>(
        create: (_) => UsersListCubit(repository),
        child: MaterialApp(
          scaffoldMessengerKey: AppMessenger.messengerKey,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: const UsersListPage(),
          title: 'GitHub Users',
          theme: AppTheme.dark,
          builder: (context, child) => ConnectivityListener(
            connectivityService: connectivityService,
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
