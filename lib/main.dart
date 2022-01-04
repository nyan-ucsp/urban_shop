import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urban_shop/components/storebeeper_enum.dart';
import 'package:urban_shop/service/navigation_service.dart';
import 'package:urban_shop/service/theme_service.dart';
import 'package:urban_shop/view/exported_view.dart';

import 'components/http_client_overrides.dart';
import 'components/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = HttpClientOverrides();
  runApp(
    MultiProvider(
      providers: ProviderStaticList.providerList,
      child: EasyLocalization(
        child: const MyApp(),
        supportedLocales: const [
          Locale('en', 'EN'),
          Locale('my', 'MM'),
          Locale('zh', 'CN'),
        ],
        path: 'resources/lang',
        fallbackLocale: const Locale('en', 'EN'),
        saveLocale: true,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) => FutureBuilder(
        initialData: ThemeService.systemDefaultTheme == Brightness.dark,
        future: themeService.checkThemeMode,
        builder: (context, snapshot) {
          final botToastBuilder = BotToastInit();
          SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
          );
          return MaterialApp(
            title: 'Shopbeeper',
            theme: snapshot.data == ThemeService.defaultThemeValue
                //Default Theme
                ? ThemeService.systemDefaultTheme == Brightness.dark
                    ? ThemeService.darkTheme.copyWith(
                        textTheme: TextTheme(
                          headline1: const TextStyle().copyWith(
                            height: context.locale == const Locale('my', 'MM')
                                ? 1.3
                                : 1,
                          ),
                        ),
                      )
                    : ThemeService.lightTheme
                //Custom Theme
                : snapshot.data == ThemeService.darkThemeValue
                    ? ThemeService.darkTheme
                    : ThemeService.lightTheme,
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return MediaQuery(
                child: child,
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor:
                        Utils.isTabletDisplay(context) ? 1.5 : 1.0),
              );
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: NavigationService.navigationKey,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: NavigationService.generateRoute,
          );
        },
      ),
    );
  }
}
