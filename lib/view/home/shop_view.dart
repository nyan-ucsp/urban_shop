import 'package:flutter/material.dart';
import 'package:urban_shop/components/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:urban_shop/service/navigation_service.dart';
import 'package:urban_shop/view/exported_view.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: Column(
            children: [
              GridView.count(
                childAspectRatio: 2 / 1,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: _adminShopView,
              ),
            ],
          ),
        );
      }),
    );
  }

  final List<Widget> _adminShopView = [
    InkWell(
      onTap: () {
        NavigationService.navigateTo(UserListScreen.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "resources/image/user.png",
                width: 36,
                height: 36,
              ),
              const SizedBox(height: 4),
              Text(
                "Users",
                style: Utils.defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
            ],
          ),
        ),
      ),
    ),
  ];
}
