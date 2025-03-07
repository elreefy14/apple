import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/services/wishlist_service.dart';
import 'package:meta/meta.dart';
import '../../../../core/models/wishlist_product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({required this.wishListService}) : super(WishlistInitial());

  static WishlistCubit get(context) => BlocProvider.of(context);
  final WishListService wishListService;
  List<ProductModel> wishlistProducts = [];
  List<WishlistProductModel> wishList = [];

  bool isInWishlist({required ProductModel productModel}) {
    return wishList.any((element) => element.productId == productModel.id) ;
  }

  Future<void> getWishListProducts() async {
    emit(GetWishlistLoading());
    try {
      wishList = await wishListService.getWishList();
      wishlistProducts = await wishListService.getWishlistProducts();

      emit(GetWishlist());
    } catch (e) {
      print(e.toString());
      emit(GetWishlistError());
    }
  }

  toggleWishlist({required ProductModel productModel}) async {
    emit(ToggleWishlistLoadingState());
    try {
      bool isProductInWishlist = isInWishlist(productModel: productModel);

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
      emit(ToggleWishlistSuccessState());
      getWishListProducts();
    } catch (e) {
      emit(ToggleWishlistErrorState(error: e.toString()));
    }
  }
}
