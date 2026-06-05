import 'package:ctech_flutter_test_app/source/models/github_user_model.dart';

class GitHubUserSearchResponse {
  const GitHubUserSearchResponse({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<GitHubUserModel> items;

  factory GitHubUserSearchResponse.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    return GitHubUserSearchResponse(
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
      items: itemsJson
          .map((item) => GitHubUserModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
