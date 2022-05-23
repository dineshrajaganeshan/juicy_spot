import 'package:juicy_spot/data_models/product.dart';

class ProductByCategory {
  late int id;
  late int order;
  late String name;
  List<Product>? productDetails;

  ProductByCategory(this.id, this.order, this.name, this.productDetails);

  ProductByCategory.fromJson(dynamic json) {
    id = json["id"];
    order = json["order"];
    name = json["name"];

    if (json["products"] != null) {
      productDetails = [];
      json["products"].forEach((v) {
        productDetails!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["order"] = order;
    map["name"] = name;
    if (productDetails != null) {
      map["products"] = productDetails!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
