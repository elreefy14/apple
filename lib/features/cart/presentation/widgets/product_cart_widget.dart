import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/models/cart_model.dart';
import 'package:masalriyadh/core/widgets/cached_network_image_widget.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';

import '../../../../core/widgets/custom_show_toast.dart';

class ProductCartWidget extends StatelessWidget {
  const ProductCartWidget({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is UpdateCartError) {
          customShowToast(
            message: 'Update Cart Error',
            toastColor: ToastColor.error,
          );
        }

        if (state is RemoveFromCartError) {
          customShowToast(
            message: 'Remove Cart Error',
            toastColor: ToastColor.error,
          );
        }
        if (state is UpdateCartSuccess) {
          customShowToast(
            message: 'Update Cart Success',
            toastColor: ToastColor.success,
          );
        }
        if (state is RemoveFromCartSuccess) {
          customShowToast(
            message: 'Remove Cart Success',
            toastColor: ToastColor.success,
          );
        }
      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImageWidget(
                      image: cartItem.featuredImage,
                      fit:  BoxFit.fill,
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        textAlign: TextAlign.start,
                        cartItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          AutoSizeText(
                            (addTax(price: cartItem.salesPrice / 100))
                                .toStringAsFixed(1),
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          AutoSizeText(
                            (addTax(price: cartItem.price / 100))
                                .toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (cartItem.quantity == 1) {
                                    } else {
                                      cubit.updateCart(
                                          cartItemKey: cartItem.itemKey,
                                          quantity: cartItem.quantity - 1);
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                  ),
                                ),
                                AutoSizeText(
                                  cartItem.quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.updateCart(
                                        cartItemKey: cartItem.itemKey,
                                        quantity: cartItem.quantity + 1);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.removeFromCart(
                                  cartItemKey: cartItem.itemKey);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
