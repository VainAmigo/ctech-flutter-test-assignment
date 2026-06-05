// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubUserDetailModel _$GitHubUserDetailModelFromJson(
  Map<String, dynamic> json,
) => GitHubUserDetailModel(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  company: json['company'] as String?,
  location: json['location'] as String?,
  blog: json['blog'] as String?,
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$GitHubUserDetailModelToJson(
  GitHubUserDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
  'name': instance.name,
  'bio': instance.bio,
  'company': instance.company,
  'location': instance.location,
  'blog': instance.blog,
  'followers': instance.followers,
  'following': instance.following,
  'created_at': instance.createdAt.toIso8601String(),
};
