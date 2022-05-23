import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          Positioned(
              left: 20,
              right: 20,
              top: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: editTextColor,
                    ),
                  ),
                  Text(
                    'Juicy Spot',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: textColor,
                    backgroundImage: NetworkImage(
                        'https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg'),
                  ),
                ],
              )),
          Positioned(
            top: 160,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                ),
                Container(
                    width: 200,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Order History',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SvgPicture.asset(
                          'assets/svg/orderhistory.svg',
                          height: 20,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.7,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => _buildOrders(),
                    itemCount: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildOrders() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'May 04 2021',
            style: TextStyle(color: textLightColor, fontSize: 13),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Item',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Qty',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Amt',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
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
                            blurRadius: 2)
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Veg Sandwich',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '2',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '\$160',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 3,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
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
                          color: Colors.black87, spreadRadius: 1, blurRadius: 2)
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      'Total',
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 1,
                child: Container(
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
                          color: Colors.black87, spreadRadius: 1, blurRadius: 2)
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      '\$ 300',
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
