import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:juicy_spot/widgets/background.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: textColor,
                      backgroundImage: NetworkImage(
                          'https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg'),
                    ),
                    Stack(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.notifications_on_outlined),
                            iconSize: 25,
                            color: Colors.white,
                            onPressed: () {}),
                        Positioned(
                          right: 12,
                          top: 15,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                                color: buttonColor, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'ADMIN',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 100,
              ),
              _buildMenu('New Orders', 'assets/svg/neworders.svg', () {}),
              const SizedBox(
                height: 32,
              ),
              _buildMenu('Update Food', 'assets/svg/updatefood.svg', () {}),
              const SizedBox(
                height: 32,
              ),
              _buildMenu('Offers', 'assets/svg/offers.svg', () {}),
              const SizedBox(
                height: 32,
              ),
              _buildMenu('Order History', 'assets/svg/orderhistory.svg', () {}),
            ],
          ),
        ],
      ),
    );
  }

  _buildMenu(String title, String svgpath, Function() onTab) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(38, 39, 43, 1),
            Color.fromRGBO(52, 57, 63, 1),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black87, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          SvgPicture.asset(
            svgpath,
            height: 20,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: const TextStyle(color: textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
