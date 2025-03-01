import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/helper_functions/clean_tags.dart';
import '../../../../core/models/product_model.dart';

class ProductDetailsSecondSection extends StatelessWidget {
  const ProductDetailsSecondSection({super.key, required this.productModel});

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
          const AutoSizeText(
            'الوصف',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AutoSizeText(
             textAlign: TextAlign.end,
            cleanHtmlTags(
              productModel.shortDescription,
            ) ,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
