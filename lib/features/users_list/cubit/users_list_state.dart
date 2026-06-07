part of 'users_list_cubit.dart';

enum UsersListStatus { initial, loading, success, loadingMore, failure }

class UsersListState {
  const UsersListState({
    this.status = UsersListStatus.initial,
    this.users = const [],
    this.since,
    this.searchPage = 1,
    this.isSearchMode = false,
    this.hasMore = true,
    this.searchQuery = '',
    this.error,
  });

  final UsersListStatus status;
  final List<GitHubUserModel> users;
  final int? since;
  final int searchPage;
  final bool isSearchMode;
  final bool hasMore;
  final String searchQuery;
  final Object? error;

  UsersListState copyWith({
    UsersListStatus? status,
    List<GitHubUserModel>? users,
    int? since,
    int? searchPage,
    bool? isSearchMode,
    bool? hasMore,
    String? searchQuery,
    Object? error,
    bool clearSince = false,
    bool clearError = false,
  }) {
    return UsersListState(
      status: status ?? this.status,
      users: users ?? this.users,
      since: clearSince ? null : (since ?? this.since),
      searchPage: searchPage ?? this.searchPage,
      isSearchMode: isSearchMode ?? this.isSearchMode,
      hasMore: hasMore ?? this.hasMore,
      searchQuery: searchQuery ?? this.searchQuery,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
