import 'package:json_annotation/json_annotation.dart';

part 'github_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitHubUserModel {
  const GitHubUserModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) => _$GitHubUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserModelToJson(this);

  final int id;
  final String login;
  final String avatarUrl;
}
