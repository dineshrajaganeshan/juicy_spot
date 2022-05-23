import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:juicy_spot/utils/custom_colors.dart';
import 'package:timelines/timelines.dart';

class ProcessTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ellipseColor,
      body: SafeArea(
        child: Timeline.tileBuilder(
          theme: TimelineThemeData(
            direction: Axis.horizontal,
            connectorTheme: const ConnectorThemeData(space: 30, thickness: 5),
          ),
          builder: TimelineTileBuilder.connected(
              itemCount: 3,
              connectionDirection: ConnectionDirection.before,
              itemExtentBuilder: (_, __) => Get.width / 3,
              oppositeContentsBuilder: (_, index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          topLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/location.svg',
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              contentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    index == 0 ? 'Confirmed' : index == 1 ? 'Cooking' : 'Delivered',
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        fontStyle: FontStyle.italic),
                  ),
                );
              },
              indicatorBuilder: (_, index) {
                return SizedBox(
                  width: 13,
                  height: 13,
                  child: index == 2
                      ? const CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor: AlwaysStoppedAnimation(buttonColor),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                              color: buttonColor, shape: BoxShape.circle),
                        ),
                );
              },
              connectorBuilder: (_, index, type) {
                return const SolidLineConnector(
                  color: buttonColor,
                  thickness: 4,
                );
              }),
        ),
      ),
    );
  }
}
