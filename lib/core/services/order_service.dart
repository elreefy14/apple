import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:masalriyadh/core/models/order_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';

import 'data/local/shared_helper.dart';
import 'data/local/shared_keys.dart';
import 'data/remote/end_points.dart';

class OrderService {
  DioHelper dio = DioHelper();
  List<OrderModel> orders = [];

  Future<OrderModel?> createOrder({required OrderModel orderModel}) async {
    try {
      Response response = await dio.post(
        url: 'https://masalriyadh.com/wp-json/wc/v3/orders?customer=114',
        body: orderModel.toJson(),
      );

      if (response.statusCode == 201) {
        print('Order created successfully');
        final createdOrder = OrderModel.fromJson(response.data);
        return createdOrder;
      } else {
        print(
          'Failed to create order. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<OrderModel>?> getCustomerOrders(
      {required String customerId}) async {
    orders = [];
    try {
      final response = await dio.get(
        url:
            'https://masalriyadh.com/wp-json/wc/v3/orders?customer=$customerId',
      );
      if (response.statusCode == 200) {
        for (var order in response.data) {
          orders.add(OrderModel.fromJson(order));
        }
        return orders;
      } else {
        print(
          'Failed to create order. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error creating order: $e');
      rethrow;
    }
    return null;
  }

  Future<bool> updateOrderStatus({
    required int orderId,
    required String status,
    required String paymentMethod,
    required bool isPaid,
  }) async {
    final response = await dio.put(
      url: "https://masalriyadh.com/wp-json/wc/v3/orders/$orderId",
      body: {
        "payment_method": paymentMethod,
        "status": status,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("فشل في تحديث الطلب: ${response.data}");
      return false;
    }
  }


  Future<OrderModel?> getOrderById(int orderId) async {

    try {
      final response = await dio.get(
        url: "https://masalriyadh.com/wp-json/wc/v3/orders/$orderId",
        headers: {
          'Authorization': 'Basic ${base64Encode(
            utf8.encode('${EndPoints.key}:${EndPoints.secret}'),
          )}',
          'Content-Type': 'application/json',
        }
      );

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
        print("فشل في جلب تفاصيل الطلب: ${response.data}");
      }
      return null;
    } catch (e) {
      print("فشل في جلب تفاصيل الطلب: $e");
      rethrow;
    }
    }
}
