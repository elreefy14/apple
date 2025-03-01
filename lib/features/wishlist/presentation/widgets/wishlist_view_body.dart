import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/data/local/shared_helper.dart';
import 'package:masalriyadh/features/wishlist/presentation/widgets/wishlist_product_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../home/presentation/views/product_details_view.dart';
import '../../manager/wishlist_cubit/wishlist_cubit.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = WishlistCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: SharedHelper.get(key: SharedKeys.token) != null
                ? [
                    SliverToBoxAdapter(
                        child: state is WishlistLoadingState ||
                                state is ToggleWishlistLoadingState ||
                                state is GetWishlistLoading
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            : cubit.wishlistProducts.isNotEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubit.wishlistProducts.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: .5),
                                    itemBuilder: (context, index) {
                                      print('====================================');
                                      print(cubit.wishlistProducts.length);
                                      print(cubit.wishlistProducts[index].name);
                                      print(cubit.wishlistProducts[index].id);
                                      print('====================================');
                                      return WishlistProductWidget(
                                        index:  index,
                                        productModel:
                                            cubit.wishlistProducts[index],
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsView(
                                                productModel: cubit
                                                    .wishlistProducts[index],
                                                    heroTag:  '${index}WishlistViewBody',
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : cubit.wishlistProducts.isNotEmpty
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'لا يوجد منتجات في قائمة الرغبات',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Center(
                                              child: Image.asset(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                'assets/images/favoriets_empty.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                  ]
                : [
                    SliverToBoxAdapter(
                        child: SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'لا يوجد منتجات في قائمة الرغبات',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              height: MediaQuery.of(context).size.height * 0.5,
                              'assets/images/favoriets_empty.png',
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
          ),
        );
      },
    );
  }
}
