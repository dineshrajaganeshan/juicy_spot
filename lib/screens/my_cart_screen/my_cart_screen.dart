import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/Cart_list.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/screens/my_cart_screen/my_cart_screen_controller.dart';
import 'package:juicy_spot/utils/constant.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/const_widget.dart';
import 'package:juicy_spot/widgets/my_seperator.dart';

class MyCart extends GetView<MyCartScreenController> {
  @override
  final controller = Get.put(MyCartScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ellipseColor,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Obx(
                      () => GestureDetector(
                          onTap: () => {Get.toNamed(AppRoutes.MYACCOUNT)},
                          child: cachedImage(controller.imagePath.value,
                              radius: 20)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/addtocart.svg',
                    height: 25,
                    color: textColor,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Your Cart',
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => controller.cartLoading.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: CircularProgressIndicator(
                          color: buttonColor,
                        ),
                      )
                    : controller.cartList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: Text(
                              "No Products Found",
                              style: TextStyle(color: textColor),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width - 30,
                                    decoration: const BoxDecoration(
                                        color: ellipseColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white54,
                                              blurRadius: 5,
                                              spreadRadius: 3),
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(() => ListView.builder(
                                              itemBuilder: (_, index) =>
                                                  Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 10,
                                                ),
                                                child: _buildProduct(
                                                    controller.cartList[index]),
                                              ),
                                              itemCount:
                                                  controller.cartList.length,
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                            )),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const MySeparator(
                                          color: textColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Item',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Qty',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Amt',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const MySeparator(
                                          color: textColor,
                                        ),
                                        Obx(
                                          () => ListView.builder(
                                            itemBuilder: (_, index) {
                                              if (index ==
                                                  controller.cartList.length) {
                                                for (var element
                                                    in controller.cartList) {
                                                  controller.sumQty +=
                                                      element.quantity;
                                                  controller.sumAmt +=
                                                      element.products.price *
                                                          element.quantity;
                                                }
                                                return Column(
                                                  children: [
                                                    const MySeparator(
                                                      color: textColor,
                                                    ),
                                                    _buildBill(
                                                        "Total",
                                                        controller.sumQty,
                                                        controller.sumAmt),
                                                  ],
                                                );
                                              } else {
                                                return _buildBill(
                                                    controller.cartList[index]
                                                        .products.name,
                                                    controller.cartList[index]
                                                        .quantity,
                                                    controller.cartList[index]
                                                            .products.price *
                                                        controller
                                                            .cartList[index]
                                                            .quantity);
                                              }
                                            },
                                            itemCount:
                                                controller.cartList.length + 1,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                          ),
                                        ),
                                        const MySeparator(
                                          color: textColor,
                                        ),
                                        //_buildBill(),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Payment Method',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: 1,
                                                activeColor: buttonColor,
                                                groupValue: 1,
                                                onChanged: (val) {}),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text(
                                              'Cash On Delivery',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 2,
                                                activeColor: buttonColor,
                                                groupValue: 1,
                                                onChanged: (val) {}),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text(
                                              'Pay Online',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
          Obx(
            () => controller.cartList.isEmpty
                ? const SizedBox.shrink()
                : Positioned(
                    bottom: 0,
                    left: 100,
                    right: 100,
                    child: GestureDetector(
                      onTap: () {
                        controller.placeOrder();
                      },
                      child: Container(
                          width: Get.width * 0.5,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Place Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _buildProduct(Cart cartItem) {
    List<String> images =
        List<String>.from(json.decode(cartItem.products.images));
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          height: 140,
        ),
        Positioned(
          top: 30,
          child: Container(
            width: Get.width - 50,
            height: 110,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(38, 39, 43, 1),
                  Color.fromRGBO(52, 57, 63, 1),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          cartItem.products.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          cartItem.products.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Qty : ${cartItem.quantity}',
                              style: const TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              rupeeSym + "${cartItem.products.price}",
                              style: const TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.removeFromCart(cartItem);
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(38, 39, 43, 1),
                                      Color.fromRGBO(52, 57, 63, 1),
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
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 10,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: circleBgColor,
            child: cachedImage(IMAGE_BASE_URL + images.first,
                radius: 45, isProduct: true),
          ),
        ),
      ],
    );
  }

  _buildBill(String name, int quantity, int price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              rupeeSym + " $price",
              textAlign: TextAlign.end,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
