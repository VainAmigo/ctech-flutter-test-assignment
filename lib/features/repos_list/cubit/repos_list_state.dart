part of 'repos_list_cubit.dart';

enum ReposListStatus { initial, loading, success, loadingMore, failure }

class ReposListState {
  const ReposListState({
    this.status = ReposListStatus.initial,
    this.repos = const [],
    this.reposUrl,
    this.page = 1,
    this.hasMore = true,
    this.error,
  });

  final ReposListStatus status;
  final List<GitHubRepoModel> repos;
  final String? reposUrl;
  final int page;
  final bool hasMore;
  final Object? error;

  ReposListState copyWith({
    ReposListStatus? status,
    List<GitHubRepoModel>? repos,
    String? reposUrl,
    int? page,
    bool? hasMore,
    Object? error,
    bool clearError = false,
  }) {
    return ReposListState(
      status: status ?? this.status,
      repos: repos ?? this.repos,
      reposUrl: reposUrl ?? this.reposUrl,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
