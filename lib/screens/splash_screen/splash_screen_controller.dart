import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_routes.dart';
import '../../utils/constant.dart';

class SplashScreenController extends GetxController {

  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    validation();
  }

  Future<void> validation() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (_box.read(IS_LOGIN) ?? false) {
      Get.offNamed(AppRoutes.HOMESCREEN);
    } else {
      Get.offNamed(AppRoutes.LOGIN);
    }
  }
}
