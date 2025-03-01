part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetCustomerDetailsLoadingState extends ProfileState {}
final class GetCustomerDetailsSuccessState extends ProfileState {}
final class GetCustomerDetailsErrorState extends ProfileState {
  final String error;
  GetCustomerDetailsErrorState({required this.error});
}

final class GetCustomerOrdersLoadingState extends ProfileState {}
final class GetCustomerOrdersSuccessState extends ProfileState {}
final class GetCustomerOrdersErrorState extends ProfileState {
  final String error;
  GetCustomerOrdersErrorState({required this.error});
}