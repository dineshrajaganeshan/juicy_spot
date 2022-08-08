import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/data_models/product_by_category.dart';
import 'package:juicy_spot/data_models/product.dart';
import 'package:juicy_spot/data_models/category.dart';
import 'package:juicy_spot/utils/constant.dart';

class HomeScreenController extends GetxController {
  RxString name = "".obs;
  RxString address = "".obs;
  RxString imagePath = "".obs;

  RxBool menuLoading = false.obs;
  RxBool productLoading = false.obs;
  RxBool catProductLoading = false.obs;
  RxBool isCartLoading = false.obs;
  String authKey = "";

  Rx<Category?> selectedMenu = Rx(null);

  RxList menuList = RxList();
  RxList productList = RxList();
  RxList productListByCategory = RxList();

  final _box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    /*String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("FireBase token: ${token}");*/
    name(_box.read(NAME) ?? "");
    address(_box.read(LOCATION) ?? "");
    imagePath(_box.read(IMAGE_PATH) ?? "");
    debugPrint("profile image: $imagePath");
    authKey = _box.read(AUTHORIZATION_KEY) ?? '';
    getCategoryList();
    getProductList();
  }

  decrementCounter(RxInt counter) {
    if (counter.value > 0) {
      counter(counter.value - 1);
    }
  }

  incrementCounter(RxInt counter) {
    if (counter.value < 20) {
      counter(counter.value + 1);
    }
  }

  getCategoryList() async {
    if (await isNetConnected()) {
      menuLoading(true);
      List<Category>? response = await ApiCall().categoryList(authKey);
      menuLoading(false);
      if (response != null) {
        menuList(response);
      }
    }
  }

  getProductList() async {
    if (await isNetConnected()) {
      productLoading(true);
      List<Product>? response = await ApiCall().productList(authKey);
      productLoading(false);
      if (response != null) {
        productList(response);
      }
    }
  }

  getProductsByCategory(int id) async {
    if (await isNetConnected()) {
      catProductLoading(true);
      ProductByCategory? response =
          await ApiCall().productByCategoryList(authKey, id);
      debugPrint("category product data: $response");
      catProductLoading(false);
      if (response != null) {
        productListByCategory(response.productDetails);
      } else {
        productListByCategory.clear();
      }
    }
  }

  Future addingToCart(
    int id,
    RxInt counter,
    RxBool isOnCart,
  ) async {
    if (await isNetConnected()) {
      if (counter.value != 0) {
        isCartLoading(true);
        isOnCart(true);
        final response = await ApiCall()
            .addToCart(id, counter.value, _box.read(AUTHORIZATION_KEY));
        isCartLoading(false);
        isOnCart(false);
        if (response != null) {
          if (response["success"]) {
            // isOnCart(true);
          }
          showToastMsg(response["message"]);
        }
      }
    }
  }
}
