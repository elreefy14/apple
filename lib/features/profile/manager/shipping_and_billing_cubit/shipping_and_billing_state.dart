part of 'shipping_and_billing_cubit.dart';

@immutable
sealed class ShippingAndBillingState {}

final class ShippingAndBillingInitial extends ShippingAndBillingState {}
final class GetCustomerDetailsLoadingState extends ShippingAndBillingState {}
final class GetCustomerDetailsSuccessState extends ShippingAndBillingState {}
final class GetCustomerDetailsErrorState extends ShippingAndBillingState {
  final String error;
  GetCustomerDetailsErrorState( {required this.error});
}
final class GetCountriesLoadingState extends ShippingAndBillingState {}
final class GetCountriesSuccessState extends ShippingAndBillingState {}
final class GetCountriesErrorState extends ShippingAndBillingState {
  final String error;
  GetCountriesErrorState( {required this.error});
}
final class ClearCartLoading extends ShippingAndBillingState {}
final class ClearCartSuccess extends ShippingAndBillingState {}
final class ClearCartError extends ShippingAndBillingState {
  final String error;
  ClearCartError( {required this.error});
}