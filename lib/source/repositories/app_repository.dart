import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:ctech_flutter_test_app/source/endpoints/api_endpoints.dart';
import 'package:ctech_flutter_test_app/source/models/models.dart';

class AppRepository {
  AppRepository(
    this._dioClient, [
    ConnectivityService? connectivityService,
  ]) : _connectivity = connectivityService ?? ConnectivityService();

  final DioClient _dioClient;
  final ConnectivityService _connectivity;

  Future<void> _ensureConnected() async {
    if (!await _connectivity.hasConnection()) {
      throw const NoInternetException();
    }
  }

  /// GitHub /users использует cursor-пагинацию через [since] (ID последнего юзера).
  Future<List<GitHubUserModel>> getUsers({
    int? since,
    int perPage = ApiConst.usersPerPage,
  }) async {
    await _ensureConnected();

    final response = await _dioClient.get(
      ApiEndpoints.users,
      queryParameters: {
        'per_page': perPage,
        'since': ?since,
      },
    );

    final data = response.data as List<dynamic>;
    return data
        .map(
          (item) => GitHubUserModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  /// Глобальный поиск через GitHub Search API (page-пагинация).
  Future<GitHubUserSearchResponse> searchUsers({
    required String query,
    required int page,
    int perPage = ApiConst.usersPerPage,
  }) async {
    await _ensureConnected();

    final response = await _dioClient.get(
      ApiEndpoints.searchUsers,
      queryParameters: {
        'q': query,
        'page': page,
        'per_page': perPage,
      },
    );

    return GitHubUserSearchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<GitHubUserDetailModel> getUserDetail(String login) async {
    await _ensureConnected();

    final response = await _dioClient.get(ApiEndpoints.user(login));

    return GitHubUserDetailModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<List<GitHubRepoModel>> getUserRepos({
    required String reposUrl,
    required int page,
    int perPage = ApiConst.reposPerPage,
  }) async {
    await _ensureConnected();

    final response = await _dioClient.get(
      reposUrl,
      queryParameters: {
        'per_page': perPage,
        'page': page,
        'sort': 'updated',
      },
    );

    final data = response.data as List<dynamic>;
    return data
        .map(
          (item) => GitHubRepoModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
