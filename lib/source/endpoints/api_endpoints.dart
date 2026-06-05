class ApiEndpoints {
  static const String users = '/users';
  static const String searchUsers = '/search/users';

  static String user(String login) => '/users/$login';
}
