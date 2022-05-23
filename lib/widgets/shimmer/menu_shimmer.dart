import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MenuShimmer extends StatelessWidget {
  const MenuShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.grey,
      enabled: true,
      child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            _buildMenu(),
            _buildMenu(),
            _buildMenu(),
          ]),
    );
  }

  _buildMenu(){
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 35,
      width: 105,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(8)),
        color: Colors.black54,
      ),
    );
  }

}
