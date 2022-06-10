import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';
import 'package:juicy_spot/widgets/const_widget.dart';
import 'package:juicy_spot/widgets/edittext.dart';

import 'profile_screen_controller.dart';

class ProfileScreen extends GetView<EditAccountController> {
  @override
  final controller = Get.put(EditAccountController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AppBackground(),
            Positioned(
                left: 20,
                top: 50,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: editTextColor,
                  onPressed: () {
                    Get.back();
                  },
                )),
            Positioned(
                left: 0,
                right: 0,
                top: 80,
                child: Center(
                  child: GestureDetector(
                    onTap: () => choosePhotoSheet(),
                    child: Stack(
                      children: [
                        Obx(
                          () => Hero(
                            tag: "profile",
                            child: Container(
                              width: 90,
                              height: 90,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: editTextColor,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 3,
                                        blurRadius: 10)
                                  ],
                                  image: controller.imagePath.isEmpty
                                      ? const DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.color),
                                          image: AssetImage(
                                            "assets/images/Profile2.png",
                                          ),
                                          fit: BoxFit.cover)
                                      : GetUtils.isURL(
                                              controller.imagePath.value)
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  controller.imagePath.value),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: FileImage(File(
                                                  controller.imagePath.value)),
                                              fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                                color: buttonColor, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 230,
              left: 30,
              right: 30,
              child: Column(
                children: [
                  EditText(
                    placeholder: 'Name',
                    textColor: textColor,
                    controller: controller.nameController,
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  EditText(
                    placeholder: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                    textColor: textColor,
                    readOnly: true,
                    maxLength: 10,
                    controller: controller.mobileNumberController,
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  EditText(
                    placeholder: 'Mail Id',
                    textColor: textColor,
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.mailIdController,
                    readOnly: false,
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  EditText(
                    placeholder: 'Location',
                    textColor: textColor,
                    isMaxNull: true,
                    maxLines: 3,
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    controller: controller.locationController,
                    suffixIcon: const Icon(
                      Icons.navigation,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() => controller.isLoading.value
                      ? Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(6),
                          //margin: EdgeInsets.only(right: 40),
                          child: const CircularProgressIndicator(
                            color: buttonColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () => controller.submit(),
                          child: Container(
                              width: 100,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                  child: Text(
                                controller.isRegister ? 'Register' : 'Update',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))),
                        )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  choosePhotoSheet() {
    return showModalBottomSheet(
        context: Get.context!,
        elevation: 10,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 168,
            decoration: const BoxDecoration(
                color: ellipseColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: 3, blurRadius: 15),
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 5, blurRadius: 20)
                ]),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                divider(),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Choose From",
                  style: TextStyle(color: editTextColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.pickImageCamera();
                  },
                  child: const ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 2,
                  //thickness: 2,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.pickImageGallery();
                  },
                  child: const ListTile(
                      dense: true,
                      leading: Icon(Icons.photo, color: Colors.white),
                      title: Text(
                        "Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        });
  }
}
