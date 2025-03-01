import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/auth/presentation/view/sign_up_view.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:masalriyadh/features/home/manager/home_cubit/home_cubit.dart';
import 'package:masalriyadh/features/home/presentation/views/home_view.dart';
import 'package:masalriyadh/features/profile/manager/profile_cubit/profile_cubit.dart';
import 'package:masalriyadh/features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';
import 'package:masalriyadh/main.dart';
import 'package:upgrader/upgrader.dart';

import 'core/constants/app_styles.dart';
import 'core/constants/colors.dart';
import 'core/services/data/local/shared_helper.dart';
import 'core/services/data/local/shared_keys.dart';
import 'core/widgets/custom_icon_button_widget.dart';
import 'features/cart/presentation/views/cart_view.dart';
import 'features/profile/presentation/view/profile_view.dart';
import 'features/wishlist/presentation/views/wishlist_view.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, this.index});

  final int? index;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [
    const HomeView(),
    const CartView(),
    const WishlistView(),
    const ProfileView(),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setLocale(const Locale('ar')); // أو أي لغة تانية
    });
    extractUserId();
    getData(context);
    currentIndex = widget.index ?? 0;
    super.initState();
  }

  Future<void> getData(BuildContext context) async {
    Future.wait([
      HomeCubit.get(context).getBanners(),
      HomeCubit.get(context).getMainCategories(),
      HomeCubit.get(context).getFeaturedProducts(),
      HomeCubit.get(context).getNewProducts(),
      HomeCubit.get(context).getEpoxyProducts(),
      HomeCubit.get(context).getAzlHamamProducts(),
      CartCubit.get(context).getCart(),
      WishlistCubit.get(context).getWishListProducts(),
    ]);
  }

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

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showIgnore: false,
      showLater: false,
      shouldPopScope: () => false,
      barrierDismissible: false,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      upgrader:Upgrader(
        debugDisplayAlways: false,
        // debugLogging: false,
      ),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  currentIndex = 0;
                  setState(() {});
                },
                child: Image.asset(
                  'assets/images/app_logo.png',
                  height: 65,
                ),
              ),
              actions: [
                currentIndex == 2
                    ? const SizedBox.shrink()
                    : CustomIconButtonWidget(
                        iconData: Icons.favorite_border,
                        iconColor: AppColors.primaryColor,
                        onPressed: () {
                          currentIndex = 2;
                          setState(() {});
                        }),
                currentIndex == 1
                    ? const SizedBox.shrink()
                    : Stack(
                        children: [
                          CustomIconButtonWidget(
                              iconData: Icons.shopping_cart_outlined,
                              iconColor: AppColors.primaryColor,
                              onPressed: () {
                                currentIndex = 1;
                                setState(() {});
                              }),
                          cubit.cart?.items.isNotEmpty ?? false
                              ? Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Text(
                                          SharedHelper.get(
                                                      key: SharedKeys.token) !=
                                                  null
                                              ? cubit.cart?.items.length
                                                      .toString() ??
                                                  '0'
                                              : '0',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )))
                              : const SizedBox.shrink(),
                        ],
                      ),
              ],
            ),
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    currentIndex == 0 ? Icons.home : Icons.home_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    currentIndex == 1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    currentIndex == 3 ? Icons.person : Icons.person_3_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
