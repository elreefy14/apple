import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/features/cart/manager/order_success_cubit/order_success_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/order_service.dart';
import '../../../../core/services/register_services.dart';
import '../../../../home_layout.dart';

class CreateOrderSuccessView extends StatefulWidget {
  const CreateOrderSuccessView(
      {super.key,
      required this.orderId,
      required this.isPaid,
      required this.paymentMethod});

  final int orderId;
  final bool isPaid;
  final String paymentMethod;

  @override
  State<CreateOrderSuccessView> createState() => _CreateOrderSuccessViewState();
}

class _CreateOrderSuccessViewState extends State<CreateOrderSuccessView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setLocale(const Locale('ar')); // أو أي لغة تانية
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderSuccessCubit(orderService: getIt.get<OrderService>())
            ..getOrderWithUpdate(
                orderId: widget.orderId,
                isPaid: widget.isPaid,
                paymentMethod: widget.paymentMethod),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل الطلب'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeLayout()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.home,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          body: const CreateOrderSuccessViewBody()),
    );
  }
}

class CreateOrderSuccessViewBody extends StatelessWidget {
  const CreateOrderSuccessViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderSuccessCubit, OrderSuccessState>(
      builder: (context, state) {
        var cubit = OrderSuccessCubit.get(context);
        return state is GetOrderByIdLoadingState
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'تم الانشاء الطلب بنجاح',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'رقم الطلب: ${cubit.order?.orderId}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'حالة الطلب: ${cubit.order?.status}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'قيمة الطلب: ${cubit.order?.total}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.order?.lineItems.length,
                          itemBuilder: (context, index) {
                            final product = cubit.order?.lineItems[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey[300]!, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(product
                                                  ?.orderThumbnail ??
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
                                            '${product?.name}',
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'الكمية: ${product?.quantity}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'السعر: '
                                          '${addTax(price: double.parse(product?.price ?? '0.00')).toInt() * (product?.quantity ?? 0)}ر.س',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            cubit.paidSuccess == true &&
                                    cubit.paidSuccess != null
                                ? 'شكرا لك أستاذ ${cubit.order?.billing?.firstName} ${cubit.order?.billing?.lastName} تم الطلب بنجاح'
                                : 'لم تتم عملية الدفع بنجاح',
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                'لو كان لديك اي استفسارات يرجى التواصل معنا',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                String whatsappUrl =
                                    "https://wa.me/+966538324169";
                                if (await canLaunchUrl(
                                    Uri.parse(whatsappUrl))) {
                                  await launchUrl(Uri.parse(whatsappUrl));
                                } else {
                                  print("Could not launch $whatsappUrl");
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: 45,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primaryColor.withOpacity(.8),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'تواصل معنا',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
