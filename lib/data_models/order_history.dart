/// id : 21
/// order_id : "1653486465649"
/// payment_id : "1653486465649"
/// user_id : "33"
/// total_amount : "770"
/// order_type : "group"
/// status : "failed"
/// created_at : "2022-05-25T13:47:51.000000Z"
/// updated_at : "2022-05-25T13:47:52.000000Z"
/// payment_details : {"id":16,"user_id":"33","order_id":"1653486465649","payment_id":"1653486465649","payment_from":"COD","payment_type":"CASH","amount":"770","status":"failed","created_at":"2022-05-25T13:47:52.000000Z","updated_at":"2022-05-25T13:47:52.000000Z"}
/// order_details : [{"id":51,"order_id":"21","user_id":"33","cart_id":"45","product_id":"3","product_name":"Product 1","quantity":"7","price":"110","total_amount":"770","status":"failed","created_at":"2022-05-25T13:47:50.000000Z","updated_at":"2022-05-25T13:47:52.000000Z","products":{"id":3,"default_category_id":1,"name":"Product 1","slug":"product-1","reference":"pro1","description":"sample","images":"[\"products\\/April2022\\/1Vl8o1iIiOC257UHXj3g.png\"]","price":110,"discount_price":10,"discount_price_percentage":100,"quantity":100,"instock":"1","status":"1","created_at":"2022-04-14T10:20:00.000000Z","updated_at":"2022-04-14T10:23:26.000000Z"}}]

class OrderHistory {
  OrderHistory(
    this.id,
    this.orderId,
    this.paymentId,
    this.userId,
    this.totalAmount,
    this.orderType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentDetails,
    this.orderDetails,
  );

  OrderHistory.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    paymentId = json['payment_id'];
    userId = json['user_id'];
    totalAmount = json['total_amount'];
    orderType = json['order_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentDetails = (json['payment_details'] != null
        ? PaymentDetails.fromJson(json['payment_details'])
        : null)!;
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }
  late int id;
  late String orderId;
  late String paymentId;
  late String userId;
  late String totalAmount;
  late String orderType;
  late String status;
  late String createdAt;
  late String updatedAt;
  late PaymentDetails paymentDetails;
  late List<OrderDetails> orderDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['payment_id'] = paymentId;
    map['user_id'] = userId;
    map['total_amount'] = totalAmount;
    map['order_type'] = orderType;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['payment_details'] = paymentDetails.toJson();
    map['order_details'] = orderDetails.map((v) => v.toJson()).toList();
    return map;
  }
}

/// id : 51
/// order_id : "21"
/// user_id : "33"
/// cart_id : "45"
/// product_id : "3"
/// product_name : "Product 1"
/// quantity : "7"
/// price : "110"
/// total_amount : "770"
/// status : "failed"
/// created_at : "2022-05-25T13:47:50.000000Z"
/// updated_at : "2022-05-25T13:47:52.000000Z"
/// products : {"id":3,"default_category_id":1,"name":"Product 1","slug":"product-1","reference":"pro1","description":"sample","images":"[\"products\\/April2022\\/1Vl8o1iIiOC257UHXj3g.png\"]","price":110,"discount_price":10,"discount_price_percentage":100,"quantity":100,"instock":"1","status":"1","created_at":"2022-04-14T10:20:00.000000Z","updated_at":"2022-04-14T10:23:26.000000Z"}

class OrderDetails {
  OrderDetails(
    this.id,
    this.orderId,
    this.userId,
    this.cartId,
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  );

  OrderDetails.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    price = json['price'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  late int id;
  late String orderId;
  late String userId;
  late String cartId;
  late String productId;
  late String productName;
  late String quantity;
  late String price;
  late String totalAmount;
  late String status;
  late String createdAt;
  late String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['user_id'] = userId;
    map['cart_id'] = cartId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['quantity'] = quantity;
    map['price'] = price;
    map['total_amount'] = totalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;

    return map;
  }
}

/// id : 16
/// user_id : "33"
/// order_id : "1653486465649"
/// payment_id : "1653486465649"
/// payment_from : "COD"
/// payment_type : "CASH"
/// amount : "770"
/// status : "failed"
/// created_at : "2022-05-25T13:47:52.000000Z"
/// updated_at : "2022-05-25T13:47:52.000000Z"

class PaymentDetails {
  PaymentDetails(
    this.id,
    this.userId,
    this.orderId,
    this.paymentId,
    this.paymentFrom,
    this.paymentType,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  );

  PaymentDetails.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    paymentId = json['payment_id'];
    paymentFrom = json['payment_from'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  late int id;
  late String userId;
  late String orderId;
  late String paymentId;
  late String paymentFrom;
  late String paymentType;
  late String amount;
  late String status;
  late String createdAt;
  late String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['order_id'] = orderId;
    map['payment_id'] = paymentId;
    map['payment_from'] = paymentFrom;
    map['payment_type'] = paymentType;
    map['amount'] = amount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
