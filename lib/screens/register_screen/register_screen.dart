import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/screens/register_screen/register_screen_controller.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/edittext.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  @override
  final controller = Get.put(RegisterScreenController());

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
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
                  'Welcome\nBack!',
                  style: TextStyle(
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
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
                      textColor: Colors.white,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller: controller.mobileNumberController,
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
                          textColor: Colors.white,
                          controller: controller.passWordController,
                          obsecureText: controller.passwordVisibility.value,
                          suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.passwordVisibility.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    controller.passwordVisibility(
                                        !controller.passwordVisibility.value);
                                  },
                                )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => EditText(
                          placeholder: 'Retype Password',
                          textColor: Colors.white,
                          controller: controller.reTypePassWordController,
                          obsecureText: controller.rePasswordVisibility.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.rePasswordVisibility.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                            onPressed: () {
                              controller.rePasswordVisibility(
                                  !controller.rePasswordVisibility.value);
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Text(
                            'Back',
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
                              : GestureDetector(
                                  onTap: () {
                                    controller.sendOtp();
                                  },
                                  child: Container(
                                      width: 120,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        color: buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Send OTP',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ))),
                                ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
