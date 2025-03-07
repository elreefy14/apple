import 'dart:convert';

import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/models/wishlist_product_model.dart';
import 'package:masalriyadh/core/services/data/local/shared_helper.dart';
import 'package:masalriyadh/core/services/data/local/shared_keys.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/register_services.dart';

import 'data/remote/end_points.dart';

class WishListService {
  DioHelper dio = getIt.get<DioHelper>();
  String? sharedKey;

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
      print('User ID: $userId');
      return userId?.toString();
    } catch (e) {
      print('Error decoding JWT: $e');
      rethrow;
    }
  }

  Future<String?> getWishlistShardKey() async {
    final userId = extractUserId();
    if (userId != null) {
      try {
        final response = await dio.get(
          url:
              'https://masalriyadh.com/wp-json/wc/v3/wishlist/get_by_user/$userId',
        );
        if (response.statusCode == 200) {
          sharedKey = response.data[0]['share_key'];
          print(' shared key : $sharedKey');
          print(' shared key : $sharedKey');
          print(' shared key : $sharedKey');
          return sharedKey;
        }
      } catch (e) {
        print(' shared key e : $e');
        rethrow;
      }
    }
    return null;
  }

  Future<List<WishlistProductModel>> getWishList() async {
    List<WishlistProductModel> wishlistProducts = [];
    try {
      final sharedKey = await getWishlistShardKey();
      final response = await dio.get(
        url:
            'https://masalriyadh.com/wp-json/wc/v3/wishlist/$sharedKey/get_products',
      );
      if (response.statusCode == 200) {
        for (var product in response.data) {
          wishlistProducts.add(WishlistProductModel.fromJson(product));
        }
      } else {
        throw Exception('Unexpected data format: Expected a list');
      }
      return wishlistProducts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getWishlistProducts() async {
    List<WishlistProductModel> wishlist = await getWishList();
    List<ProductModel> products = [];
    try {
      for (var wishlistProduct in wishlist) {
        await dio
            .get(
          url:
              'https://masalriyadh.com/wp-json/wc/v3/products/${wishlistProduct.productId}',
        )
            .then(
          (response) {
            products.add(ProductModel.fromJson(response.data));
          },
        ).catchError((error) {
          print(error);
        });
      }
      return products;
    } catch (e, stackTrace) {
      rethrow;
    }
  }

  Future<bool> toggleWishlist({
    required int productId,
    int? itemId,
    required bool isInWishlist, // هل المنتج موجود بالفعل في Wishlist؟
  }) async {
    try {
      final sharedKey = await getWishlistShardKey();

      final String url = isInWishlist
          ? 'https://masalriyadh.com/wp-json/wc/v3/wishlist/remove_product/$itemId'
          : 'https://masalriyadh.com/wp-json/wc/v3/wishlist/$sharedKey/add_product';

      final response = isInWishlist
          ? await dio.get(
              url: url,
              headers: {
                'Authorization':
                    'Bearer ${SharedHelper.get(key: SharedKeys.token)}',
              },
            )
          : await dio.post(
              url: url,
              body: {
                'product_id': productId,
              },
              headers: {
                'Authorization': 'Basic ${base64Encode(
                  utf8.encode('${EndPoints.key}:${EndPoints.secret}'),
                )}'
              },
            );

      if (response.statusCode == 200) {
        return true; // العملية تمت بنجاح
      } else {
        return false; // حدث خطأ
      }
    } catch (e) {
      rethrow; // إعادة الخطأ لمعالجته لاحقاً
    }
  }
}
