import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/profile/manager/shipping_and_billing_cubit/shipping_and_billing_cubit.dart';

import 'core/bloc_observer.dart';
import 'core/services/banners_service.dart';
import 'core/services/cart_services.dart';
import 'core/services/categories_services.dart';
import 'core/services/customer_details_service.dart';
import 'core/services/data/local/shared_helper.dart';
import 'core/services/data/remote/dio_services.dart';
import 'core/services/order_service.dart';
import 'core/services/register_services.dart';
import 'core/services/wishlist_service.dart';
import 'features/cart/manager/cart_cubit/cart_cubit.dart';
import 'features/home/manager/home_cubit/home_cubit.dart';
import 'features/profile/manager/profile_cubit/profile_cubit.dart';
import 'features/splash/presentation/splash_view.dart';
import 'features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await registerService();
  await DioHelper.dioInit();
  await SharedHelper.sharedInit();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('ar'),
      child: const MasElRiyadh(),
    ),
  );
}

class MasElRiyadh extends StatelessWidget {
  const MasElRiyadh({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.locale.toString());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShippingAndBillingCubit(
            customerDetailsService: getIt.get<CustomerDetailsService>(),
          ),
        ),
        BlocProvider(
            create: (context) => CartCubit(
                  orderService: getIt.get<OrderService>(),
                  cartServices: getIt.get<CartService>(),
                )),
        BlocProvider(
          create: (context) => HomeCubit(
            categoriesServices: getIt.get<CategoriesServices>(),
            bannersService: getIt.get<BannersService>(),
          ),
        ), 
        BlocProvider(
            create: (context) =>
                WishlistCubit(wishListService: getIt.get<WishListService>())),
        BlocProvider(
          create: (context) => ProfileCubit(
            customerDetailsService: getIt.get<CustomerDetailsService>(),
          )..getCustomerId(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale == const Locale('ar')
            ? const Locale('ar')
            : const Locale('en'),
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarContrastEnforced: true,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: SplashView(),
        ),
      ),
    );
  }
}
