import 'package:flutter/material.dart';
import 'package:juicy_spot/utils/custom_colors.dart';

class SliderContainer extends StatelessWidget {
  bool isActive = false;
  SliderContainer(this.isActive);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: isActive ? 10 : 8,
      width: isActive ? 15 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? buttonColor : textColor,
      ),
    );
  }
}
