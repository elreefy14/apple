import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/wishlist_service.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:masalriyadh/features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/models/wishlist_product_model.dart';
import '../../../../core/services/cart_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({
    required this.cartService,
    required this.wishListService,
    required this.cartCubit,
    required this.wishlistCubit,
  }) : super(AddToCartInitial());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  final CartService cartService;
  final WishListService wishListService;
  final CartCubit cartCubit;
  final WishlistCubit wishlistCubit;
  List<WishlistProductModel> wishList = [];
  bool isProductInWishlist = false;

  addToCart({
    required ProductModel productModel,
  }) async {
    emit(AddToCartLoading());
    try {
      bool isAdded =
          await cartService.addToCart(productId: productModel.id, quantity: 1);

      if (isAdded) {
        cartCubit.getCart();
        emit(AddToCartSuccess());
      } else {
        emit(AddToCartError(error: 'Error'));
      }
    } catch (e) {
      emit(AddToCartError(error: e.toString()));
    }
  }

  getWishlistProducts() {
    wishList = wishlistCubit.wishList;
  }

  bool isInWishlist({required ProductModel productModel}) {
    isProductInWishlist =
        wishList.any((element) => element.productId == productModel.id);
    // emit(IsInWishlist());
    return isProductInWishlist;
  }

  toggleWishlist({required ProductModel productModel}) async {
    emit(ToggleWishlistLoading());
    try {
      isProductInWishlist = isInWishlist(productModel: productModel);

      await wishListService.toggleWishlist(
        productId: productModel.id,
        isInWishlist: isProductInWishlist,
        itemId: isProductInWishlist
            ? wishList
                .where((element) => element.productId == productModel.id)
                .first
                .itemId
            : null,
      );
      await wishlistCubit.getWishListProducts();
      getWishlistProducts();
      isInWishlist(productModel: productModel);
      emit(ToggleWishlistSuccess());
    } catch (e) {
      emit(ToggleWishlistError(error: e.toString()));
    }
  }
}
