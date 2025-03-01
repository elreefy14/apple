import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/models/all_catigories_model.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/features/home/presentation/widgets/price_and_sale_price_widget.dart';

import 'add_stock_button.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({
    super.key,
    required this.productModel,
    this.onTap,
    this.onAddToStockTap,
    required this.index,
    required this.isLoading,
  });

  final ProductModel? productModel;
  final void Function()? onTap;
  final void Function()? onAddToStockTap;
  final int index;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  // image: DecorationImage(
                  //   fit: BoxFit.fill,
                  //   alignment: Alignment.center,
                  //   image: NetworkImage(productModel?.images?.isEmpty ==
                  //               true ||
                  //           productModel?.images?[0]?.src == null
                  //       ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                  //       : productModel?.images?[0]?.src ??
                  //           'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'),
                  // )
                ),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: productModel?.images?.isEmpty == true ||
                          productModel?.images?[0]?.src == null
                      ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                      : productModel?.images?[0]?.src ??
                          'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png',
                  imageBuilder: (context, imageProvider) => Hero(
                    transitionOnUserGestures:  true,
                    tag:  '${index}ProductsViewBody',
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(
                    color:  AppColors.primaryColor,
                    backgroundColor:  Colors.grey[300],
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Column(
                children: [
                  Center(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddStockButton(
                        isLoading: isLoading,
                        onTap: onAddToStockTap,
                      ),
                      PriceAndSalePriceWidget(
                        productModel: productModel!,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
