import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  final bool isGrid;
  final bool isPadding;
  final double catPadding = 4;
  const ProductShimmer({Key? key, this.isGrid = false, this.isPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.grey,
      enabled: true,
      child: isGrid && isPadding
          ? Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProduct(),
                _buildProduct(),
              ],
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildProduct(),
                  _buildProduct(),
                  _buildProduct(),
                ],
              ),
            ),
    );
  }

  _buildProduct() {
    return Stack(
      fit: StackFit.loose,
      children: [
        SizedBox(width: Get.width / 2, height: 250),
        Positioned(
          top: 60,
          child: Container(
            width: Get.width / 2.2,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 10,
                              width: 60,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 23,
                              width: 70,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 20,
                                width: 22,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 25,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
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
        ),
        const Positioned(
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 65,
            backgroundColor: circleBgColor,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 60,
            ),
          ),
        ),
      ],
    );
  }
}
