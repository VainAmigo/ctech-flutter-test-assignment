part of 'user_detail_cubit.dart';

enum UserDetailStatus { initial, loading, success, failure }

class UserDetailState {
  const UserDetailState({
    this.status = UserDetailStatus.initial,
    this.user,
    this.error,
  });

  final UserDetailStatus status;
  final GitHubUserDetailModel? user;
  final Object? error;

  UserDetailState copyWith({
    UserDetailStatus? status,
    GitHubUserDetailModel? user,
    Object? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return UserDetailState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      error: clearError ? null : (error ?? this.error),
    );
  }
}
