import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/helper_functions/add_tax.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../../../core/widgets/custom_carousel_widget.dart';
import '../../manager/home_cubit/home_cubit.dart';
import '../views/product_details_view.dart';

class HomeViewProductsSliver extends StatelessWidget {
  const HomeViewProductsSliver({super.key, required this.products, required this.specialIndex});

  final List<ProductModel?> products;
  final String specialIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomCarouselWidget(
          showIndicator: false,
          duration:  Duration(seconds: 3 ,milliseconds: 600),
          height: 350,
          items: products
              .map(
                (product) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsView(
                            productModel: product!,
                            heroTag:  '${products.indexOf(product)}HomeViewProductsSliver$specialIndex',
                          );
                        },
                      ));
                    },
                    child: Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Hero(
                            tag: '${products.indexOf(product)}HomeViewProductsSliver$specialIndex',
                            child: SizedBox(
                                height: 250,
                                child: CachedNetworkImageWidget(
                                  image: product?.images?.isEmpty == true ||
                                          product?.images?[0]?.src == null
                                      ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                                      : product?.images?[0]?.src ??
                                          'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png',
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        addTax(
                                          price: double.tryParse(
                                                  product?.regularPrice ??
                                                      '0.00') ??
                                              0,
                                        ).toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${addTax(price: double.tryParse(product?.salePrice ?? '0.00') ?? 0).toStringAsFixed(1)} ر.س',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AutoSizeText(
                                    textAlign: TextAlign.center,
                                    product?.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
