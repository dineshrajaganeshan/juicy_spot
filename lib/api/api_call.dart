import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:juicy_spot/api/url.dart';
import 'package:juicy_spot/data_models/cart_list.dart';
import 'package:juicy_spot/data_models/order_history.dart';
import 'package:juicy_spot/data_models/product.dart';
import 'package:juicy_spot/data_models/category.dart';
import 'package:juicy_spot/data_models/user.dart';
import 'package:juicy_spot/data_models/user_log_in.dart';

import '../data_models/product_by_category.dart';
import '../main.dart';
import '../utils/constant.dart';

class ApiCall {
  _getBaseToken() {
    return base64Encode(
        DateFormat('dd-MM-yyyy').format(DateTime.now()).codeUnits);
  }

  static final Dio _dio = Dio();
  static final ApiCall _instance = ApiCall._internal();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = BASE_URL;
    _dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  Future<dynamic> sendOTP(String mobileNo, String temp) async {
    var params = {"init_from": mobileNo, "for": temp};
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      log('request ${_dio.options.baseUrl}$OTP_SEND ${jsonEncode(params)}');
      final response = await _dio.post(
        OTP_SEND,
        data: params,
      );
      //after log res
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> verifyOTP(String otp, String mobileNo, String temp) async {
    var params = {"init_from": mobileNo, "for": temp, "otp": otp};
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();

      log('request ${_dio.options.baseUrl}$OTP_VERIFY ${jsonEncode(params)}');
      final response = await _dio.post(OTP_VERIFY, data: params);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> resetPassword(
      String password, String mobileNo, String temp) async {
    var params = {"init_from": mobileNo, "for": temp, "password": password};
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();

      log('request ${_dio.options.baseUrl}$RESET_PASSWORD ${jsonEncode(params)}');
      final response = await _dio.post(RESET_PASSWORD, data: params);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<UserLogIn?> userLogIn(String mobileNo, String passWord) async {
    var params = {
      "mobile": mobileNo,
      "password": passWord,
    };
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();

      log('request ${_dio.options.baseUrl}$LOGIN ${jsonEncode(params)}');
      final response = await _dio.post(LOGIN, data: params);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return UserLogIn.fromJson(response.data);
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> registerUserData(String name, String mobileNo, String mailId,
      String password, String address, String imagePath) async {
    try {
      MultipartFile? image;
      if (imagePath.isNotEmpty) {
        image = await MultipartFile.fromFile(imagePath);
      }
      var formData = FormData.fromMap({
        "mobile": mobileNo,
        "name": name,
        "email": mailId,
        "address": address,
        "password": password,
        "avatar": image
      });
      _dio.options.headers["basic-api-token"] = _getBaseToken();

      log('request ${_dio.options.baseUrl}$REGISTER');
      final response = await _dio.post(REGISTER, data: formData);
      log('response ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        log('data:  ${response.data}');
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> updateUserData(String mobileNo, String address, String mailId,
      String name, String password, String imagePath, String authKey) async {
    try {
      MultipartFile? image;
      if (imagePath.isNotEmpty) {
        image = await MultipartFile.fromFile(imagePath);
      }
      var formData = FormData.fromMap({
        "mobile": mobileNo,
        "name": name,
        "email": mailId,
        "address": address,
        "password": password,
        "avatar": image
      });
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$UPDATE');
      final response = await _dio.post(UPDATE, data: formData);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<List<Category>?> categoryList(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$CATEGORY');
      final response = await _dio.get(
        CATEGORY,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return (response.data as List)
            .map((x) => Category.fromJson(x))
            .toList();
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<List<Product>?> productList(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$PRODUCTLIST');
      final response = await _dio.get(
        PRODUCTLIST,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return (response.data as List).map((x) => Product.fromJson(x)).toList();
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<Product?> productView(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$PRODUCTVIEW');
      final response = await _dio.get(
        PRODUCTVIEW,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return Product.fromJson(response.data);
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<ProductByCategory?> productByCategoryList(
      String authKey, int productId) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      String PRODUCTCATEGORY = CATEGORY + "/$productId/" + "products";
      log('request ${_dio.options.baseUrl} $PRODUCTCATEGORY');
      final response = await _dio.get(
        PRODUCTCATEGORY,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return ProductByCategory.fromJson(response.data);
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> addToCart(
    int productId,
    int quantity,
    String authKey,
  ) async {
    var params = {"product_id": productId, "quantity": quantity};
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      log('request ${_dio.options.baseUrl}$ADDTOCART');
      final response = await _dio.post(ADDTOCART, data: params);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<List<Cart>?> cartList(
    String authKey,
  ) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      log('request ${_dio.options.baseUrl}$CARTLIST');
      final response = await _dio.get(
        CARTLIST,
      );
      log('response ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return (response.data as List).map((x) => Cart.fromJson(x)).toList();
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> removeFromCart(
    int productId,
    String authKey,
  ) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      String REMOVEFROMCART = ADDTOCART + "/$productId";
      log('request ${_dio.options.baseUrl}$REMOVEFROMCART');
      final response = await _dio.delete(
        REMOVEFROMCART,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> cartToOrderDetails(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$CARTTOORDERDETAILS');
      final response = await _dio.post(
        CARTTOORDERDETAILS,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> orderDetailsToCart(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$ORDERDETAILSTOCART');
      final response = await _dio.post(
        ORDERDETAILSTOCART,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> orderDetailsToOrder(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";

      log('request ${_dio.options.baseUrl}$ORDERDETAILSTOORDER');
      final response = await _dio.post(
        ORDERDETAILSTOORDER,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> payment(
    String paymentId,
    String paymentType,
    String amount,
    String authKey,
    String status,
    String paymentFrom,
    String orderId,
  ) async {
    var params = {
      "payment_id": paymentId,
      "payment_type": paymentType,
      "amount": amount,
      "status": status,
      "payment_from": paymentFrom,
      "order_id": orderId,
    };
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      log('request ${_dio.options.baseUrl}$PAYMENT');
      debugPrint(authKey);
      final response = await _dio.post(PAYMENT, data: params);
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }

  Future<List<OrderHistory>?> fetchOrderHistory(String authKey) async {
    try {
      _dio.options.headers["basic-api-token"] = _getBaseToken();
      _dio.options.headers["Authorization"] = "Bearer $authKey";
      log('request ${_dio.options.baseUrl}$ORDERHISTORY');
      final response = await _dio.post(
        ORDERHISTORY,
      );
      log('response ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showToastMsg("${response.statusMessage}");
        return null;
      } else {
        return (response.data as List)
            .map((x) => OrderHistory.fromJson(x))
            .toList();
      }
    } catch (e) {
      showToastMsg("Something went wrong");
      debugPrint("ERROR: ${e.toString()}");
      return null;
    }
  }
}
