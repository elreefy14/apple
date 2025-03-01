import 'package:flutter/material.dart';

import '../../../../core/models/customer_details_model.dart';

class BillingWidget extends StatelessWidget {
  const BillingWidget({super.key, required this.billingDetails, this.onTap});

  final Billing? billingDetails;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تفاصيل الفاتورة',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'الاسم الاول: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Text(
                            billingDetails?.firstName ?? 'firstName',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'الاسم الاخير: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Text(
                            billingDetails?.lastName ?? 'lastName',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'الدولة: ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Text(
                            billingDetails?.country ?? 'country',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       ' المدينة: ',
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Text(
                      //       billingDetails?.city ?? 'city',
                      //       style: const TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //     ),
                      //   ],
                      // ),

                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
