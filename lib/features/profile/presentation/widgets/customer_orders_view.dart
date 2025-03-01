import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/PaymentMethodsViewForOrders.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/services/order_service.dart';
import '../../../../core/services/register_services.dart';
import '../view/customer_orders_cubit/customer_orders_cubit.dart';

class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerOrdersCubit(
        orderService: getIt.get<OrderService>(),
      )..getCustomerOrders(customerId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: BlocBuilder<CustomerOrdersCubit, CustomerOrdersState>(
          builder: (context, state) {
            var cubit = CustomerOrdersCubit.get(context);
            if (state is CustomerOrdersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: cubit.orders?.length,
                  itemBuilder: (context, index) {
                    final order = cubit.orders![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '#${order.orderId}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'ر.س Total: ${order.total}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    order.status,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: order.status == 'processing'
                                          ? Colors.orange
                                          : order.status == 'completed'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order.lineItems.length,
                              itemBuilder: (context, index) {
                                final product = order.lineItems[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(product
                                                    .orderThumbnail ??
                                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fphotos%2Ftree-sunset-clouds-sky-silhouette-736885%2F&psig=AOvVaw3vHD8plCSQone-febAPEgR&ust=1738881159894000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKiC_aDLrYsDFQAAAAAdAAAAABAE'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            child: AutoSizeText(
                                              '${product.name}',
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${(double.tryParse(product.price) ?? 0).toInt() * product.quantity}ر.س',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            if (order.status == 'pending' ||
                                order.status == 'failed' ||
                                order.status == 'refunded')
                              CustomButton(
                                title: 'اكمل الطلب',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentMethodsViewForOrders(
                                          orderId: order.orderId!,
                                          amount:
                                              (double.tryParse(order.total) ??
                                                      0)
                                                  .toInt(),
                                        ),
                                      ));
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
