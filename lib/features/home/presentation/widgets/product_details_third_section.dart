import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';

import '../../manager/product_details_cubit/product_details_cubit.dart';

class ProductDetailsThirdSection extends StatelessWidget {
  const ProductDetailsThirdSection(
      {super.key, required this.productModel, this.onTap});

  final ProductModel productModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              title: 'اضف الى السلة',
              onTap: onTap,
              isLoading: state is AddToCartLoading ? true : false,
            ),
          ),
        );
      },
    );
  }
}
