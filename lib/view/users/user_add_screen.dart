import 'package:flutter/material.dart';
import 'package:urban_shop/components/urban_enum.dart';
import 'package:urban_shop/components/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:urban_shop/model/user.dart';
import 'package:urban_shop/service/firebase_service.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({Key? key}) : super(key: key);
  static const String routeName = 'user_add_screen';

  @override
  _UserAddScreenState createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _currentRole, _userName;
  String _currentAccountStatus = UrbanEnum.urbanShopAccountStatus[0].status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User_Add",
          style: Utils.defaultTextStyle.copyWith(),
        ).tr(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_userName != null && _currentRole != null) {
                  Utils.checkInternetConnection(showStatus: true)
                      .then((isConnected) {
                    if (isConnected) {
                      String _userId =
                          "US${DateTime.now().millisecondsSinceEpoch}${Utils.getRandomString(5)}";
                      FirestoreService.userCollection
                          .doc(_userId)
                          .set(
                            User(
                              userId: _userId,
                              userName: _userName,
                              userRole: _currentRole,
                              accountStatus: _currentAccountStatus,
                            ).toJson(),
                          ).then((value){
                            Navigator.of(context).pop();
                          })
                          .catchError((e) {
                        Utils.showToastSomethingWasWrong();
                      });
                    }
                  });
                }
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "User_Name".tr(),
                    hintStyle: Utils.defaultTextStyle.copyWith(),
                    errorMaxLines: 3,
                    errorStyle: const TextStyle(height: 1.3),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'You_cannot_leave_this_field_empty'.tr();
                    }
                  },
                  onSaved: (value) {
                    _userName = value;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "User_Role".tr(),
                    hintStyle: Utils.defaultTextStyle.copyWith(),
                    errorMaxLines: 3,
                    errorStyle: const TextStyle(height: 1.3),
                    isDense: true,
                  ),
                  isExpanded: true,
                  onChanged: (cRole) {
                    if (mounted) {
                      setState(() {
                        _currentRole = cRole;
                      });
                    }
                  },
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'You_cannot_leave_this_field_empty'.tr();
                    }
                  },
                  onSaved: (value) {
                    _currentRole = value;
                  },
                  value: _currentRole,
                  items: UrbanEnum.urbanShopRole
                      .map(
                        (role) => DropdownMenuItem<String>(
                          onTap: () {},
                          value: role.role,
                          child: Text(
                            role.roleName,
                            style: Utils.defaultTextStyle.copyWith(),
                          ).tr(),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Account_Status".tr(),
                    hintStyle: Utils.defaultTextStyle.copyWith(),
                    errorMaxLines: 3,
                    errorStyle: const TextStyle(height: 1.3),
                    isDense: true,
                  ),
                  isExpanded: true,
                  onChanged: (cStatus) {
                    if (cStatus != null && mounted) {
                      setState(() {
                        _currentAccountStatus = cStatus;
                      });
                    }
                  },
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'You_cannot_leave_this_field_empty'.tr();
                    }
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _currentAccountStatus = value;
                    }
                  },
                  value: _currentAccountStatus,
                  items: UrbanEnum.urbanShopAccountStatus
                      .map(
                        (accountStatus) => DropdownMenuItem<String>(
                          onTap: () {},
                          value: accountStatus.status,
                          child: Text(
                            accountStatus.statusName,
                            style: Utils.defaultTextStyle.copyWith(),
                          ).tr(),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
