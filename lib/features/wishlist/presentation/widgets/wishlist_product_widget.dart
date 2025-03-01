import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';
import 'package:masalriyadh/features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../../home/presentation/widgets/add_stock_button.dart';
import '../../../home/presentation/widgets/price_and_sale_price_widget.dart';

class WishlistProductWidget extends StatelessWidget {
  const WishlistProductWidget(
      {super.key, required this.productModel, this.onTap, this.index});

  final ProductModel? productModel;
  final void Function()? onTap;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = WishlistCubit.get(context);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                    ),
                    child: Hero(
                      tag: '${index}WishlistViewBody',
                      child: CachedNetworkImageWidget(
                        image:productModel?.images?.isEmpty ==
                            true ||
                            productModel?.images?[0]?.src == null
                            ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                            : productModel?.images?[0]?.src ??
                            'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              textAlign: TextAlign.end,
                              productModel?.name ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  height: 1.1),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AddStockButton(
                                icon: cubit.isInWishlist(
                                        productModel: productModel!)
                                    ? Icons.favorite
                                    : Icons.safety_check,
                                iconColor: Colors.red,
                                onTap: () {
                                  cubit.toggleWishlist(
                                      productModel: productModel!);
                                },
                                isLoading: state is WishlistLoadingState
                                    ? true
                                    : false,
                              ),
                              PriceAndSalePriceWidget(
                                productModel: productModel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
