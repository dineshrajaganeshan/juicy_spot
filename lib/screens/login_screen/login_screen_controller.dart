import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/user_log_in.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class LogInScreenController extends GetxController {
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();

  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isVisibility = true.obs;

  changeVisibility() {
    isVisibility(!isVisibility.value);
  }

  logIn() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (mobileNoController.text.isEmpty) {
      showToastMsg(
        "Please Enter Your Mobile Number ",
      );
    } else if (passwordController.text.isEmpty) {
      showToastMsg(
        "Please Enter Your Password",
      );
    } else {
      isLoading(true);
      UserLogIn? response = await ApiCall()
          .userLogIn(mobileNoController.text, passwordController.text);
      isLoading(false);
      if (response != null) {
        if (response.success) {
          _box.write(MOBILE_NO, mobileNoController.text);
          _box.write(PASSWORD, passwordController.text);
          _box.write(NAME, response.data.name);
          _box.write(MAIL_ID, response.data.email);
          _box.write(LOCATION, response.data.address);
          _box.write(IMAGE_PATH, IMAGE_BASE_URL + response.data.avatar);
          _box.write(AUTHORIZATION_KEY, response.response);
          _box.write(IS_LOGIN, true);
          Get.offAllNamed(AppRoutes.HOMESCREEN);
        } else {
          showToastMsg(response.message);
        }
      }
    }
  }

  forgotPassword() async {
    Get.focusScope?.unfocus();
    final response = await ApiCall().sendOTP(MOBILE_NO, "password-init");
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
}
