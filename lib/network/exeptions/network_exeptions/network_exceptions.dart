class NoInternetException implements Exception {
  const NoInternetException();

  static const message = 'Нет подключения к интернету';

  @override
  String toString() => message;
}
