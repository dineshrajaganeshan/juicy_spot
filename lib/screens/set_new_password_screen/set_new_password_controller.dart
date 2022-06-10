import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/user_log_in.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class SetNewPasswordController extends GetxController {
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final reTypePasswordController = TextEditingController();

  RxBool passwordVisibility = true.obs;
  RxBool rePasswordVisibility = true.obs;

  RxBool isLoading = false.obs;

  String mobileNo = "";

  final _box = GetStorage();

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mobileNo = _box.read(MOBILE_NO) ?? "";
    mobileNoController.text = mobileNo;
  }

  Future setPassword() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (passwordController.text.isEmpty) {
      showToastMsg(
        "Please Enter password ",
      );
    } else if (reTypePasswordController.text.isEmpty) {
      showToastMsg(
        "Please Enter Confirmation Password",
      );
    } else if (passwordController.text != reTypePasswordController.text) {
      showToastMsg(
        "Password Mismatch",
      );
    } else {
      isLoading(true);
      final response = await ApiCall()
          .resetPassword(passwordController.text, mobileNo, "password-init");
      isLoading(false);
      if (response != null /*&& response == 1*/) {
        if (response["success"]) {
          await showAlert('Password ', response['message'], 'LogIn',
              isDismiss: false, isOneButton: true);

          Get.offAndToNamed(AppRoutes.LOGIN);
        }
      }
      showToastMsg(response["message"]);
    }
  }
}
