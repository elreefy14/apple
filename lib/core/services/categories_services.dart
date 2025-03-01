import 'package:flutter/foundation.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/register_services.dart';

import '../models/all_catigories_model.dart';
import 'data/remote/end_points.dart';

class CategoriesServices {
  DioHelper dio = getIt.get<DioHelper>();
  List<CategoryModel> mainCategories = [];
  List<ProductModel> products = [];
  List<ProductModel> epoxyProducts = [];
  List<ProductModel> azlHamamProducts = [];
  List<ProductModel> newProducts = [];

  Future<List<ProductModel>> fetchLatestProducts() async {
    newProducts = [];
    try {
      var response = await dio.get(
        url: "https://masalriyadh.com/wp-json/wc/v3/products",
        queryParameters: {"orderby": "date", "order": "desc", "per_page": 10},
      );

      if (response.statusCode == 200) {
        for (var product in response.data) {
          newProducts.add(ProductModel.fromJson(product));
        }
        return newProducts;
      } else {
        print("Error: ${response.statusCode}");
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
  }

  Future<List<CategoryModel>> getMainCategories() async {
    mainCategories = [];
    try {
      // استدعاء API
      var response = await dio.get(
          url: EndPoints.webUrl + EndPoints.apiEndPoint + EndPoints.categories,
          queryParameters: {'per_page': '100', 'page': '1'});

      // التحقق من أن البيانات المستلمة هي قائمة
      if (response.data is List) {
        for (var category in response.data) {
          if (category['parent'] != 0) {
            continue;
          }
          mainCategories.add(CategoryModel.fromJson(category));
        }

        return mainCategories;
      } else {
        throw Exception('Unexpected data format: Expected a list');
      }
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    List<ProductModel> featuredProducts = [];
    try {
      var response = await dio.get(
        url: '${EndPoints.webUrl}${EndPoints.apiEndPoint}${EndPoints.products}',
        queryParameters: {'featured': 'true'},
      );

      var allData = response.data;
      for (var item in allData) {
        featuredProducts.add(ProductModel.fromJson(item));
      }

      return featuredProducts;
    } catch (e, stackTrace) {
      print('Error fetching featured products: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts({required int categoryId}) async {
    products.clear();
    try {
      // استدعاء API
      var response = await dio.get(
          url:
              '${EndPoints.webUrl}${EndPoints.apiEndPoint}${EndPoints.products}?category=$categoryId',
          queryParameters: {'per_page': '100', 'page': '1'});

      // التحقق من أن البيانات المستلمة هي قائمة
      if (response.data is List) {
        for (var product in response.data) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Unexpected data format: Expected a list');
      }
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching Products: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }
  Future<List<ProductModel>> getEpoxyProducts() async {
    epoxyProducts.clear();
    try {
      // استدعاء API
      var response = await dio.get(
          url:
          '${EndPoints.webUrl}${EndPoints.apiEndPoint}${EndPoints.products}?category=72',
          queryParameters: {'per_page': '100', 'page': '1'});

      // التحقق من أن البيانات المستلمة هي قائمة
      if (response.data is List) {
        for (var product in response.data) {
          epoxyProducts.add(ProductModel.fromJson(product));
        }
        return epoxyProducts;
      } else {
        throw Exception('Unexpected data format: Expected a list');
      }
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching Products: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }
  Future<List<ProductModel>> getAzlHamamProducts() async {
    azlHamamProducts.clear();
    try {
      // استدعاء API
      var response = await dio.get(
          url:
          '${EndPoints.webUrl}${EndPoints.apiEndPoint}${EndPoints.products}?category=74',
          queryParameters: {'per_page': '100', 'page': '1'});

      // التحقق من أن البيانات المستلمة هي قائمة
      if (response.data is List) {
        for (var product in response.data) {
          azlHamamProducts.add(ProductModel.fromJson(product));
        }
        return azlHamamProducts;
      } else {
        throw Exception('Unexpected data format: Expected a list');
      }
    } catch (e, stackTrace) {
      // طباعة تفاصيل الخطأ أثناء التطوير
      print('Error fetching Products: $e');
      print('Stack trace: $stackTrace');
      // إعادة رمي الخطأ
      rethrow;
    }
  }
}
