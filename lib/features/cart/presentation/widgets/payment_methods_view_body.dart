import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/models/cart_model.dart';
import 'package:masalriyadh/core/services/order_service.dart';
import 'package:masalriyadh/features/cart/presentation/views/create_order_success.dart';
import 'package:moyasar/moyasar.dart';
import '../../../../core/models/customer_details_model.dart';
import '../../../../core/services/data/remote/end_points.dart';

class PaymentMethodsViewBody extends StatelessWidget {
  const PaymentMethodsViewBody({
    required this.cart,
    required this.customerDetailsModel,
    super.key,
    required this.shippingCost,
    required this.orderId,
  });

  final CartModel cart;
  final CustomerDetailsModel customerDetailsModel;
  final double shippingCost;
  final int orderId;

  getPaymentConfig() {
    final amount =
        addTax(price: (cart.totals.subtotal * 10) + (shippingCost * 100))
            .toInt();

    final paymentConfig = PaymentConfig(
      publishableApiKey: EndPoints.publishKey,
      amount: amount,
      // SAR 257.58
      description: 'orderId : $orderId',
      creditCard: CreditCardConfig(
        saveCard: true,
        manual: true,
      ),
    );

    return paymentConfig;
  }

  Future<void> onPaymentResult(BuildContext context, result) async {
    final amount = addTax(price: cart.totals.subtotal * 10) +
        (addTax(price: shippingCost * 10)).toInt();
    if (result is PaymentResponse) {
      String paymentMethod = '';
      if (result.source is CardPaymentResponseSource) {
        CardPaymentResponseSource source = result.source;
        paymentMethod = source.type.name;
        print('paymentMethod: $paymentMethod');
      } else if (result.source is ApplePayPaymentResponseSource) {
        ApplePayPaymentResponseSource source = result.source;
        paymentMethod = source.type.name;
        print('paymentMethod: $paymentMethod');
      }
      switch (result.status) {
        case PaymentStatus.paid:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrderSuccessView(
                  paymentMethod: paymentMethod,
                  orderId: orderId,
                  isPaid: true,
                ),
              ),
              (route) => false);
          break;
        case PaymentStatus.failed:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrderSuccessView(
                  paymentMethod: paymentMethod,
                  orderId: orderId,
                  isPaid: false,
                ),
              ),
              (route) => false);
          break;
        case PaymentStatus.initiated:
          // handle failure.
          break;
        case PaymentStatus.authorized:
          // handle failure.
          break;
        case PaymentStatus.captured:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CreditCard(

          locale: const Localization.ar(languageCode:  'ar',),

          config: getPaymentConfig(),
          onPaymentResult: (result) {
            return onPaymentResult(context, result);
          },
        ),
      ],
    );
  }
}
