import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<bool> hasConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result.any(_isConnected);
  }

  bool isConnectedResult(List<ConnectivityResult> result) {
    return result.any(_isConnected);
  }

  bool _isConnected(ConnectivityResult result) {
    return switch (result) {
      ConnectivityResult.mobile ||
      ConnectivityResult.wifi ||
      ConnectivityResult.ethernet => true,
      _ => false,
    };
  }
}
