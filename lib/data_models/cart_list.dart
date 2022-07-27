import 'package:juicy_spot/data_models/product.dart';

/// id : 2
/// user_id : 18
/// product_id : 3
/// quantity : 10
/// status : "1"
/// created_at : "2022-05-18T09:04:55.000000Z"
/// updated_at : "2022-05-18T12:06:26.000000Z"
/// products : {"id":3,"default_category_id":1,"name":"Product 1","slug":"product-1","reference":"pro1","description":"sample","images":"[\"products\\/April2022\\/1Vl8o1iIiOC257UHXj3g.png\"]","price":110,"discount_price":10,"discount_price_percentage":100,"quantity":100,"instock":"1","status":"1","created_at":"2022-04-14T10:20:00.000000Z","updated_at":"2022-04-14T10:23:26.000000Z"}

class Cart {
  Cart(
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.products,
  );

  Cart.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    products =
        (json['products'] != null ? Product.fromJson(json['products']) : null)!;
  }
  late int id;
  late int userId;
  late int productId;
  late int quantity;
  late String status;
  late String createdAt;
  late String updatedAt;
  late Product products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['products'] = products.toJson();
    return map;
  }
}
