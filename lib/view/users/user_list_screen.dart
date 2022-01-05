import 'package:flutter/material.dart';
import 'package:urban_shop/components/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:urban_shop/view/exported_view.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);
  static const String routeName = 'user_list_screen';

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
          style: Utils.defaultTextStyle.copyWith(),
        ).tr(),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(UserAddScreen.routeName);
        },
      ),
    );
  }
}
