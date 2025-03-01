import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/cart/presentation/widgets/cart_view_body.dart';

import '../../../../core/services/cart_services.dart';
import '../../../../core/services/customer_details_service.dart';
import '../../../../core/services/order_service.dart';
import '../../../../core/services/register_services.dart';
import '../../manager/cart_cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CartViewBody(),
    );
  }
}
