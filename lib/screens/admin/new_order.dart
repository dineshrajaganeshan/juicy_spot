import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/admin_background.dart';

class NewOrders extends StatefulWidget {
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AdminBackground(),
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      'assets/svg/neworders.svg',
                      height: 25,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'New Orders',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16,right: 16,bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jun 29 2021',
                    style: TextStyle(color: textLightColor, fontSize: 15),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, index) => _buildOrderItem(),
                  itemCount: 10,
                  padding: const EdgeInsets.all(0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildOrderItem() {
    return InkWell(
      onTap: () {
        _orderDetail();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(38, 39, 43, 1),
              Color.fromRGBO(52, 57, 63, 1),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Priya',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '8695486954',
                      style: TextStyle(color: textColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Paid',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _orderDetail() {
    RxInt selectedStatus = 0.obs;

    return showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (_, __) {
            return Container(
              padding: const EdgeInsets.all(8),
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
                  Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Priya',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '8608952354',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black87,
                            spreadRadius: 1,
                            blurRadius: 5)
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                                  color: Colors.black87,
                                  spreadRadius: 1,
                                  blurRadius: 2)
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
                                  color: Colors.black87,
                                  spreadRadius: 1,
                                  blurRadius: 2)
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: ellipseColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              spreadRadius: 3,
                              blurRadius: 15),
                          BoxShadow(
                              color: Colors.black54,
                              spreadRadius: 5,
                              blurRadius: 20)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(()=>Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              selectedStatus(1);
                              // setState(() =>selectedStatus = 1);
                            },
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: selectedStatus.value == 1
                                    ? textColor
                                    : ellipseColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Conform',
                                  style: TextStyle(
                                      color: selectedStatus.value == 1
                                          ? ellipseColor
                                          : textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),),
                        Obx(()=>Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              selectedStatus(2);
                            },
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: selectedStatus.value == 2
                                    ? textColor
                                    : ellipseColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Cooking',
                                  style: TextStyle(
                                      color: selectedStatus.value == 2
                                          ? ellipseColor
                                          : textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),),
                        Obx(()=>Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              selectedStatus(3);
                            },
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: selectedStatus.value == 3
                                    ? textColor
                                    : ellipseColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Delivered',
                                  style: TextStyle(
                                      color: selectedStatus.value == 3
                                          ? ellipseColor
                                          : textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}
