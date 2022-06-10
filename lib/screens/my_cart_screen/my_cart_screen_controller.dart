import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/data_models/cart_list.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/utils/constant.dart';

class MyCartScreenController extends GetxController {
  RxString imagePath = "".obs;
  RxBool cartLoading = false.obs;
  String authKey = "";
  String timeStampPaymentId = "";
  String timeStampOrderId = "";
  RxString address="".obs;

  var sumQty = 0, sumAmt = 0;
  RxString paymentMode = 'COD'.obs;

  RxList<Cart> cartList = RxList();

  final _box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCartList();
    address(_box.read(LOCATION));
    imagePath(_box.read(IMAGE_PATH));
    authKey = _box.read(AUTHORIZATION_KEY);
    timeStampPaymentId = DateTime.now().millisecondsSinceEpoch.toString();
    timeStampOrderId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  getCartList() async {
    if (await isNetConnected()) {
      cartLoading(true);
      List<Cart>? response = await ApiCall().cartList(authKey);
      cartLoading(false);
      if (response != null) {
        cartList(response);
      }
    }
  }

  removeFromCart(Cart cartItem) async {
    if (await isNetConnected()) {
      cartLoading(true);
      final response = await ApiCall().removeFromCart(cartItem.id, authKey);
      cartLoading(false);
      if (response != null) {
        if (response["success"]) {
          cartList.remove(cartItem);
          cartItem.products.isOnCart(false);
        }
        showToastMsg(response["message"]);
      }
    }
  }

/*  orderDetailsToCart() async {
    if (await isNetConnected()) {
      final response = await ApiCall().payment(timeStamp, "CASH",
          sumAmt.toString(), authKey, "SUCCESS", "COD", timeStamp);
      if (response != null) {
        if (response["success"]) {}
        showToastMsg(response["message"]);
      }
    }
  }*/

  Future placeOrder() async {
    if (await isNetConnected()) {
      cartLoading(true);
      final response = await ApiCall().cartToPayment(
          timeStampPaymentId,
          paymentMode.value == 'COD' ? 'CASH' : 'UPI',
          sumAmt.toString(),
          authKey,
          "SUCCESS",
          paymentMode.value,
          timeStampOrderId);
      cartLoading(false);
      if (response != null) {
        if (response["success"]) {
          await showAlert('Order Placed!', response['message'], 'My Order',
              isDismiss: false, isOneButton: true);
          Get.offAndToNamed(AppRoutes.ORDERHISTORY);
        }
      }
    }
  }
}
