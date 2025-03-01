part of 'customer_orders_cubit.dart';

@immutable
sealed class CustomerOrdersState {}

final class CustomerOrdersInitial extends CustomerOrdersState {}

final class CustomerOrdersLoadingState extends CustomerOrdersState {}

final class CustomerOrdersSuccessState extends CustomerOrdersState {
  CustomerOrdersSuccessState();
}

final class CustomerOrdersErrorState extends CustomerOrdersState {
  final String error;

  CustomerOrdersErrorState({required this.error});
}
