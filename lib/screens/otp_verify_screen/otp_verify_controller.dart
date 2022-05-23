import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class OTPVerifyController extends GetxController {
  final _box = GetStorage();
  Timer? timer;
  RxInt seconds = 30.obs;
  RxBool isResend = false.obs;
  RxBool isLoading = false.obs;
  String otp = "";
  String mobileNo="";

  @override
  void onInit() {
    super.onInit();
    mobileNo = _box.read(MOBILE_NO);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds--;
        if (seconds.value == 0) {
          isResend(true);
          t.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  otpVerification() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (otp.length == 4) {
      isLoading(true);
      print("OTP verify: $otp");
      final response = await ApiCall().verifyOTP(otp, mobileNo);
      isLoading(false);

      if (response != null /*&& response == 1*/) {
        showToastMsg("Verification Complete");
        Get.offNamed(AppRoutes.EDITACCOUNT,arguments: true);
      } else {
        showToastMsg("Invalid OTP");
      }
    } else {
      showToastMsg("Enter 4-digit OTP");
    }
  }

  resendOTP() async {
    Get.focusScope?.unfocus();
    isResend(false);
    final response = await ApiCall().sendOTP(mobileNo);
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
