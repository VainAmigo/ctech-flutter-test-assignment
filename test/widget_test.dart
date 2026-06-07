import 'package:ctech_flutter_test_app/features/settings/cubit/locale_cubit.dart';
import 'package:ctech_flutter_test_app/features/settings/data/locale_repository.dart';
import 'package:ctech_flutter_test_app/features/users_list/cubit/users_list_cubit.dart';
import 'package:ctech_flutter_test_app/features/users_list/view/users_list_page.dart';
import 'package:ctech_flutter_test_app/l10n/app_localizations.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:ctech_flutter_test_app/source/models/github_user_detail_model.dart';
import 'package:ctech_flutter_test_app/source/models/github_user_model.dart';
import 'package:ctech_flutter_test_app/source/repositories/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeAppRepository extends AppRepository {
  _FakeAppRepository() : super(DioClient());

  @override
  Future<List<GitHubUserModel>> getUsers({
    int? since,
    int perPage = 20,
  }) async {
    return const [
      GitHubUserModel(
        id: 1,
        login: 'octocat',
        avatarUrl: '',
      ),
    ];
  }

  @override
  Future<GitHubUserDetailModel> getUserDetail(String login) async {
    return GitHubUserDetailModel(
      id: 1,
      login: login,
      avatarUrl: '',
      name: 'The Octocat',
      bio: 'GitHub mascot',
      company: 'GitHub',
      location: 'San Francisco',
      blog: 'https://github.blog',
      followers: 12500,
      following: 42,
      publicRepos: 8,
      createdAt: DateTime(2011, 1, 25),
      htmlUrl: 'https://api.github.com/users/octocat',
      reposUrl: 'https://api.github.com/users/octocat/repos',
    );
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Users list page shows loaded user', (WidgetTester tester) async {
    final repository = _FakeAppRepository();

    await tester.pumpWidget(
      RepositoryProvider<AppRepository>.value(
        value: repository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LocaleCubit(LocaleRepository()),
            ),
            BlocProvider(
              create: (_) => UsersListCubit(repository),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: const UsersListPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('GitHub Users'), findsOneWidget);
    expect(find.text('octocat'), findsOneWidget);
  });
}
