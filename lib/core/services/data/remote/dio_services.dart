import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/cupertino.dart';
import 'end_points.dart';

class DioHelper {
  static Dio? dio;

  static Map<String, dynamic>? header = {
    'Authorization': 'Basic ${base64Encode(
      utf8.encode('${EndPoints.key}:${EndPoints.secret}'),
    )}',
    'Content-Type': 'application/json',
  };

  static dioInit() {
    dio = Dio(
      BaseOptions(
        // connectTimeout: Duration(seconds: 10),  // مهلة الاتصال 10 ثوانٍ
        // receiveTimeout: Duration(seconds: 15),  // مهلة استقبال البيانات 15 ثانية
      ),
    );
    dio?.interceptors.add(LogInterceptor(
      responseBody: false,
      error: true,
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      request: true,
    )

    );
    dio?.interceptors.add(
      RetryInterceptor(
        logPrint: (message) => print('Retry Log: $message'), // طباعة المحاولات
        toNoInternetPageNavigator: () {
          // التوجيه إلى صفحة خطأ عند فقد الاتصال بالإنترنت
          print("No internet connection! Navigating to error page...");
          // يمكنك استخدام `Navigator.push` هنا لو عندك `BuildContext`
          return Future.value(); // ✅ الحل: إرجاع Future<void> لمنع الخطأ
        },
        dio: dio!,
        retries: 3,  // عدد المحاولات قبل الفشل النهائي
        retryDelays: [
          const Duration(seconds: 1),  // أول محاولة بعد 1 ثانية
          const Duration(seconds: 3),  // ثاني محاولة بعد 3 ثوانٍ
          const Duration(seconds: 5),  // ثالث محاولة بعد 5 ثوانٍ
        ],
      ),
    );
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      dio?.options.headers = headers ?? header;

      return await dio!.get(
        url,
        queryParameters: queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    FormData? formData,
  }) async {
    try {
      dio?.options.headers = headers ?? header;
      return await dio!.post(

        url,
        queryParameters: queryParameters,
        data: formData ?? body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    FormData? formData,
  }) async {
    try {
      dio?.options.headers = headers ?? header;
      return await dio!.put(
        url,
        queryParameters: queryParameters,
        data: formData ?? body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch({
    String? baseUrl = EndPoints.apiEndPoint,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      dio?.options.headers = headers ?? header;

      return await dio!.patch(
        EndPoints.webUrl + EndPoints.apiEndPoint + endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    FormData? formData,
  }) async {
    try {
      dio?.options.headers = headers ?? header;
      return await dio!.delete(
        url,
        queryParameters: queryParameters,
        data: formData ?? body,
      );
    } catch (e) {
      rethrow;
    }
  }
}
