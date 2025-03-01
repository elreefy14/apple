import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/home/manager/products_cubit/products_cubit.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_grid_view_widget.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/helper_functions/show_login_dialog.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/widgets/custom_show_toast.dart';
import '../views/product_details_view.dart';
import 'category_widget.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is AddToCartSuccessState) {
          customShowToast(
            message: 'تم اضافة المنتج الى السلة بنجاح',
            toastColor: ToastColor.success,
          );
        }
      },
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        if (state is GetProductsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else {
          return cubit.products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'قريبا سيتم اضافة المنتجات',
                        style: AppTextStyles.primary20Bold,
                      ),
                      Image.asset(
                        'assets/images/soon.png',
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: .55),
                        itemBuilder: (context, index) {
                          return ProductGridViewWidget(
                            index: index,
                            isLoading: cubit.isLoadingList[index],
                            onAddToStockTap: () {
                              cubit.onItemTap(index);
                              if (SharedHelper.get(
                                      key: SharedKeys.customerId) ==
                                  null) {
                                showLoginDialog(context);
                              } else {
                                cubit.addToCart(
                                    productModel: cubit.products[index]);
                              }
                            },
                            productModel: cubit.products[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsView(
                                    heroTag:   '${index}ProductsViewBody',
                                    productModel: cubit.products[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 20,
                    ))
                  ],
                );
        }
      },
    );
  }
}
