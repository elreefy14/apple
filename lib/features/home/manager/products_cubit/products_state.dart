part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
final class GetProductsLoadingState extends ProductsState {}

final class GetProductsSuccessState extends ProductsState {}

final class GetProductsErrorState extends ProductsState {
  final String error;

  GetProductsErrorState({required this.error});
}
final class WishlistLoadingState extends ProductsState {}
final class WishlistSuccessState extends ProductsState {}
final class WishlistErrorState extends ProductsState {
  final String error;

  WishlistErrorState({required this.error});
}
final class AddToCartLoadingState extends ProductsState {}
final class AddToCartSuccessState extends ProductsState {}
final class AddToCartErrorState extends ProductsState {
  final String error;

  AddToCartErrorState({required this.error});
}

final class ChangeLoadingState extends ProductsState {}