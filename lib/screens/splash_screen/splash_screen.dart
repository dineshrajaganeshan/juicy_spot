import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/screens/splash_screen/splash_screen_controller.dart';
import 'package:juicy_spot/utils/custom_colors.dart';

class SplashScreen extends GetView<SplashScreenController> {
  @override
  final controller = Get.put(SplashScreenController());

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: backgroundColor,
            child: Center(
                child: Image.asset(
              'assets/images/js_logo_trans.png',
              width: 220,
            )),
          ),
          Positioned(
              bottom: -70,
              right: -70,
              child: Image.asset(
                'assets/images/dish.png',
                width: 300,
              )),
        ],
      ),
    );
  }
}
