import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/user.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class EditAccountController extends GetxController {
  final mobileNumberController = TextEditingController();
  final mailIdController = TextEditingController();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  String authKey = "";
  String passWord = "";

  RxString imagePath = "".obs;
  RxBool isLoading = false.obs;

  bool isRegister = Get.arguments;

  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    mobileNumberController.text = _box.read(MOBILE_NO) ?? "";
    mailIdController.text = _box.read(MAIL_ID) ?? "";
    nameController.text = _box.read(NAME) ?? "";
    locationController.text = _box.read(LOCATION) ?? "";
    authKey = _box.read(AUTHORIZATION_KEY) ?? "";
    passWord = _box.read(PASSWORD) ?? "";
    imagePath(_box.read(IMAGE_PATH) ?? "");
    debugPrint("IMAGEPATH: ${imagePath}");
  }

  submit() async {
    Get.focusScope?.unfocus(); // keyboard hidden
    if (nameController.text.isEmpty) {
      showToastMsg(
        "Please Enter Name ",
      );
    } else if (mobileNumberController.text.isEmpty) {
      showToastMsg(
        "Please Enter Mobile number ",
      );
    } else if (mailIdController.text.isEmpty) {
      showToastMsg(
        "Please Enter your mailIid ",
      );
    } else if (locationController.text.isEmpty) {
      showToastMsg(
        "Please Enter Mobile Number ",
      );
    } else {
      if (isRegister) {
        debugPrint("password: ${_box.read(PASSWORD)}");
        isLoading(true);
        var response = await ApiCall().registerUserData(
            nameController.text,
            mobileNumberController.text,
            mailIdController.text,
            passWord,
            locationController.text,
            imagePath.value);
        isLoading(false);
        if (response != null) {
          if (response['success']) {
            User user = User.fromJson(response['data']);
            _box.write(NAME, user.name);
            _box.write(LOCATION, user.address);
            _box.write(MAIL_ID, user.mailId);
            _box.write(IMAGE_PATH, IMAGE_BASE_URL + user.imagePath!);
            _box.write(AUTHORIZATION_KEY, response['response']);
            _box.write(IS_LOGIN, true);
            showToastMsg(response['message']);
            Get.offAllNamed(AppRoutes.HOMESCREEN);
          } else {
            showToastMsg(response['message']);
          }
        }
      } else {
        isLoading(true);
        var response = await ApiCall().updateUserData(
            mobileNumberController.text,
            locationController.text,
            mailIdController.text,
            nameController.text,
            _box.read(PASSWORD),
            imagePath.value,
            authKey);
        isLoading(false);
        if (response != null) {
          if (response['success']) {
            _box.write(NAME, nameController.text);
            _box.write(LOCATION, locationController.text);
            _box.write(MAIL_ID, mailIdController.text);
            _box.write(IMAGE_PATH,
                IMAGE_BASE_URL + response['data']['avatar']);
            showToastMsg(response['message']);
            Get.offAllNamed(AppRoutes.HOMESCREEN);
          } else {
            showToastMsg(response['message']);
          }
        }
      }
    }
  }

  Future pickImageCamera() async {
    var res = await ImagePicker().pickImage(source: ImageSource.camera);
    if (res == null) return;
    imagePath(res.path);
  }

  Future pickImageGallery() async {
    var res = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (res == null) return;
    imagePath(res.path);
  }
}
