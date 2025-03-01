import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:masalriyadh/core/models/country_model.dart';
import 'package:masalriyadh/core/models/customer_details_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/register_services.dart';

import 'data/local/shared_helper.dart';
import 'data/local/shared_keys.dart';

class CustomerDetailsService {
  DioHelper dio = getIt.get<DioHelper>();
  CustomerDetailsModel? customerDetailsModel;

  String? extractUserId() {
    final jwtToken = SharedHelper.get(key: SharedKeys.token);

    try {
      if (jwtToken == null || jwtToken.isEmpty) {
        print(jwtToken.toString());
        print('JWT Token is null or empty');
        return null;
      }
      print(jwtToken);
      final parts = jwtToken.split('.');
      if (parts.length != 3) {
        print('Invalid JWT token structure');
        return null;
      }

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final Map<String, dynamic> payloadMap = json.decode(payload);

      final userId = payloadMap['data']?['user']?['id'];
      SharedHelper.set(key: SharedKeys.customerId, value: userId?.toString());
      return userId?.toString();
    } catch (e) {
      print('Error decoding JWT: $e');
      rethrow;
    }
  }

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    try {
      String? customerId = extractUserId();
      SharedHelper.set(key: SharedKeys.customerId, value: customerId);
      if (customerId != null) {
        var response = await dio.get(
          url: 'https://masalriyadh.com//wp-json/wc/v3/customers/$customerId',
        );
        if (response.statusCode == 200) {
          customerDetailsModel = CustomerDetailsModel.fromJson(response.data);
          return customerDetailsModel;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Country? cities;

  Future<Country?> getCities() async {
    try {
      Response response = await dio.get(
        url: 'https://masalriyadh.com/wp-json/wc/v3/data/countries/sa',
      );
      if (response.statusCode == 200) {
        cities = Country.fromJson(response.data);

        return cities;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getShippingZones() async {
    Response response = await dio.get(
      url: "https://masalriyadh.com/wp-json/wc/v3/shipping/zones",
    );

    if (response.statusCode == 200) {
      print("Shipping Zones: ${response.data}");
      return response.data;
    } else {
      print("فشل في جلب الـ Shipping Zones");
    }
    return null;
  }

  // Future<void> getShippingMethods({required String zoneId}) async {
  //   final response = await dio.get(
  //     url:
  //         "https://masalriyadh.com/wp-json/wc/v3/shipping/zones/$zoneId/methods",
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print("طرق الشحن المتاحة: ${response.data}");
  //     return response.data;
  //   } else {
  //     print("فشل في جلب طرق الشحن");
  //   }
  // }
}
