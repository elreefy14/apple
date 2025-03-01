import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/order_service.dart';
import 'package:meta/meta.dart';

import '../../../../../core/models/order_model.dart';

part 'customer_orders_state.dart';

class CustomerOrdersCubit extends Cubit<CustomerOrdersState> {
  CustomerOrdersCubit({required this.orderService})
      : super(CustomerOrdersInitial());

  static CustomerOrdersCubit get(context) => BlocProvider.of(context);
  final OrderService orderService;
  List<OrderModel>? orders = [];
  getCustomerOrders(String customerId) async {
    emit(CustomerOrdersLoadingState());
    try {
       orders = await orderService.getCustomerOrders(customerId: customerId);
      emit(CustomerOrdersSuccessState());
    } catch (e) {
      emit(CustomerOrdersErrorState(error: e.toString()));
    }
  }
}
