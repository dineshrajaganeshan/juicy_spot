import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/admin_background.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class AdminOrderHistory extends StatefulWidget {
  @override
  _AdminOrderHistoryState createState() => _AdminOrderHistoryState();
}

class _AdminOrderHistoryState extends State<AdminOrderHistory> {
  var selectedDate = DateTime.now();
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
                      'assets/svg/orderhistory.svg',
                      height: 25,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Order History',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              cwidget(),
            ],
          )
        ],
      ),
    );
  }

  Widget cwidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
          color: ellipseColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Colors.black87, spreadRadius: 3, blurRadius: 15),
            BoxShadow(color: Colors.black54, spreadRadius: 5, blurRadius: 20)
          ]),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() {
            selectedDate = date;
            _orderDetail();
            print(date);
          });
        },
        weekendTextStyle: const TextStyle(
          color: Colors.white,
        ),
        thisMonthDayBorderColor: Colors.transparent,
        headerTextStyle: const TextStyle(
            color: buttonColor, fontSize: 20, fontWeight: FontWeight.bold),
        height: 420,
        selectedDateTime: selectedDate,
        daysHaveCircularBorder: true,
        daysTextStyle: const TextStyle(color: Colors.white),
        leftButtonIcon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 25,
        ),
        rightButtonIcon: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 25,
        ),
        selectedDayBorderColor: buttonColor,
        selectedDayButtonColor: buttonColor,
        todayButtonColor: Colors.transparent,
        weekdayTextStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }

  _orderDetail() {
    return showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
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
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'May 02, 2021',
                                    style: TextStyle(
                                        color: textColor, fontSize: 14),
                                  ),
                                  Text(
                                    'Priya, 8608952354',
                                    style: TextStyle(
                                        color: textColor, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: buttonColor,
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(38, 39, 43, 1),
                                            Color.fromRGBO(52, 57, 63, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                                    child: const Center(
                                      child: Text(
                                        'Total',
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
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
                                    child: const Center(
                                      child: Text(
                                        '\$ 300',
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
