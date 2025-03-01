import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/order_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/order_service.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/data/remote/end_points.dart';
import '../../../../core/services/register_services.dart';

part 'order_success_state.dart';

class OrderSuccessCubit extends Cubit<OrderSuccessState> {
  OrderSuccessCubit({required this.orderService})
      : super(OrderSuccessInitial());

  static OrderSuccessCubit get(context) => BlocProvider.of(context);
  final OrderService orderService;
  OrderModel? order;
  bool? paidSuccess;

  Future<OrderModel?> getOrderWithUpdate(
      {required int orderId, required bool isPaid, required String paymentMethod}) async {
    DioHelper dio = getIt.get<DioHelper>();
    emit(GetOrderByIdLoadingState());
    try {
      final response = await dio.get(
          url: "https://masalriyadh.com/wp-json/wc/v3/orders/$orderId",
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('${EndPoints.key}:${EndPoints.secret}'),
            )}',
            'Content-Type': 'application/json',
          });

      print("📝 Response Code: ${response.statusCode}");
      print("📝 Response Body: ${response.data}");

      if (response.statusCode == 200) {
        print("✅ Order fetched successfully: ${response.data}");
        await updateOrderStatus( 
          orderId: orderId,
          status: isPaid ? "processing" : "failed",
          paymentMethod:paymentMethod ?? "",
        ).then(
          (value) {
            order = value;
            paidSuccess = value?.status == 'processing' ? true : false;
            emit(GetOrderByIdSuccessState());

          },

        );
      } else {
        print("❌ فشل في جلب تفاصيل الطلب: ${response.data}");
      }

      return null;
    } catch (e) {
      emit(GetOrderByIdErrorState(error: e.toString()));
      print("❌ خطأ أثناء جلب تفاصيل الطلب: $e");
      rethrow;
    }
  }

  Future<OrderModel?> updateOrderStatus({
    required int orderId,
    required String status,
    required String paymentMethod,
  }) async {
    print("🔄 ببدأ تحديث الطلب ID: $orderId...");
    DioHelper dio = getIt.get<DioHelper>();
    try {
      final response = await dio.put(
        url: "https://masalriyadh.com/wp-json/wc/v3/orders/$orderId",
        body: {
          "payment_method": paymentMethod,
          "payment_method_title": paymentMethod,
          "status": status,
        },
      );

      print("📤 Data Sent: {payment_method: $paymentMethod, status: $status}");
      print("📝 Response Code: ${response.statusCode}");
      print("📝 Response Body: ${response.data}");

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
        print("✅ الطلب تم تحديثه بنجاح");
      } else {
        print("❌ فشل تحديث الطلب: ${response.data}");
      }
    } catch (e) {
      print("❌ خطأ أثناء تحديث الطلب: $e");
      return null;
    }
    return null;
  }
}
