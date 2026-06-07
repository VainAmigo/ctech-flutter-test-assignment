import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/features/features.dart';
import 'package:ctech_flutter_test_app/l10n/app_localizations.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);
  final dioClient = DioClient();
  final connectivityService = ConnectivityService();
  final repository = AppRepository(dioClient, connectivityService);
  final localeRepository = LocaleRepository();

  runApp(
    GitHubUsersApp(
      repository: repository,
      connectivityService: connectivityService,
      localeRepository: localeRepository,
    ),
  );
}

class GitHubUsersApp extends StatefulWidget {
  const GitHubUsersApp({
    super.key,
    required this.repository,
    required this.connectivityService,
    required this.localeRepository,
  });

  final AppRepository repository;
  final ConnectivityService connectivityService;
  final LocaleRepository localeRepository;

  @override
  State<GitHubUsersApp> createState() => _GitHubUsersAppState();
}

class _GitHubUsersAppState extends State<GitHubUsersApp> {

  @override
  void initState() {
    super.initState();
    _removeSplash();
  }

  Future<void> _removeSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AppRepository>.value(
      value: widget.repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LocaleCubit(widget.localeRepository)..load(),
          ),
          BlocProvider(
            create: (_) => UsersListCubit(widget.repository),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp(
              scaffoldMessengerKey: AppMessenger.messengerKey,
              onGenerateRoute: AppRouter.onGenerateRoute,
              home: const UsersListPage(),
              title: 'GitHub Users',
              theme: AppTheme.dark,
              locale: localeState.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => ConnectivityListener(
                connectivityService: widget.connectivityService,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }
}
