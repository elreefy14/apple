import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/services/data/local/shared_helper.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:masalriyadh/features/cart/presentation/widgets/product_cart_widget.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/shipping_and_billing_view.dart';
import 'package:masalriyadh/home_layout.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/customer_details_model.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_show_toast.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
      if (state is GetCartSuccess) {
        customShowToast(
          message: 'Get Cart Success',
          toastColor: ToastColor.success,
        );
      }
    }, builder: (context, state) {
      var cubit = CartCubit.get(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: SharedHelper.get(key: SharedKeys.token) != null
              ? [
                  state is GetCartLoading
                      ? SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        )
                      : cubit.cart != null && cubit.cart!.items.isNotEmpty
                          ? SliverList.builder(
                              itemCount: cubit.cart?.items.length ?? 0,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  ProductCartWidget(
                                    cartItem: cubit.cart!.items[index],
                                  ),
                                  const SizedBox(height: 10),
                                ]);
                              },
                            )
                          : SliverToBoxAdapter(
                              child: Center(
                                child: Image.asset(
                                  'assets/images/cart_empty.png',
                                ),
                              ),
                            ),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[200]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'مجموع السعر',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${addTax(price: (cubit.cart?.totals.subtotal ?? 0) / 10).toStringAsFixed(1)} ر.س',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  cubit.cart != null && cubit.cart!.items.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: CustomButton(
                            title: 'الدفع',
                            isLoading: state is GetCustomerDetailsLoadingState
                                ? true
                                : false,
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShippingAndBillingView(
                                        isPay: true,
                                        cart: cubit.cart,
                                      ),
                                ),
                              );
                            },
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: CustomButton(
                            title: 'تسوق الان',
                            isLoading: state is GetCustomerDetailsLoadingState
                                ? true
                                : false,
                            onTap: () async {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeLayout(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ),
                ]
              : [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Image.asset(
                        'assets/images/cart_empty.png',
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomButton(
                      title: 'تسوق الان',
                      isLoading: state is GetCustomerDetailsLoadingState
                          ? true
                          : false,
                      onTap: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayout(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
        ),
      );
    });
  }
}
