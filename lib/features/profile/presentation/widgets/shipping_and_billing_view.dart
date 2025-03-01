import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/models/customer_details_model.dart';
import 'package:masalriyadh/core/widgets/custom_show_toast.dart';
import 'package:masalriyadh/features/profile/manager/shipping_and_billing_cubit/shipping_and_billing_cubit.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/billing_details.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/billing_widget.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/shipping_details.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/shipping_widget.dart';

import '../../../../core/models/cart_model.dart';
import '../../../../core/models/country_model.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/services/customer_details_service.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/services/order_service.dart';
import '../../../../core/services/register_services.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/shimmer_shipping_and_billing_widget.dart';
import '../../../cart/presentation/views/payment_methods_view.dart';
import '../../../cart/presentation/widgets/add_comments_view.dart';

class ShippingAndBillingView extends StatefulWidget {
  const ShippingAndBillingView({
    super.key,
    this.cart,
    this.isPay = false,
  });

  final bool isPay;
  final CartModel? cart;

  @override
  State<ShippingAndBillingView> createState() => _ShippingAndBillingViewState();
}

class _ShippingAndBillingViewState extends State<ShippingAndBillingView> {
  @override
  void initState() {
    ShippingAndBillingCubit.get(context).getCustomerDetails();
    ShippingAndBillingCubit.get(context).getCities();
    ShippingAndBillingCubit.get(context).getShippingZones();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setLocale(const Locale('ar')); // أو أي لغة تانية
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العناوين والبيانات الشحنية'),
      ),
      body: BlocBuilder<ShippingAndBillingCubit, ShippingAndBillingState>(
        builder: (context, state) {
          var cubit = ShippingAndBillingCubit.get(context);
          int cartItems = widget.cart?.items
                  .map((e) => e.quantity)
                  .reduce((a, b) => a + b) ??
              0;

          return CustomScrollView(
            slivers: [
              state is GetCustomerDetailsSuccessState
                  ? ShippingWidget(
                      shippingDetails: cubit.customerDetailsModel?.shipping,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShippingDetails(
                              customerDetailsModel: cubit.customerDetailsModel!,
                              cities: cubit.cities ??
                                  Country(
                                    name: 'المملكة العربية السعودية',
                                    code: 'SA',
                                    states: [],
                                  ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SliverToBoxAdapter(
                      child: ShimmerBillingWidget(
                      numOfRows: 4,
                    )),
              state is GetCustomerDetailsSuccessState
                  ? BillingWidget(
                      billingDetails: cubit.customerDetailsModel?.billing,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillingDetails(
                              customerDetailsModel: cubit.customerDetailsModel!,
                              cities: cubit.cities ??
                                  Country(
                                    name: 'المملكة العربية السعودية',
                                    code: 'SA',
                                    states: [],
                                  ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SliverToBoxAdapter(
                      child: ShimmerBillingWidget(
                      numOfRows: 3,
                    )),
              if (widget.isPay)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[200]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'مجموع السعر',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${addTax(price: (widget.cart?.totals.subtotal ?? 0) / 10).toStringAsFixed(1)} ر.س',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                cubit.isInRiyadh == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'الشحن ثابت',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '${addTax(price: 50)} ر.س',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'الشحن',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '${addTax(price: cartItems * 15)} ر.س',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'مجموع السعر الكلي',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '${addTax(
                                        price: (widget.cart?.totals.subtotal ??
                                                    0) /
                                                10 +
                                            (cubit.isInRiyadh == true
                                                ? 57.5
                                                : (cartItems * 15)),
                                      ).toStringAsFixed(1)} ر.س',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              if (widget.isPay)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: CustomButton(
                      title: ' انشاء الطلب والذهاب لصفحة الدفع',
                      onTap: () async {
                        final cdSHp = cubit.customerDetailsModel?.shipping;
                        final cdBill = cubit.customerDetailsModel?.billing;
                        if (cdSHp?.firstName == null ||
                            cdSHp?.lastName == null ||
                            cdSHp?.city == null ||
                            cdSHp?.country == null ||
                            cdBill?.firstName == null ||
                            cdBill?.lastName == null ||
                            cdBill?.city == null ||
                            cdBill?.country == null ||
                            cdBill?.address1 == null) {
                          customShowToast(
                            message:
                                'الرجاء التأكد من أضافة بيانات الشحن والفاتورة',
                            toastColor: ToastColor.error,
                          );
                          return;
                        } else {
                          await createOrder(
                                  cart: widget.cart,
                                  customerDetails: cubit.customerDetailsModel!,
                                  shippingCost: cubit.isInRiyadh == true
                                      ? 57.5
                                      : (cartItems * 15))
                              .then(
                            (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return PaymentMethodsView(
                                    orderId: value?.orderId ?? 0,
                                    customerDetailsModel:
                                        cubit.customerDetailsModel!,
                                    cart: widget.cart!,
                                    shippingCost: cubit.isInRiyadh == true ||
                                            cubit.isInRiyadh == null
                                        ? 57.5
                                        : (cartItems * 15),
                                  );
                                }),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  Future<OrderModel?> createOrder({
    required CartModel? cart,
    required CustomerDetailsModel? customerDetails,
    required double shippingCost,
  }) async {
    OrderService orderService = getIt.get<OrderService>();
    OrderModel? orderModel;
    orderModel = OrderModel(
      customerId: int.parse(SharedHelper.get(key: SharedKeys.customerId)),
      status: "pending",
      total: cart?.totals.subtotal.toString() ?? '0',
      shippingLines: [
        ShippingLine(
          methodId: "flat_rate",
          methodTitle: "Flat Rate",
          total: shippingCost.toString(),
        ),
      ],
      discountTotal: "",
      totalTax: "",
      paymentMethod: '',
      paymentMethodTitle: '',
      couponLines: [],
      metaData: [],
      setPaid: false,
      billing: customerDetails?.billing,
      shipping: customerDetails?.shipping,
      lineItems: cart!.items
          .map(
            (e) => LineItem(
              productId: e.id,
              quantity: e.quantity,
              total: e.totals.total.toString(),
            ),
          )
          .toList(),
    );

    try {
      OrderModel? order =
          await orderService.createOrder(orderModel: orderModel);
      return order;
    } catch (e) {
      print('Error creating order: $e');
    }
    return null;
  }
}
