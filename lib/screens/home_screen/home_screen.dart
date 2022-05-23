import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/product.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/screens/home_screen/home_screen_controller.dart';
import 'package:juicy_spot/utils/constant.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/const_widget.dart';
import 'package:juicy_spot/widgets/shimmer/menu_shimmer.dart';
import 'package:juicy_spot/widgets/shimmer/product_shimmer.dart';

import '../../data_models/category.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  final controller = Get.put(HomeScreenController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87, spreadRadius: 3, blurRadius: 15),
                    BoxShadow(
                        color: Colors.black54, spreadRadius: 5, blurRadius: 20)
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                            onTap: () => {Get.toNamed(AppRoutes.MYACCOUNT)},
                            child: cachedImage(controller.imagePath.value,
                                radius: 20)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(
                        () => Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.name.value,
                              style: const TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: textColor),
                            ),
                            Text(
                              controller.address.value,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  color: editTextColor),
                            )
                          ],
                        )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          'assets/images/cart.png',
                          height: 50,
                        ),
                        onTap: () {
                          Get.toNamed(AppRoutes.MYCART);
                        },
                      ),
                    ],
                  ),
                  /* const SizedBox(
                    height: 16,
                  ),*/
                  /*Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    */ /*   child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                                height: 0, fontWeight: FontWeight.bold),
                            cursorColor: editTextColor,
                            decoration: const InputDecoration(
                              filled: false,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Search Food',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SvgPicture.asset('assets/svg/search.svg'),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),*/ /*
                  ),*/
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Our Menu\'s',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => controller.menuLoading.value
                          ? const MenuShimmer()
                          : SizedBox(
                              height: 50,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (_, index) =>
                                    _buildCatMenu(controller.menuList[index]),
                                itemCount: controller.menuList.length,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Latest Updates',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => controller.productLoading.value
                          ? const ProductShimmer()
                          : SizedBox(
                              height: 270,
                              width: Get.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (_, index) => _buildProduct(
                                  controller.productList[index],
                                ),
                                itemCount: controller.productList.length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                    ),
                    /*const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Most Popular',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => controller.menuLoading.value
                          ? Shimmer.fromColors(
                              baseColor: Colors.white24,
                              highlightColor: Colors.grey,
                              enabled: true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 220,
                                        ),
                                        Positioned(
                                          top: 45,
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black54,
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 70,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                              child: Container(
                                                                height: 10,
                                                                width: 60,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                              child: Container(
                                                                height: 23,
                                                                width: 70,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 15,
                                                        width: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              height: 10,
                                                              width: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 25,
                                                        height: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 0,
                                          left: 20,
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundColor: circlebgColor,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black54,
                                              radius: 50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 220,
                                        ),
                                        Positioned(
                                          top: 45,
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black54,
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 70,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                              child: Container(
                                                                height: 10,
                                                                width: 60,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                              child: Container(
                                                                height: 23,
                                                                width: 70,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 15,
                                                        width: 30,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              height: 10,
                                                              width: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 25,
                                                        height: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 0,
                                          left: 20,
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundColor: circlebgColor,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black54,
                                              radius: 50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 220,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (_, index) => _buildProduct(
                                    controller.productList[index]),
                                itemCount: controller.productList.length,
                              ),
                            ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Our Speciality',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 130,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) => _buildOffer(),
                        itemCount: 6,
                      ),
                    ),*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCatMenu(Category menuItem) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedMenu(menuItem);
          controller.getProductsByCategory(menuItem.id);
          _openCatItems(menuItem);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            gradient: (controller.selectedMenu.value == null ||
                    controller.selectedMenu.value != menuItem)
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(38, 39, 43, 1),
                      Color.fromRGBO(52, 57, 63, 1),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      buttonColor,
                      buttonColor,
                    ],
                  ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: const [
              BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
                child: Text(
              menuItem.name,
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }

  _buildProduct(
    Product productItem,
  ) {
    List<String> images = List<String>.from(json.decode(productItem.images));
    for (var element in images) {
      element = IMAGE_BASE_URL + element;
    }
    return Stack(
      fit: StackFit.loose,
      children: [
        SizedBox(
          width: Get.width / 2,
          height: 200,
        ),
        Positioned(
          top: 60,
          child: Container(
            width: Get.width / 2.2,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(38, 39, 43, 1),
                  Color.fromRGBO(52, 57, 63, 1),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.PRODUCTSCREEN,
                      arguments: {
                        'product': productItem,
                        'images': images,
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              productItem.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              productItem.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "$rupeeSym ${productItem.price.toString()}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: textColor,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 17,
                                ),
                              ),
                              onTap: () {
                                controller
                                    .decrementCounter(productItem.counter);
                              },
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "${productItem.counter.value}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: textColor,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 17,
                                ),
                              ),
                              onTap: () {
                                controller
                                    .incrementCounter(productItem.counter);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Obx(
                        () => GestureDetector(
                          child: Image.asset(
                            'assets/images/cartt.png',
                            height: 25,
                            color: productItem.isOnCart.value
                                ? Colors.white
                                : Colors.white,
                          ),
                          onTap: controller.isCartLoading.value
                              ? null
                              : () {
                                  controller.addingToCart(
                                      productItem.id,
                                      productItem.counter,
                                      productItem.isOnCart);
                                },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 15,
          //right: 12,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.PRODUCTSCREEN,
                arguments: {
                  'product': productItem,
                  'images': images,
                },
              );
            },
            child: CircleAvatar(
              radius: 65,
              backgroundColor: circleBgColor,
              child:
                  cachedImage(IMAGE_BASE_URL + images.first, isProduct: true),
            ),
          ),
        ),
      ],
    );
  }

  /*_buildOffer() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 260,
        height: 130,
        child: Stack(
          children: [
            Container(
              width: 250,
              height: 110,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(38, 39, 43, 1),
                    Color.fromRGBO(52, 57, 63, 1),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: 1, blurRadius: 5)
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.favorite,
                                size: 15,
                                color: buttonColor,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Veg Sandwich',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '\$ 200',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Order Now',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: textColor, offset: Offset(0, -3))
                                ],
                                color: Colors.transparent,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                decorationThickness: 3,
                                decorationColor: textColor),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 100,
              height: 110,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(24)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg',
                    ),
                  )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: buttonColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87, spreadRadius: 1, blurRadius: 5),
                  ],
                ),
                child: const Center(
                    child: Text(
                  '10 %\n Off',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 15),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  _openCatItems(Category menuItem) async {
    return showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              controller.selectedMenu.value = null;
              return true;
            },
            child: Container(
              height: Get.height - 220,
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
                    height: 4,
                  ),
                  Text(
                    menuItem.name,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 22),
                  ),
                  Obx(() => controller.catProductLoading.value
                      ? const ProductShimmer(
                          isGrid: true,
                          isPadding: true,
                        )
                      : controller.productListByCategory.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Text(
                                "No Products Found",
                                style: TextStyle(color: textColor),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 2,
                                          childAspectRatio: 0.1),
                                  itemCount:
                                      controller.productListByCategory.length,
                                  physics: controller
                                              .productListByCategory.length >
                                          4
                                      ? const BouncingScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(left: 10),
                                  itemBuilder: (_, index) {
                                    return _buildProduct(
                                      controller.productListByCategory[index],
                                    );
                                  }),
                            )),
                ],
              ),
            ),
          );
        });
  }
}
