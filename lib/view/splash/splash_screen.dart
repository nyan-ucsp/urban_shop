import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:urban_shop/components/utils.dart';
import 'package:urban_shop/view/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BounceInDown(
          child: Text(
            "Urban Shop",
            style: Utils.defaultTextStyle.copyWith(
              fontFamily: 'ComfortaaBold',
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
