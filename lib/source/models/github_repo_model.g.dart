// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubRepoModel _$GitHubRepoModelFromJson(Map<String, dynamic> json) =>
    GitHubRepoModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
      stargazersCount: (json['stargazers_count'] as num).toInt(),
      language: json['language'] as String?,
      fork: json['fork'] as bool,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$GitHubRepoModelToJson(GitHubRepoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'description': instance.description,
      'html_url': instance.htmlUrl,
      'stargazers_count': instance.stargazersCount,
      'language': instance.language,
      'fork': instance.fork,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
