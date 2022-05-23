import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/api/api_call.dart';
import 'package:juicy_spot/data_models/product.dart';
import 'package:juicy_spot/utils/constant.dart';

class ProductScreenController extends GetxController {
  List<String> images = Get.arguments["images"];
  Product product = Get.arguments["product"];
  RxInt currentImage = 0.obs;

  RxBool productLoading = false.obs;

  final _box = GetStorage();

  decrementCounter() {
    if (product.counter.value > 0) {
      product.counter(product.counter.value - 1);
    }
  }

  incrementCounter() {
    if (product.counter.value < 20) {
      product.counter(product.counter.value + 1);
    }
  }

  Future addingToCart() async {
    if (await isNetConnected()) {
      if (product.counter.value != 0) {
        productLoading(true);
        final response = await ApiCall().addToCart(
            product.id, product.counter.value, _box.read(AUTHORIZATION_KEY));
        productLoading(false);
        if (response != null) {
          if (response["success"]) {
            // product.isOnCart(true);
          }
          showToastMsg(response["message"]);
        }
      }
    }
  }
}
