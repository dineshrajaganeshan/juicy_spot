import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class RegisterScreenController extends GetxController {
  final mobileNumberController = TextEditingController();
  final passWordController = TextEditingController();
  final reTypePassWordController = TextEditingController();

  final _box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool passwordVisibility = true.obs;
  RxBool rePasswordVisibility = true.obs;

  sendOtp() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (mobileNumberController.text.isEmpty) {
      showToastMsg(
        "Please Enter Mobile Number",
      );
    } else if (passWordController.text.isEmpty) {
      showToastMsg(
        "Please Enter Password",
      );
    } else if (reTypePassWordController.text.isEmpty) {
      showToastMsg(
        "Please Enter Confirmation Password",
      );
    } else if (passWordController.text != reTypePassWordController.text) {
      showToastMsg(
        "Password Mismatch",
      );
    } else {
      isLoading(true);
      final response = await ApiCall().sendOTP(mobileNumberController.text);
      isLoading(false);

      if (response != null) {
        if (response["success"]) {
          print("OTP: ${response["response"]}");
          _box.write(MOBILE_NO, mobileNumberController.text);
          _box.write(PASSWORD, passWordController.text);
          showToastMsg("${response["message"]}");
          Get.toNamed(AppRoutes.OTPVERIFY);
        } else {
          showToastMsg("${response["message"]}");
        }
      }
    }
  }
}
