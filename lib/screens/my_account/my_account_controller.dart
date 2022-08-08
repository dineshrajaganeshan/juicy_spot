import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:juicy_spot/utils/constant.dart';

import '../../routes/app_routes.dart';

class MyAccountController extends GetxController {
  final mobileNumber = TextEditingController();
  final mailIdController = TextEditingController();
  final locationController = TextEditingController();

  RxString name = "".obs;
  RxString imagePath = "".obs;
  final _box = GetStorage();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    name(_box.read(NAME) ?? "");
    imagePath(_box.read(IMAGE_PATH) ?? "");
    debugPrint("IMAGE PATH: ${imagePath}");
    mobileNumber.text = _box.read(MOBILE_NO) ?? "";
    mailIdController.text = _box.read(MAIL_ID) ?? "";
    locationController.text = _box.read(LOCATION) ?? "";
  }

  rating() async {
    final InAppReview inAppReview = InAppReview.instance;
    //final available = await inAppReview.isAvailable();
    inAppReview.requestReview();
    inAppReview.openStoreListing();
  }

  logOut() async {
    //api call pannanum da inga sollirunthen

    await _box.erase();
    Get.offAllNamed(AppRoutes.SPLASHSCREEN);
  }
}
