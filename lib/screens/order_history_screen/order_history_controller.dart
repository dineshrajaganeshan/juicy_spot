import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/data_models/order_history.dart';
import 'package:juicy_spot/utils/constant.dart';

class OrderHistoryController extends GetxController {
  final _box = GetStorage();
  RxBool orderHistoryLoading = false.obs;
  RxString imagePath = "".obs;

  RxList orderList = RxList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imagePath(_box.read(IMAGE_PATH) ?? "");
    getOrderHistory();
  }

  getOrderHistory() async {
    if (await isNetConnected()) {
      orderHistoryLoading(true);
      List<OrderHistory>? response =
          await ApiCall().fetchOrderHistory(_box.read(AUTHORIZATION_KEY));
      orderHistoryLoading(false);
      if (response != null) {
        orderList(response);
      }
    }
  }
}
