import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/product_model.dart';

class ProductDetailsFirstSection extends StatelessWidget {
  const ProductDetailsFirstSection({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AutoSizeText(
              textAlign: TextAlign.end,
              productModel.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AutoSizeText(
                  '(${productModel.ratingCount.toString()} rewiews) ${productModel.averageRating.toString()}',
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      // '${((double.parse(productModel.regularPrice == null || productModel.regularPrice == '' ? '0.00' : productModel.regularPrice!)
                      //     - double.parse(productModel.salePrice == null || productModel.salePrice == '' ? '0.00' : productModel.salePrice!))
                      //     / double.parse(productModel.regularPrice == null || productModel.regularPrice == '' ? '0.00' : productModel.regularPrice!)
                      //     * 100).toStringAsFixed(1)}%',
                      //   productModel.regularPrice == '' || productModel.salePrice == ''  || productModel.regularPrice == '' ?
                        '${(((double.tryParse(productModel.regularPrice ?? '0.00') ?? 0.00) -
                          (double.tryParse(productModel.salePrice ?? '0.00') ?? 0.00)) /
                          ((double.tryParse(productModel.regularPrice ?? '0.00') ?? 1.00)) * 100)
                          .toStringAsFixed(1)}%'
                          // : '0%',
,

                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                AutoSizeText(
                  '${addTax(price: double.tryParse(productModel.regularPrice ?? '0.00') ?? 0.00).toStringAsFixed(1)} ر.س ',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 5),
                AutoSizeText(
                  '${addTax(price: double.tryParse(productModel.salePrice ?? '0.00') ?? 0.00).toStringAsFixed(1)} ر.س ',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
