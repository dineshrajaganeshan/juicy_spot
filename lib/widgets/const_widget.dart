import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/custom_colors.dart';

divider() {
  return Container(
    width: 60,
    height: 4,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.withOpacity(0.5),
    ),
  );
}

cachedImage(
  String url, {
  bool isProduct = false,
  double radius = 60,
}) {
  return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (___, __, _) => CircleAvatar(
            backgroundColor: textColor,
            backgroundImage: AssetImage(isProduct
                ? "assets/images/noproduct.jpg"
                : "assets/images/Profile2.png"),
            radius: radius,
          ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundColor: circleBgColor,
            backgroundImage: CachedNetworkImageProvider(
              url,
              /*errorListener: () => CircleAvatar(
                backgroundColor: textColor,
                backgroundImage: AssetImage(isProduct
                    ? "assets/images/noproduct.jpg"
                    : "assets/images/Profile2.png"),
                radius: radius,
              ),*/
            ),
            radius: radius,
          ));
}
