import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:dio/dio.dart';

class NetworkErrorMapper {
  const NetworkErrorMapper._();

  static void notifyIfNoInternet(Object error) {
    if (isNoInternet(error)) {
      AppMessenger.showError(NoInternetException.message);
    }
  }

  static String message(Object error) {
    if (error is NoInternetException) {
      return NoInternetException.message;
    }

    if (error is DioException && _isConnectionIssue(error)) {
      return NoInternetException.message;
    }

    return 'Не удалось загрузить данные';
  }

  static bool isNoInternet(Object error) {
    if (error is NoInternetException) return true;
    return error is DioException && _isConnectionIssue(error);
  }

  static bool _isConnectionIssue(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => true,
      _ => false,
    };
  }
}
