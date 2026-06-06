import 'package:json_annotation/json_annotation.dart';

part 'github_repo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitHubRepoModel {
  const GitHubRepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.language,
    required this.fork,
    required this.updatedAt,
  });

  factory GitHubRepoModel.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubRepoModelToJson(this);

  final int id;
  final String name;
  final String fullName;
  final String? description;
  final String htmlUrl;
  final int stargazersCount;
  final String? language;
  final bool fork;
  final DateTime updatedAt;
}
