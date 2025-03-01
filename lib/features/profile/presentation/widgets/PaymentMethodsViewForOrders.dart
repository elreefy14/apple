import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

import '../../../../core/services/data/remote/end_points.dart';
import '../../../cart/presentation/views/create_order_success.dart';

class PaymentMethodsViewForOrders extends StatefulWidget {
  const PaymentMethodsViewForOrders({
    super.key,
    required this.amount,
    required this.orderId,
  });

  final int amount;
  final int orderId;

  @override
  State<PaymentMethodsViewForOrders> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsViewForOrders> {
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.setLocale(Locale('ar')); // أو أي لغة تانية
        }
      },
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PaymentMethodsViewBodyForOrders(
              amount: widget.amount,
              orderId: widget.orderId,
            )),
      ),
    );
  }
}

class PaymentMethodsViewBodyForOrders extends StatelessWidget {
  const PaymentMethodsViewBodyForOrders(
      {super.key, required this.amount, required this.orderId});

  final int amount;
  final int orderId;

  getPaymentConfig() {
    final finalAmount = amount*100;

    final paymentConfig = PaymentConfig(
      publishableApiKey: EndPoints.publishKey,
      amount: finalAmount,
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
