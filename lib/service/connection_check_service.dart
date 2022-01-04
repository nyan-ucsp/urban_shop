import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:easy_localization/easy_localization.dart';

/// a base class for any stateful widget for checking internet connectivity
abstract class ConnectionCheckState<T extends StatefulWidget> extends State {
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  /// the internet connectivity status
  bool isOnline = true;

  /// initialize connectivity checking
  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
    if (!kIsWeb) {
      await _updateConnectionStatus().then((bool isConnected) {
        if (mounted) {
          setState(() {
            isOnline = isConnected;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        BotToast.showNotification(
          duration: const Duration(
            seconds: 3,
          ),
          title: (cancel) {
            return const Text(
              'no_internet_connection_connect_to_the_internet_and_try_again',
              textAlign: TextAlign.center,
            ).tr();
          },
          contentPadding: const EdgeInsets.all(2),
        );
      } else {
        if (!kIsWeb) {
          await _updateConnectionStatus().then((bool isConnected) {
            if (mounted) {
              setState(() {
                isOnline = isConnected;
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
    // late bool isConnected;
    // try {
    //   final List<InternetAddress> result =
    //   await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     isConnected = true;
    //   }
    // } on SocketException catch (_) {
    //   isConnected = false;
    //   return false;
    // }
    // return isConnected;
  }
}
