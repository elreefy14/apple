part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class GetWishlist extends WishlistState {}
final class GetWishlistLoading extends WishlistState {}
final class GetWishlistError extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistSuccessState extends WishlistState {}

final class WishlistErrorState extends WishlistState {
  final String error;

  WishlistErrorState({required this.error});
}

final class ToggleWishlistLoadingState extends WishlistState {}

final class ToggleWishlistSuccessState extends WishlistState {}

final class ToggleWishlistErrorState extends WishlistState {
  final String error;

  ToggleWishlistErrorState({required this.error});
}
