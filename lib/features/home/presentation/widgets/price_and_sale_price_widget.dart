import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/models/product_model.dart';

import '../../../../core/constants/colors.dart';

class PriceAndSalePriceWidget extends StatelessWidget {
  const PriceAndSalePriceWidget({super.key, required this.productModel});

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          ' ${addTax(price: double.tryParse(productModel?.regularPrice??'0.00') ?? 0).toStringAsFixed(1)} ر.س',
          style: const TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.grey,
            fontSize:  14,
          ),
          maxLines: 1,
        ),
        AutoSizeText(
          '${addTax(price: double.tryParse(productModel?.salePrice ?? '0.00') ?? 0).toStringAsFixed(1)} ر.س ',
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
