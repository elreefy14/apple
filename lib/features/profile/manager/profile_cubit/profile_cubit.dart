import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/services/customer_details_service.dart';
import 'package:meta/meta.dart';
import '../../../../core/models/customer_details_model.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/services/order_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.customerDetailsService,
  }) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final CustomerDetailsService customerDetailsService;

  CustomerDetailsModel? customerDetailsModel;
  String? customerId;

  getCustomerId() async {
    customerId = customerDetailsService.extractUserId();
  }


}

