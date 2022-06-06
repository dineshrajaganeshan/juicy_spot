import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/screens/forgot_password_screen/forgot_password_%20controller.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/edittext.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            Positioned(
              top: 30,
              left: 40,
              child: Text(
                controller.otpIsVisible.value
                    ? "Enter OTP"
                    : 'Forgot Password?',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 80,
              left: 40,
              right: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => controller.otpIsVisible.value
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Obx(
                                () => EditText(
                                  placeholder: 'Mobile Number',
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  fontSize: 17,
                                  readOnly: controller.otpIsVisible.value,
                                  textColor: Colors.white,
                                  controller: controller.mobileNoController,
                                  suffixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Obx(
                                () => controller.isLoading.value
                                    ? Container(
                                        height: 40,
                                        width: 40,
                                        padding: const EdgeInsets.all(6),
                                        margin:
                                            const EdgeInsets.only(right: 40),
                                        child: const CircularProgressIndicator(
                                          color: buttonColor,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          controller.sendOtp();
                                        },
                                        child: Container(
                                            width: Get.width,
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
                              ),
                            ],
                          ),
                  ),
                  Obx(() => controller.otpIsVisible.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A 4 digit code has been sent to \n+91' +
                                  controller.mobileNoController.text,
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  wordSpacing: 4,
                                  height: 1.5,
                                  //letterSpacing: 1.3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: OTPTextField(
                                length: 4,
                                width: Get.width * 0.8,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                fieldWidth: 40,
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
                              height: 18,
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
                              height: 16,
                            ),
                            Obx(
                              () => controller.isVerifying.value
                                  ? Center(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        padding: const EdgeInsets.all(6),
                                        margin:
                                            const EdgeInsets.only(right: 40),
                                        child: const CircularProgressIndicator(
                                          color: buttonColor,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => controller.otpVerification(),
                                      child: Container(
                                          width: Get.width,
                                          height: 45,
                                          decoration: const BoxDecoration(
                                            color: buttonColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
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
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
