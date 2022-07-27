import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:juicy_spot/screens/set_new_password_screen/set_new_password_controller.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/edittext.dart';

class SetNewPasswordScreen extends GetView<SetNewPasswordController> {
  SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(SetNewPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            const Positioned(
              top: 60,
              left: 40,
              child: Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 100,
              left: 40,
              right: 40,
              child: Column(
                children: [
                  EditText(
                    placeholder: 'MobileNumber',
                    controller: controller.mobileNoController,
                    readOnly: true,
                    textColor: Colors.white,
                    suffixIcon: const IconButton(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onPressed: null),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => EditText(
                      placeholder: 'Password',
                      controller: controller.passwordController,
                      obsecureText: controller.passwordVisibility.value,
                      textColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.passwordVisibility.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onPressed: () {
                          controller.passwordVisibility(
                              !controller.passwordVisibility.value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => EditText(
                      placeholder: 'Confirm Password',
                      controller: controller.reTypePasswordController,
                      obsecureText: controller.rePasswordVisibility.value,
                      textColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.rePasswordVisibility.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onPressed: () {
                          controller.rePasswordVisibility(
                              !controller.rePasswordVisibility.value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(6),
                              child: const CircularProgressIndicator(
                                color: buttonColor,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () => controller.setPassword(),
                            child: Container(
                                width: Get.width,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: buttonColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: const Center(
                                    child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ))),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
