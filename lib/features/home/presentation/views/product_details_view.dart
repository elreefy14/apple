import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:masalriyadh/features/home/manager/products_cubit/products_cubit.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_details_view_body.dart';

import '../../../../core/services/cart_services.dart';
import '../../../../core/services/categories_services.dart';
import '../../../../core/services/register_services.dart';
import '../../../../core/services/wishlist_service.dart';
import '../../../wishlist/manager/wishlist_cubit/wishlist_cubit.dart';
import '../../manager/product_details_cubit/product_details_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.productModel,
    required this.heroTag,
  });

  final ProductModel productModel;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        cartCubit: context.read<CartCubit>(),
        wishlistCubit: context.read<WishlistCubit>(),
        cartService: getIt.get<CartService>(),
        wishListService: getIt.get<WishListService>(),
      )
        ..getWishlistProducts()
        ..isInWishlist(productModel: productModel),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: ProductDetailsViewBody(
          heroTag: heroTag,
          productModel: productModel,
        ),
      ),
    );
  }
}
