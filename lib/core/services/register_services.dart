import 'package:get_it/get_it.dart';
import 'package:masalriyadh/core/services/data/auth_service.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/services/wishlist_service.dart';

import 'banners_service.dart';
import 'cart_services.dart';
import 'categories_services.dart';
import 'customer_details_service.dart';
import 'data/local/shared_helper.dart';
import 'order_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> registerService() async {
  getIt.registerSingleton<DioHelper>(DioHelper());
  getIt.registerSingleton<CategoriesServices>(CategoriesServices());
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<SharedHelper>(SharedHelper());
  getIt.registerSingleton<BannersService>(BannersService());
  getIt.registerSingleton<CartService>(CartService());
  getIt.registerSingleton<WishListService>(WishListService());
  getIt.registerSingleton<CustomerDetailsService>(CustomerDetailsService());
  getIt.registerSingleton<OrderService>(OrderService());
}
