import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/cart_services.dart';
import 'package:masalriyadh/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/services/categories_services.dart';
import '../../../../core/services/wishlist_service.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({
    required this.categoriesServices,
    required this.cartService,
    required this.cartCubit,
  }) : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];
  final CategoriesServices categoriesServices;
  final CartCubit cartCubit;
  final CartService cartService;
  List<ProductModel> wishlistProducts = [];
  late List<bool> isLoadingList = [];

  addToCart({
    required ProductModel productModel,
  }) async {
    emit(AddToCartLoadingState());
    try {
      bool isAdded =
          await cartService.addToCart(productId: productModel.id, quantity: 1);

      if (isAdded) {
       await cartCubit.getCart();
        emit(AddToCartSuccessState());
      } else {
        emit(AddToCartErrorState(error: 'Error'));
      }
    } catch (e) {
      emit(AddToCartErrorState(error: e.toString()));
    }
  }

  getProducts({required int categoryId}) async {
    print('=============================');
    print('categoryId: $categoryId');
    print('=============================');

    isLoadingList.clear();
    emit(GetProductsLoadingState());
    await categoriesServices.getProducts(categoryId: categoryId).then(
      (value) {
        products = value;
        isLoadingList = List.generate(products.length, (index) => false);

        emit(GetProductsSuccessState());
      },
    ).catchError((error) {
      emit(GetProductsErrorState(
        error: error.toString(),
      ));
    });
  }

  void onItemTap(int index) async {
    isLoadingList[index] = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoadingList[index] = false;
    emit(ChangeLoadingState());
  }
}
