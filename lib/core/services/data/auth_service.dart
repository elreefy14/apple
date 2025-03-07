import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:masalriyadh/core/models/login_response_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/data/remote/end_points.dart';

import '../../models/customer_model.dart';
import '../register_services.dart';
import 'local/shared_helper.dart';
import 'local/shared_keys.dart';

class AuthService {
  DioHelper dio = getIt.get<DioHelper>();

  Future<bool> signUp(CustomerModel customer) async {
    try {
      Response response = await dio.post(
        url: EndPoints.webUrl + EndPoints.apiEndPoint + EndPoints.customers,
        body: customer.toJson(),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  LoginResponseModel? loginResponseModel;

  // Future<Response?> login({required String email, required String password}) async {
  //   try {
  //     Response response = await dio.post(
  //         url: 'https://masalriyadh.com/wp-json/jwt-auth/v1/token',
  //         body: {
  //           'username': email,
  //           'password': password,
  //         },
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         }
  //         );
  //     if (response.statusCode == 200) {
  //       loginResponseModel = LoginResponseModel.fromJson(response.data);
  //       await SharedHelper.set(
  //         key: SharedKeys.token,
  //         value: loginResponseModel?.token,
  //       );
  //       print(SharedHelper.get(key: SharedKeys.token));
  //       await SharedHelper.set(
  //         key: SharedKeys.userEmail,
  //         value: loginResponseModel?.userEmail,
  //       );
  //       await SharedHelper.set(
  //         key: SharedKeys.userName,
  //         value: loginResponseModel?.userDisplayName,
  //       );
  //     }
  //     return response;
  //   } catch (e) {
  //     rethrow ;
  //   }
  // }

  Future<bool> validateToken(String token) async {
    final response = await dio.post(
      url: 'https://masalriyadh.com/wp-json/jwt-auth/v1/token/validate/',
      headers: {
        'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
      },
    );

    if (response.statusCode == 200) {
      return true; // الـtoken صالح
    } else {
      return false; // الـtoken غير صالح أو انتهت صلاحيته
    }
  }
}
