import 'package:dio/dio.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';

import '../models/cart_model.dart';
import 'data/local/shared_helper.dart';
import 'data/local/shared_keys.dart';

class CartService {
  DioHelper dio = DioHelper();

  getHeaders() {
    String? token = SharedHelper.get(key: SharedKeys.token);
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<CartModel?> getCart() async {
    print('${SharedHelper.get(key: SharedKeys.token)}');
    try {
      var response = await dio.get(
        url: 'https://masalriyadh.com/wp-json/cocart/v2/cart/',
        headers: {
          'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
        },
      );

      // التأكد من أن البيانات هي من نوع Map<String, dynamic>
      if (response.statusCode == 200 && response.data != null) {
        print('Response data: ${response.data}');
        print('Response data type: ${response.data.runtimeType}'); // الفحص هنا

        // التأكد من أن البيانات هي Map<String, dynamic>
        if (response.data is Map<String, dynamic>) {
          return CartModel.fromJson(response.data as Map<String, dynamic>);
        } else {
          print('Response data is not of type Map<String, dynamic>');
          return null;
        }
      } else {
        print('Failed to fetch cart');
        return null;
      }
    } catch (e) {
      print('Response data type: ${e.runtimeType}');
      print('Error fetching cart: $e');
      rethrow;
    }
  }

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

  Future<bool> addToCart(
      {required int productId, required int quantity}) async {
    try {
      Response response = await dio.post(
        url: 'https://masalriyadh.com/wp-json/cocart/v1/add-item',
        body: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
        headers: {
          'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
        },
      );

      if (response.statusCode == 200) {
        print('Item added to cart successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFromCart({required String cartItemKey}) async {
    print('cartItemKey: $cartItemKey');
    print('${SharedHelper.get(key: SharedKeys.token)}');
    try {
      Response response = await dio.delete(
        url: 'https://masalriyadh.com/wp-json/cocart/v2/cart/item/$cartItemKey',
        headers: {
          'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
        },
      );

      if (response.statusCode == 200) {
        print('Item removed from cart successfully');
        return true;
      } else {
        // حدث خطأ في عملية الإزالة
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<bool> clearCart() async {
    try {
      Response response = await dio.post(
        url: 'https://masalriyadh.com/wp-json/cocart/v2/cart/clear',
        headers: {
          'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
        },
      );
      if (response.statusCode == 200) {
        print('Cart cleared successfully');
        return true;
      } else {
        print('Failed to clear cart: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }

  Future<bool> updateCart(
      {required String cartItemKey, required int quantity}) async {
    //TODO update cart Check PostMan
    try {
      // إرسال طلب POST إلى CoCart API لتحديث الكمية
      Response response = await dio.post(
        url: 'https://masalriyadh.com/wp-json/cocart/v2/cart/item/$cartItemKey',
        body: {
          'quantity': quantity.toString(),
        },
        headers: {
          'Authorization': 'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

}
