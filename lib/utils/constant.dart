import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'custom_colors.dart';

//for using sessison
const MOBILE_NO = 'MOBILE_NO';
const PASSWORD = 'PASSWORD';
const CONFIRM_PASSWORD = 'CONFIRM_PASSWORD';
const OTP = 'OTP';
const IS_LOGIN = 'IS_LOGIN';
const IN_HOME_SCREEN = 'IN_HOME_SCREEN';
const MAIL_ID = 'MAIL_ID';
const LOCATION = 'LOCATION';
const NAME = 'NAME';
const IMAGE_PATH = "IMAGE_PATH";
const AUTHORIZATION_KEY = 'AUTHORIZATION_KEY';

const rupeeSym = "₹";

var connectivity = Connectivity();

isNetConnected() async {
  bool res =
      (await connectivity.checkConnectivity()) != ConnectivityResult.none;
  if (!res) {
    const AdvanceSnackBar(
      mode: Mode.ADVANCE,
      message: 'Check Your Internet Connection',
      bgColor: ellipseColor,
      textColor: textColor,
      isFixed: true,
      fontWeight: FontWeight.w400,
      textSize: 15,
      icon: Icon(
        Icons.signal_cellular_connected_no_internet_4_bar,
        color: Colors.white,
      ),
    ).show(Get.context!);
  }
  return res;
}

showToastMsg(
  String msg, {
  String? title,
  Color? background,
}) {
  AdvanceSnackBar(
    message: msg,
    // bgColor: background ?? const Color(0xFF323232), //default color ena potruka??
    bgColor: background ?? ellipseColor,
    textColor: background != null ? Colors.white : Colors.white,
    isFixed: true,
    fontWeight: FontWeight.w400,
    textSize: 15,
  ).show(Get.context!);
}

share(String link, {String? title}) async {
  await Share.share(link, subject: title);
}

call(String mobileNo) async {
  if (mobileNo.length < 10) return;
  String url = 'tel:$mobileNo';
  openUrl(url);
}

openMap(String latitude, String longitude, String label) async {
  // String googleUrl = 'https://www.google.com/maps/search/?query=$latitude,$longitude';
  // String googleUrl = 'geo:$latitude,$longitude';
  String url = '';
  if (Platform.isAndroid) {
    url = 'geo:$latitude,$longitude?q=$latitude,$longitude($label)';
  } else {
    url = 'https://maps.apple.com/?q=$latitude,$longitude';
  }
  openUrl(url);
}

openUrl(String url, {bool forceWebView = false, bool? enableJavaScript}) async {
  if (url.isEmpty) return;
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url,
        webViewConfiguration: WebViewConfiguration(
          enableJavaScript: enableJavaScript ?? true,
        ),
        mode: forceWebView
            ? LaunchMode.inAppWebView
            : LaunchMode.externalApplication);
  } else {
    showToastMsg('Something went wrong');
  }
}

openWhatsapp(String text) async {
  var uriAndroid = "whatsapp://send?text=$text";
  var urlIos = "https://wa.me/text=$text}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrlString(urlIos)) {
      await launchUrlString(
        urlIos,
      );
    } else {
      showToastMsg("whatsapp not installed");
    }
  } else {
    // android , web
    if (await canLaunchUrlString(uriAndroid)) {
      await launchUrlString(uriAndroid);
    } else {
      showToastMsg("whatsapp not installed");
    }
  }
}


showAlert(String title, String msg, String posBtnText,
    {bool isDismiss = true, bool isOneButton = false}) {
  Get.focusScope?.unfocus();
  return showDialog(
    context: Get.context!,
    barrierDismissible: isDismiss,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(color: textColor,),
              Text(
                msg,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isOneButton
                      ? const SizedBox(
                    width: 100,
                    height: 35,
                  )
                      :  GestureDetector(
                    onTap: () => {Get.back(result: false)},
                    child: Container(
                        height: 30,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ))),),
                  GestureDetector(
                    onTap: () => {Get.back(result: true)},
                    child: Container(
                        height: 30,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Center(
                            child: Text(
                              posBtnText,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ))),)
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}