// import 'package:flutter/material.dart';
// import 'package:masalriyadh/core/models/customer_details_model.dart';
// import 'package:masalriyadh/core/services/data/remote/end_points.dart';
// import 'package:masalriyadh/core/widgets/custom_text_form_field.dart';
// import 'package:moyasar/moyasar.dart';
// import '../../../../core/models/cart_model.dart';
// import '../../../../core/models/order_model.dart';
// import '../../../../core/services/data/local/shared_helper.dart';
// import '../../../../core/services/data/local/shared_keys.dart';
// import '../../../../core/services/order_service.dart';
// import '../../../../core/services/register_services.dart';
// import '../../../../core/widgets/custom_button.dart';
// import '../views/payment_methods_view.dart';
//
// class AddCommentsView extends StatelessWidget {
//   const AddCommentsView({
//     super.key,
//     required this.customerDetailsModel,
//     required this.cart,
//     required this.shippingCost,
//     required this.orderId,
//   });
//
//   final CustomerDetailsModel customerDetailsModel;
//   final CartModel cart;
//   final double shippingCost;
//   final int orderId;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('العناوين والبيانات الشحنية'),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: GestureDetector(
//               onTap: () {},
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: Colors.grey[200]!,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'ملاحظت الطلب الاضافية',
//                               style: TextStyle(
//                                   fontSize: 16, color: Colors.black54),
//                             ),
//                             const SizedBox(height: 10),
//                             CustomTextFormField(
//                               label: '',
//                               controller: TextEditingController(),
//                               noValidator: true,
//                               border: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                 width: 0,
//                                 color: Colors.transparent,
//                               )),
//                               maxLines: 5,
//                             ),
//                             const SizedBox(height: 10),
//                           ]),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: CustomButton(
//                 title: 'يكمل',
//                 onTap: () async {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentMethodsView(
//                         orderId: orderId,
//                         shippingCost: shippingCost,
//                         cart: cart,
//                         customerDetailsModel: customerDetailsModel,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
