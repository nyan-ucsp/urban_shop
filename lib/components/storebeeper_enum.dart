import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:urban_shop/service/theme_service.dart';

class ProviderStaticList {
  static List<SingleChildWidget> providerList = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
    ),
  ];
}

class Config {
  // [API Config]
  static const String apiBaseUrl =
      'http://nainghtay-001-site5.ftempurl.com/storebeeper/storebeeperservice';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;
  // [UI Config]
}
