// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubUserModel _$GitHubUserModelFromJson(Map<String, dynamic> json) =>
    GitHubUserModel(
      id: (json['id'] as num).toInt(),
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$GitHubUserModelToJson(GitHubUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
    };
