import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// id : 3
/// name : "Product 1"
/// description : "sample"
/// images : "[\"products\\/April2022\\/1Vl8o1iIiOC257UHXj3g.png\"]"
/// price : 110
/// discount_price : 10
/// discount_price_percentage : 100
/// quantity : 100
/// instock : "1"
/// status : "1"

class Product {
  Product(
    this.id,
    this.name,
    this.description,
    this.images,
    this.price,
    this.discountPrice,
    this.discountPricePercentage,
    this.quantity,
    this.instock,
    this.status,
  );

  Product.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    images = List<String>.from(
        jsonDecode(json['images'].toString().replaceAll(r"\", "")));
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPricePercentage = json['discount_price_percentage'];
    quantity = json['quantity'];
    instock = json['instock'];
    status = json['status'];
  }
  late int id;
  late String name;
  late String description;
  late List<String> images;
  late int price;
  late int discountPrice;
  late int discountPricePercentage;
  late int quantity;
  late String instock;
  late String status;
  RxBool isOnCart = false.obs;
  RxInt counter = 0.obs;
  RxInt priceCounter = 0.obs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['images'] = images;
    map['price'] = price;
    map['discount_price'] = discountPrice;
    map['discount_price_percentage'] = discountPricePercentage;
    map['quantity'] = quantity;
    map['instock'] = instock;
    map['status'] = status;
    return map;
  }
}
