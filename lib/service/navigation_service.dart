import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:urban_shop/view/exported_view.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? argument}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: argument);
  }

  // static Future<dynamic> openWebView({required String url}) {
  //   return navigationKey.currentState!
  //       .pushNamed(WebViewScreen.routeName, arguments: WebViewScreen(url: url));
  // }

  static Future<dynamic> pushNamedAndRemoveUtil(String routeName,
      {Object? argument}) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: argument,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        // final SplashScreen args = settings.arguments as SplashScreen;
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "page_not_found".tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "page_name".tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${settings.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
  // }
}
