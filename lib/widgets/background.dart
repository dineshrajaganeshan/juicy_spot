import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          color: backgroundColor,
        ),
        Positioned(
          child: Container(
            width: Get.width,
            height: 200,
            decoration: const BoxDecoration(
                // shape: BoxShape.circle,
                color: ellipseColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(220),
                    bottomRight: Radius.circular(220)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: 3, blurRadius: 15),
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 5, blurRadius: 20)
                ]),
          ),
        ),
        Positioned(
          right: -180,
          bottom: -100,
          child: Container(
            width: Get.width,
            height: 200,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ellipseColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: 3, blurRadius: 15),
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 5, blurRadius: 20)
                ]),
          ),
        ),
      ],
    );
  }
}
