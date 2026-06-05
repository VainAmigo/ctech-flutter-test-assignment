import 'package:json_annotation/json_annotation.dart';

part 'github_user_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitHubUserDetailModel {
  const GitHubUserDetailModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.company,
    required this.location,
    required this.blog,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  factory GitHubUserDetailModel.fromJson(Map<String, dynamic> json) => _$GitHubUserDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserDetailModelToJson(this);

  final int id;
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? company;
  final String? location;
  final String? blog;
  final int followers;
  final int following;
  final DateTime createdAt;

  String get displayName =>
      (name != null && name!.isNotEmpty) ? name! : login;
}
