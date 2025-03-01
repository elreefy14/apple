import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/features/cart/presentation/widgets/payment_methods_view_body.dart';
import '../../../../core/models/cart_model.dart';
import '../../../../core/models/customer_details_model.dart';
import '../../manager/cart_cubit/cart_cubit.dart';

class PaymentMethodsView extends StatefulWidget {
  const PaymentMethodsView(
      {super.key,
      required this.cart,
      required this.customerDetailsModel,
      required this.shippingCost,
      required this.orderId});

  final double shippingCost;
  final CartModel cart;
  final CustomerDetailsModel customerDetailsModel;
  final int orderId;

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setLocale(Locale('en')); // أو أي لغة تانية
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult:  (didPop, result) {
        if (didPop) {
          context.setLocale(Locale('ar')); // أو أي لغة تانية

        }
      },

      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PaymentMethodsViewBody(
              orderId: widget.orderId,
              shippingCost: widget.shippingCost,
              cart: widget.cart,
              customerDetailsModel: widget.customerDetailsModel,
            )),
      ),
    );
  }
}
