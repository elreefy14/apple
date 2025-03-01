import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/customer_details_model.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/country_model.dart';
import '../../../../core/services/customer_details_service.dart';

part 'shipping_and_billing_state.dart';

class ShippingAndBillingCubit extends Cubit<ShippingAndBillingState> {
  ShippingAndBillingCubit({
    required this.customerDetailsService,
  }) : super(ShippingAndBillingInitial());

  static ShippingAndBillingCubit get(context) => BlocProvider.of(context);

  final CustomerDetailsService customerDetailsService;

  CustomerDetailsModel? customerDetailsModel;

  Country? cities;

  getCities() async {
    emit(GetCountriesLoadingState());
    try {
      cities = await customerDetailsService.getCities();
      emit(GetCountriesSuccessState());
    } catch (e) {
      emit(GetCountriesErrorState(error: e.toString()));
    }
  }
  bool? isInRiyadh ;

  Future<void> getCustomerDetails() async {
    emit(GetCustomerDetailsLoadingState());
    try {
      customerDetailsModel = await customerDetailsService.getCustomerDetails();
      await getShippingZones().then(
        (value) {
          if (customerDetailsModel?.shipping?.city == 'Ar-Riyad') {
            isInRiyadh = true;
            print(isInRiyadh);
            print(customerDetailsModel?.shipping?.city);

          } else {
            isInRiyadh = false;
            print(customerDetailsModel?.shipping?.state);
            print(isInRiyadh);
          }
        },
      );
      emit(GetCustomerDetailsSuccessState());
    } catch (e) {
      emit(GetCustomerDetailsErrorState(error: e.toString()));
    }
  }



  Future<dynamic> getShippingZones() async {
    return await customerDetailsService.getShippingZones();
  }
}
