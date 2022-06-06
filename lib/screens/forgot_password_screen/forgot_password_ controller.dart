import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class ForgotPasswordController extends GetxController {
  final mobileNoController = TextEditingController();
  String otp = "";

  RxBool isLoading = false.obs;
  RxBool isVerifying = false.obs;
  RxBool otpIsVisible = false.obs;
  RxBool isResend = false.obs;

  Timer? timer;
  RxInt seconds = 30.obs;

  final _box = GetStorage();

  sendOtp() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (mobileNoController.text.isEmpty) {
      showToastMsg(
        "Please Enter Mobile Number",
      );
    } else {
      isLoading(true);
      final response =
          await ApiCall().sendOTP(mobileNoController.text, "password-init");
      isLoading(false);

      if (response != null) {
        if (response["success"]) {
          otpIsVisible(true);
          otpTimer();
          debugPrint("OTP: ${response["response"]}");
          _box.write(MOBILE_NO, mobileNoController.text);
          showToastMsg("${response["message"]}");
        } else {
          showToastMsg("${response["message"]}");
        }
      }
    }
  }

  resendOTP() async {
    Get.focusScope?.unfocus();
    isResend(false);
    final response =
        await ApiCall().sendOTP(mobileNoController.text, "register-init");
    print("response: ${response["success"]}");
    if (response != null) {
      showToastMsg("${response["message"]}");
/*
      if (response["success"]) {
        print("OTP: ${response["response"]}");
      }
*/
    }
  }

  otpVerification() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (otp.length == 4) {
      isVerifying(true);
      debugPrint("OTP verify: $otp");
      final response = await ApiCall()
          .verifyOTP(otp, mobileNoController.text, "password-init");
      isVerifying(false);
      if (response != null /*&& response == 1*/) {
        showToastMsg("Verification Complete");
        Get.offAndToNamed(AppRoutes.SETPASSWORDSCREEN);
      } else {
        showToastMsg("Invalid OTP");
      }
    } else {
      showToastMsg("Enter 4-digit OTP");
    }
  }

  otpTimer() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds--;
        if (seconds.value == 0) {
          isResend(true);
          t.cancel();
        }
      }
    });

    /*@override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }*/
  }
}
