import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
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
      final response = await ApiCall()
          .userLogIn(mobileNoController.text, passwordController.text);
      isLoading(false);
      if (response != null) {
        if (response["success"]) {
          _box.write(MOBILE_NO, mobileNoController.text);
          _box.write(PASSWORD, passwordController.text);
          _box.write(NAME, 'Dinesh Raja');
          _box.write(MAIL_ID, 'dinesh@gmail.com');
          _box.write(LOCATION,
              '1/1803, Siva street, Pandiyan nagar, Virudhunagar - 626001');
          _box.write(IMAGE_PATH,
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60');
          _box.write(AUTHORIZATION_KEY, response["response"]);
          _box.write(IS_LOGIN, true);
          Get.offAllNamed(AppRoutes.HOMESCREEN);
        } else {
          showToastMsg(response["message"]);
        }
      }
    }
  }

  forgotPassword() {}
}
