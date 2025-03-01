part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoading extends CartState {}

final class GetCartSuccess extends CartState {}

final class GetCartError extends CartState {
  final String error;

  GetCartError({required this.error});
}

final class UpdateCartLoading extends CartState {}

final class UpdateCartSuccess extends CartState {}

final class UpdateCartError extends CartState {
  final String error;

  UpdateCartError({required this.error});
}

final class RemoveFromCartLoading extends CartState {}

final class RemoveFromCartSuccess extends CartState {}

final class RemoveFromCartError extends CartState {
  final String error;

  RemoveFromCartError({required this.error});
}
final class GetCustomerDetailsLoadingState extends CartState {}
final class GetCustomerDetailsSuccessState extends CartState {}
final class GetCustomerDetailsErrorState extends CartState {
  final String error;
  GetCustomerDetailsErrorState({required this.error});
}

final class GetCountriesLoadingState extends CartState {}
final class GetCountriesSuccessState extends CartState {}
final class GetCountriesErrorState extends CartState {
  final String error;
  GetCountriesErrorState({required this.error});
}
