import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/features/home/manager/product_details_cubit/product_details_cubit.dart';
import 'package:masalriyadh/features/home/manager/products_cubit/products_cubit.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_details_first_section.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_details_fourth_section.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_details_second_section.dart';
import 'package:masalriyadh/features/home/presentation/widgets/product_details_third_section.dart';
import 'package:masalriyadh/features/wishlist/manager/wishlist_cubit/wishlist_cubit.dart';
import '../../../../core/helper_functions/show_login_dialog.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/widgets/custom_icon_button_widget.dart';
import '../../../../core/widgets/custom_show_toast.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody(
      {super.key, required this.productModel, required this.heroTag});

  final ProductModel? productModel;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    print( '====================================================');
    print( ProductDetailsCubit.get(context).isProductInWishlist);
    print( '====================================================');
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        var cubit = ProductDetailsCubit.get(context);
        if (state is AddToCartSuccess) {
          customShowToast(
            message: 'Add To Cart Success',
            toastColor: ToastColor.success,
          );
        }
        if (state is ToggleWishlistSuccess) {
          bool isInWishlist = cubit.isInWishlist(productModel: productModel!);
          customShowToast(
            message: isInWishlist
                ? 'تم الاضافة الى المفضله بنجاح'
                : 'تم الحذف من المفضله بنجاح',
            toastColor: ToastColor.success,
          );
        }
        if (state is ToggleWishlistError) {
          customShowToast(
            message: state.error,
            toastColor: ToastColor.error,
          );
        }
      },
      builder: (context, state) {
        var cubit = ProductDetailsCubit.get(context);
        return SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 450,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     fit: BoxFit.fitWidth,
                      //     image: NetworkImage(productModel?.images?.isEmpty ==
                      //                 true ||
                      //             productModel?.images?[0]?.src == null
                      //         ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                      //         : productModel?.images?[0]?.src ??
                      //             'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'),
                      //   ),
                      // ),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl: productModel?.images?.isEmpty == true ||
                                productModel?.images?[0]?.src == null
                            ? 'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png'
                            : productModel?.images?[0]?.src ??
                                'https://masalriyadh.com/wp-content/uploads/woocommerce-placeholder-600x600.png',
                        imageBuilder: (context, imageProvider) => Hero(
                          tag: heroTag,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: Colors.grey[300],
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child:
                        ProductDetailsFirstSection(productModel: productModel!),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductDetailsSecondSection(
                        productModel: productModel!),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductDetailsThirdSection(
                      productModel: productModel!,
                      onTap: () {
                        if (SharedHelper.get(key: SharedKeys.customerId) ==
                            null) {
                          showLoginDialog(context);
                        } else {
                          cubit.addToCart(productModel: productModel!);
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductDetailsFourthSection(
                        productModel: productModel!),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                ],
              ),
              Align(
                heightFactor: 3,
                child: Row(
                  children: [
                    CustomIconButtonWidget(
                        iconData: Icons.arrow_back,
                        iconColor: AppColors.primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const Spacer(),
                    CustomIconButtonWidget(
                        isLoading: state is ToggleWishlistLoading,
                        iconData:
                            cubit.isProductInWishlist
                                ? Icons.favorite
                                : Icons.favorite_border,
                        iconColor: AppColors.primaryColor,

                        onPressed: () async {
                          if (SharedHelper.get(key: SharedKeys.customerId) ==
                              null) {
                            showLoginDialog(context);
                            return;
                          } else {
                            await cubit.toggleWishlist(productModel: productModel!);
                            await WishlistCubit.get(context).getWishListProducts();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
