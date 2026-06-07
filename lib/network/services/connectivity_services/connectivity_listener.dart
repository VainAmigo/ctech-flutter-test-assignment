import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:flutter/material.dart';

class ConnectivityListener extends StatefulWidget {
  const ConnectivityListener({
    super.key,
    required this.connectivityService,
    required this.child,
  });

  final ConnectivityService connectivityService;
  final Widget child;

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _wasConnected = true;

  @override
  void initState() {
    super.initState();
    _initConnectionState();
    _subscription = widget.connectivityService.onConnectivityChanged.listen(
      _onConnectivityChanged,
    );
  }

  Future<void> _initConnectionState() async {
    _wasConnected = await widget.connectivityService.hasConnection();
  }

  void _onConnectivityChanged(List<ConnectivityResult> result) {
    final isConnected = widget.connectivityService.isConnectedResult(result);

    if (_wasConnected && !isConnected) {
      AppMessenger.showError('Нет подключения к интернету');
    } else if (!_wasConnected && isConnected) {
      AppMessenger.showSuccess('Подключение к интернету восстановлено');
    }

    _wasConnected = isConnected;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
