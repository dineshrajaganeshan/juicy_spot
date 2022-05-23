import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/screens/otp_verify_screen/otp_verify_controller.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerifyScreen extends GetView<OTPVerifyController> {
  @override
  final controller = Get.put(OTPVerifyController());

  OTPVerifyScreen({Key? key}) : super(key: key);

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
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/lock.svg',
                  height: 40,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Enter Your One Time Password',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: OTPTextField(
                    length: 4,
                    width: Get.width,
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    fieldWidth: 30,
                    fieldStyle: FieldStyle.underline,
                    otpFieldStyle: OtpFieldStyle(
                        enabledBorderColor: Colors.white,
                        borderColor: editTextColor,
                        focusBorderColor: Colors.white,
                        errorBorderColor: Colors.red),
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    onChanged: (pin) {},
                    onCompleted: (pin) {
                      controller.otp = pin;
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'If you didn\'t receive a code ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => controller.isResend.value
                        ? GestureDetector(
                            onTap: () {
                              controller.resendOTP();
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  fontSize: 16),
                            ),
                          )
                        : controller.seconds.value != 0
                            ? Text(
                                "${controller.seconds.value} s",
                                style: const TextStyle(
                                    color: buttonColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6,
                                    fontSize: 16),
                              )
                            : const SizedBox.shrink()),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(6),
                          //margin: EdgeInsets.only(right: 25),
                          child: const CircularProgressIndicator(
                            color: buttonColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () => controller.otpVerification(),
                          child: Container(
                              width: Get.width * 0.8,
                              height: 45,
                              decoration: const BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                  child: Text(
                                'Verify',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
