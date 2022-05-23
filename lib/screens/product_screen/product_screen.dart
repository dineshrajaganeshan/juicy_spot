import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/screens/product_screen/product_screen_controller.dart';
import 'package:juicy_spot/utils/constant.dart';
import 'package:juicy_spot/utils/custom_colors.dart';

class ProductScreen extends GetView<ProductScreenController> {
  @override
  final controller = Get.put(ProductScreenController());

  ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: Get.height * 0.52,
                    width: Get.width,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          controller.images.isNotEmpty
                              ? IMAGE_BASE_URL + controller.images[index]
                              : NO_IMAGE_URL,
                          height: Get.height / 1.8,
                          width: Get.width,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) {
                            return Image.network(NO_IMAGE_URL);
                          },
                        );
                      },
                      onPageChanged: (page) {
                        controller.currentImage(page);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: textColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              controller.images.length == 1
                  ? Container()
                  : Obx(
                      () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(controller.images.length, (index) {
                            return Container(
                                margin: const EdgeInsets.all(3),
                                width: controller.currentImage.value == index
                                    ? 15
                                    : 8,
                                height: controller.currentImage.value == index
                                    ? 10
                                    : 8,
                                decoration: BoxDecoration(
                                    color:
                                        controller.currentImage.value == index
                                            ? buttonColor
                                            : textColor,
                                    shape: BoxShape.circle));
                          })),
                    )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 130,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(38, 39, 43, 1),
                              Color.fromRGBO(52, 57, 63, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black87,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: textColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.remove,
                                  size: 15,
                                ),
                              ),
                              onTap: () {
                                controller.decrementCounter();
                              },
                            ),
                            Obx(
                              () => Text(
                                "${controller.product.counter}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: textColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                              onTap: () {
                                controller.incrementCounter();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.product.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.5, color: textColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Price",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$rupeeSym ${controller.product.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Obx(
                  () => controller.productLoading.value
                      ? Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(right: 70),
                          child: const CircularProgressIndicator(
                            color: buttonColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.addingToCart();
                          },
                          child: Container(
                            height: 45,
                            width: 200,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  buttonColor,
                                  buttonColor,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black87,
                                    spreadRadius: 1,
                                    blurRadius: 5)
                              ],
                            ),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller.product.isOnCart.value
                                      ? "Add To Cart"
                                      : "Add To Cart",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
