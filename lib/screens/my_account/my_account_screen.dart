import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/const_widget.dart';
import 'package:juicy_spot/widgets/edittext.dart';

import 'my_account_controller.dart';

class MyAccountScreen extends GetView<MyAccountController> {
  @override
  final controller = Get.put(MyAccountController());

  MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const AppBackground(),
          Positioned(
              left: 20,
              right: 20,
              top: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: editTextColor,
                    ),
                  ),
                  const Text(
                    'My Account',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () =>
                        {Get.toNamed(AppRoutes.EDITACCOUNT, arguments: false)},
                    icon: const Icon(
                      Icons.edit,
                      color: editTextColor,
                    ),
                  ),
                ],
              )),
          Positioned(
              left: 20,
              right: 20,
              top: 120,
              child: Center(
                child: Column(
                  children: [
                    Obx(
                      () => cachedImage(controller.imagePath.value),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => Text(
                        controller.name.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    EditText(
                      placeholder: 'Mobile Number',
                      controller: controller.mobileNumber,
                      readOnly: true,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    EditText(
                      placeholder: 'Mail Id',
                      controller: controller.mailIdController,
                      //obsecureText: true,
                      readOnly: true,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    EditText(
                      placeholder: 'Location',
                      isMaxNull: true,
                      maxLines: 3,
                      controller: controller.locationController,
                      readOnly: true,
                      contentPadding: const EdgeInsets.only(bottom: 10),
                      prefixIcon: const Icon(
                        Icons.navigation,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    GestureDetector(
                      onTap: () => {Get.toNamed(AppRoutes.ORDERHISTORY)},
                      child: Container(
                          height: 40,
                          width: 180,
                          decoration: const BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Order History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.replay,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMenu('assets/svg/share.svg', 'Share', () {
                          share("www.juicyspot.in",
                              title: "Hi!, Juicy spot provide best food items");
                        }),
                        _buildMenu('assets/svg/rateus.svg', 'Rate Us', () {
                          controller.rating();
                        }),
                        _buildMenu('assets/svg/contactshop.svg', 'Contact Shop',
                            () {
                          _buildContactShop();
                        }, height: 28),
                        _buildMenu('assets/svg/help.svg', 'Help', () {
                          openUrl("https://pub.dev/packages/url_launcher",
                              forceWebView: true, enableJavaScript: true);
                        }, height: 28),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.only(right: 30),
                              child: const CircularProgressIndicator(
                                color: buttonColor,
                              ),
                            )
                          : GestureDetector(
                              onTap: () => {controller.logOut()},
                              child: Container(
                                  height: 40,
                                  width: 180,
                                  decoration: const BoxDecoration(
                                    color: buttonColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ))),
                            ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _buildMenu(String svgPath, String title, Function onTab, {double? height}) {
    return InkWell(
      onTap: () => onTab(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              svgPath,
              height: height ?? 30,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: editTextColor, fontSize: 13),
          )
        ],
      ),
    );
  }

  _buildContactShop() {
    return showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Container(
            height: Get.width / 1.5,
            decoration: const BoxDecoration(
                color: ellipseColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: 3, blurRadius: 15),
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 5, blurRadius: 20)
                ]),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                divider(),
                const SizedBox(
                  height: 9,
                ),
                const Text(
                  'Give Your feedback',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Padding(
                    padding: const EdgeInsets.all(22),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black, height: 1),
                        maxLines: 5,
                        cursorColor: Colors.black,
                        autofocus: false,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 8, right: 8, bottom: 8, top: 10),
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Type Message',
                          hintStyle: TextStyle(fontSize: 13),
                          labelStyle: TextStyle(color: textColor),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 100,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))),
                      GestureDetector(
                        onTap: () => call("1234567890"),
                        child: Container(
                            width: 100,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: buttonColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                                child: Text(
                              'Call',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
