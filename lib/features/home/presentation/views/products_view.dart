import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/all_catigories_model.dart';
import 'package:masalriyadh/core/services/categories_services.dart';
import 'package:masalriyadh/core/services/register_services.dart';
import 'package:masalriyadh/features/home/presentation/widgets/products_view_body.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/services/cart_services.dart';
import '../../../../core/services/wishlist_service.dart';
import '../../../cart/manager/cart_cubit/cart_cubit.dart';
import '../../manager/products_cubit/products_cubit.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          categoryModel.name,
          style: AppTextStyles.black16Bold,
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductsCubit(
          cartCubit:  context.read<CartCubit>(),
          cartService:  getIt.get<CartService>(),
          categoriesServices: getIt.get<CategoriesServices>(),
        )
          ..getProducts(categoryId: categoryModel.id.toInt()),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ProductsViewBody(),
        ),
      ),
    );
  }
}
