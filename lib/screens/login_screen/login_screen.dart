import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/edittext.dart';

import 'login_screen_controller.dart';

class LoginScreen extends GetView<LogInScreenController> {
  @override
  final controller = Get.put(LogInScreenController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBackground(),
          Positioned(
              top: 110,
              right: -30,
              child: Image.asset(
                'assets/images/dish.png',
                width: 150,
              )),
          const Positioned(
            left: 40,
            top: 170,
            child: Text(
              'Welcome\nBack !',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 280,
            left: 30,
            right: 30,
            child: Column(
              children: [
                EditText(
                  placeholder: 'Mobile Number',
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  fontSize: 17,
                  textColor: Colors.white,
                  controller: controller.mobileNoController,
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => EditText(
                    placeholder: 'Password',
                    controller: controller.passwordController,
                    obsecureText: controller.isVisibility.value,
                    textColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isVisibility.value
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: () {
                        controller.changeVisibility();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => controller.forgotPassword(),
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: editTextColor, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.REGISTERSCREEN);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.only(right: 40),
                              child: const CircularProgressIndicator(
                                color: buttonColor,
                              ),
                            )
                          : InkWell(
                              onTap: () => controller.logIn(),
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: buttonColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
