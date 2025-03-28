import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityAwareWidget extends StatefulWidget {
  final Widget child;
  const ConnectivityAwareWidget({super.key, required this.child});

  @override
  State<ConnectivityAwareWidget> createState() =>
      _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  bool _isOffline = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    try {
      _subscription = Connectivity().onConnectivityChanged.listen((result) {
        // Handle both possible return types: ConnectivityResult or List<ConnectivityResult>
        bool isOnline;
        if (result is ConnectivityResult) {
          isOnline = result != ConnectivityResult.none;
        } else
          isOnline = result.any(
            (element) => element != ConnectivityResult.none,
          );

        setState(() {
          _isOffline = !isOnline;
        });
      });
    } catch (e) {
      debugPrint("Connectivity listen error: $e");
      setState(() {
        _isOffline = true;
      });
    }
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      bool isOnline;
      if (result is ConnectivityResult) {
        isOnline = result != ConnectivityResult.none;
      } else {
        isOnline = result.any((element) => element != ConnectivityResult.none);
      }

      setState(() {
        _isOffline = !isOnline;
      });
    } on Exception catch (e) {
      debugPrint("Connectivity check error: $e");
      setState(() {
        _isOffline = true;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOffline) {
      return Scaffold(
        appBar: AppBar(title: const Text("No Connection"), centerTitle: true),
        body: Center(
          child: Icon(
            Icons.wifi_off_outlined,
            color: Colors.grey.shade400,
            size: 80,
          ),
        ),
      );
    }
    return widget.child;
  }
}
