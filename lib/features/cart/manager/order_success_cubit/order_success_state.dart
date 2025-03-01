part of 'order_success_cubit.dart';

@immutable
sealed class OrderSuccessState {}

final class OrderSuccessInitial extends OrderSuccessState {}
final class GetOrderByIdLoadingState extends OrderSuccessState {}
final class GetOrderByIdSuccessState extends OrderSuccessState {}
final class GetOrderByIdErrorState extends OrderSuccessState {
  final String error;

  GetOrderByIdErrorState({required this.error});
}
