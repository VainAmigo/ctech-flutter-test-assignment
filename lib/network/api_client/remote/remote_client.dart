import 'dart:io';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

part 'remote_client_base_extension.dart';

/// {@template mq_remote_client}
/// MQ remote client package
/// {@endtemplate}
typedef FromJson<T> = T Function(Map<String, dynamic>);

/// A function type that converts a [Map<String, dynamic>] to an object of type T
///
/// Used to deserialize JSON responses from the server.
typedef ResolveValue = String? Function();

/// A client for making HTTP requests with custom headers and handling JSON
/// responses.
class RemoteClient {
  /// {@macro mq_remote_client}
  const RemoteClient({
    required this.dio,
    required this.network,
    required this.storage,
    this.language,
    this.token,
    this.oldToken,
  });

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  /// The network client for handling network-related tasks.
  final NetworkClient network;

  /// The storage client for handling storage-related tasks.
  final PreferencesStorage storage;

  /// A function that resolves the language value for the headers.
  final ResolveValue? language;

  /// A function that resolves the authorization token for the headers.
  final ResolveValue? token;

  /// A function that resolves the old token for the headers.
  final ResolveValue? oldToken;

  /// Initializes the Dio instance with interceptors to add custom headers.
  void initilize() {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final tokenValue = token?.call();
          options.headers = {
            'Content-Type': 'application/json; charset=utf-8',
            'accept': 'application/json',
            if (tokenValue != null) 'Authorization': 'Bearer $tokenValue',
          };
          return handler.next(options);
        },
      ),
    ]);
  }

  /// Makes a GET request to the given [url] and parses the response as type [T]
  Future<Either<T, RemoteException>> get<T>(String url) {
    return _get<T>(url);
  }

  /// Makes a GET request to the given [url] and parses the response as type [T]
  /// from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> getType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<Map<String, dynamic>>(url);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a GET request to the given [url] and parses the response as a list
  /// of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, RemoteException>> getListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
  }) async {
    final data = await _get<List<dynamic>>(url);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  Future<Either<T, RemoteException>> post<T>(
    String url, {
    Map<String, dynamic>? body,
  }) {
    return _post<T>(url, body: body);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> postType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a POST request to the given [url] with an optional [body] and parses
  /// the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, RemoteException>> postListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _post<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  Future<Either<T, RemoteException>> put<T>(
    String url, {
    Map<String, dynamic>? body,
  }) {
    return _put<T>(url, body: body);
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> putType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PUT request to the given [url] with an optional [body] and parses
  /// the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, RemoteException>> putListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _put<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as type [T].
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> patch<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final response = await _patch<T>(url, body: body);
    return response;
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> patchType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a PATCH request to the given [url] with an optional [body] and
  /// parses the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, RemoteException>> patchListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _patch<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }

  /// Makes a DELETE request to the given [url] with an optional [body] and parses
  /// the response as type [T].
  Future<Either<T, RemoteException>> delete<T>(
    String url, {
    Map<String, dynamic>? body,
  }) {
    return _delete<T>(url, body: body);
  }

  /// Makes a DELETE request to the given [url] with an optional [body] and parses
  /// the response as type [T] from a JSON object.
  ///
  /// The [fromJson] parameter is used to parse the JSON response.
  Future<Either<T, RemoteException>> deleteType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _delete<Map<String, dynamic>>(url, body: body);
    return _convertType<T>(jsonData: data, fromJson: fromJson);
  }

  /// Makes a DELETE request to the given [url] with an optional [body] and parses
  /// the response as a list of type [T].
  ///
  /// The [fromJson] parameter is used to parse each JSON object in the list.
  Future<Either<List<T>, RemoteException>> deleteListOfType<T>(
    String url, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? body,
  }) async {
    final data = await _delete<List<dynamic>>(url, body: body);
    return _convertListOfType(jsonData: data, fromJson: fromJson);
  }
}
