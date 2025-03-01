import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/cart_model.dart';
import 'package:meta/meta.dart';
import '../../../../core/services/cart_services.dart';
import '../../../../core/services/order_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.cartServices,
    required this.orderService,
  }) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  final CartService cartServices;
  final OrderService orderService;
  CartModel? cart;

  Future<void> getCart() async {
    emit(GetCartLoading());
    var cartModel = await cartServices.getCart().then(
      (value) {
        cart = value;

        emit(GetCartSuccess());
      },
    ).catchError(
      (error) {
        emit(GetCartError(error: error.toString()));
      },
    );
  }

  Future<void> updateCart(
      {required String cartItemKey, required int quantity}) async {
    emit(UpdateCartLoading());
    var cartModel = await cartServices
        .updateCart(cartItemKey: cartItemKey, quantity: quantity)
        .then(
      (value) {
        getCart();
        emit(UpdateCartSuccess());
      },
    ).catchError(
      (error) {
        print(error);
        emit(UpdateCartError(error: error.toString()));
      },
    );
  }



  Future<void> removeFromCart({required String cartItemKey}) async {
    emit(RemoveFromCartLoading());
    var cartModel = await cartServices
        .removeFromCart(cartItemKey: cartItemKey)
        .then((value) async {
      await getCart();
      emit(RemoveFromCartSuccess());
    }).catchError(
      (error) {
        emit(RemoveFromCartError(error: error.toString()));
      },
    );
  }
}
