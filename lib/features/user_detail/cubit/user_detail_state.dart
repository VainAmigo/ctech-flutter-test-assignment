part of 'user_detail_cubit.dart';

enum UserDetailStatus { initial, loading, success, failure }

class UserDetailState {
  const UserDetailState({
    this.status = UserDetailStatus.initial,
    this.user,
    this.errorMessage,
  });

  final UserDetailStatus status;
  final GitHubUserDetailModel? user;
  final String? errorMessage;

  UserDetailState copyWith({
    UserDetailStatus? status,
    GitHubUserDetailModel? user,
    String? errorMessage,
  }) {
    return UserDetailState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
