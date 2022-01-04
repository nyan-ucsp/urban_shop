import 'dart:math';
import 'dart:typed_data';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

enum CalculateFileSize {
  kB,
  mB,
}

class Utils {
  static const TextStyle defaultTextStyle = TextStyle(height: 1.3);

  static final Random _random = Random();
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
  //check wide layout
  static String generateKey({required String key}) =>
      '$key-${DateTime.now().millisecondsSinceEpoch}${getRandomString(5)}';

  //check medium layout
  static bool isTabletDisplay(BuildContext context) {
    return getWindowType(context) >= AdaptiveWindowType.medium;
  }

  //check medium layout
  static bool isSmallMobileDisplay(BuildContext context) {
    return getWindowType(context) <= AdaptiveWindowType.small;
  }

  static double reducedTextScale(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
  }

  static double cappedTextScale(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return max(textScaleFactor, 1);
  }

  static double calcuateFileSize(Uint8List rawByte,
      {CalculateFileSize outPutFormat = CalculateFileSize.kB}) {
    switch (outPutFormat) {
      case CalculateFileSize.mB:
        return rawByte.lengthInBytes / 1048576;
      default:
        return rawByte.lengthInBytes / 1024;
    }
  }

  static void launchURL(
          {required Uri url}) async =>
      await canLaunch(url.toString())
          ? await launch(url.toString())
          : BotToast.showSimpleNotification(
              title: 'Could not launch ${url.toString()}');

  static void launchEmail({required String email}) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        // 'subject': 'Example Subject & Symbols are allowed!'
      }),
    );
    await launch(emailLaunchUri.toString());
  }

  static Future<bool> checkInternetConnection({bool showStatus = false}) async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (showStatus) {
        BotToast.showText(
          text: 'no_network_connection'.tr(),
        );
      }
      return false;
    } else {
      if (!kIsWeb) {
        bool result = await InternetConnectionChecker().hasConnection;
        if (!result) {
          if (showStatus) {
            BotToast.showText(
              text: 'no_internet_connection'.tr(),
            );
          }
        }
        return result;
      } else {
        return true;
      }
    }
  }

  static void showToastSomethingWasWrong() {
    BotToast.showText(text: 'Something_was_wrong'.tr());
  }

  static const String testLongString =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
}

//Android 5.0 cannot connect to inter and use it
