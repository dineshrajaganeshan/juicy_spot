import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/admin_background.dart';
import 'package:juicy_spot/widgets/edittext.dart';
import 'package:search_choices/search_choices.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  var items = ['Burger', 'Sandwich', 'Chicken', 'Grill', 'Parotta'];
  var selectedValueSingleDialogDarkMode = '';

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
                    SvgPicture.asset(
                      'assets/svg/offers.svg',
                      height: 25,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Offers',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: ellipseColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 5,
                          blurRadius: 20)
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: SearchChoices.single(
                    padding: 0,
                    items: items.map((item) {
                      return (DropdownMenuItem(
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: item,
                      ));
                    }).toList(),
                    value: selectedValueSingleDialogDarkMode,
                    hint: const Text(
                      "Category",
                      style: TextStyle(
                          color: editTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    searchHint: const Text(
                      "Choose Category",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                      color: editTextColor,
                      fontSize: 18,
                    ),
                    closeButton: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: buttonColor),
                      ),
                    ),
                    menuBackgroundColor: ellipseColor,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        selectedValueSingleDialogDarkMode = value;
                      });
                    },
                    isExpanded: true,
                    autofocus: false,
                    dialogBox: true,
                    iconSize: 35,
                    displayClearIcon: false,
                    underline: const SizedBox.shrink(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: ellipseColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 5,
                          blurRadius: 20)
                    ]),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: editTextColor,
                          borderRadius: BorderRadius.circular(24),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg'))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        child: SearchChoices.single(
                          padding: 0,
                          items: items.map((item) {
                            return (DropdownMenuItem(
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                              value: item,
                            ));
                          }).toList(),
                          value: selectedValueSingleDialogDarkMode,
                          hint: const Text(
                            "Food Name",
                            style: TextStyle(
                              color: editTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          searchHint: const Text(
                            "Select Food",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(
                            color: editTextColor,
                          ),
                          closeButton: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(color: buttonColor),
                            ),
                          ),
                          menuBackgroundColor: ellipseColor,
                          iconEnabledColor: editTextColor,
                          iconDisabledColor: editTextColor,
                          onChanged: (value) {
                            setState(() {
                              selectedValueSingleDialogDarkMode = value;
                            });
                          },
                          isExpanded: true,
                          autofocus: false,
                          dialogBox: true,
                          iconSize: 35,
                          displayClearIcon: false,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: EditText(
                        placeholder: 'Description',
                        controller: null,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: EditText(
                        placeholder: 'Offers',
                        controller: null,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cancel',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              width: 100,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                  child: Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
