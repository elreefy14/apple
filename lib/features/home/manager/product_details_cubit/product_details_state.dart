part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class AddToCartInitial extends ProductDetailsState {}

final class AddToCartLoading extends ProductDetailsState {}

final class AddToCartSuccess extends ProductDetailsState {}

final class AddToCartError extends ProductDetailsState {
  final String error;

  AddToCartError({required this.error});
}

final class GetWishlistProducts extends ProductDetailsState {}

final class ToggleWishlistLoading extends ProductDetailsState {}

final class ToggleWishlistSuccess extends ProductDetailsState {}

final class ToggleWishlistError extends ProductDetailsState {
  final String error;

  ToggleWishlistError({required this.error});
}
final class IsInWishlist extends ProductDetailsState {}
