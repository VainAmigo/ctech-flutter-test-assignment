import 'package:ctech_flutter_test_app/source/models/github_user_detail_model.dart';

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
