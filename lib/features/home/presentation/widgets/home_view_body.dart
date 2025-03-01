import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/helper_functions/add_tax.dart';
import 'package:masalriyadh/core/models/product_model.dart';
import 'package:masalriyadh/core/shimmer_widgets/categories_shimmer.dart';
import 'package:masalriyadh/core/widgets/custom_carousel_widget.dart';
import 'package:masalriyadh/features/home/manager/home_cubit/home_cubit.dart';
import 'package:masalriyadh/features/home/presentation/views/product_details_view.dart';
import 'package:masalriyadh/features/home/presentation/widgets/categories_list_view.dart';
import 'package:masalriyadh/features/home/presentation/widgets/products_view_body.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/shimmer_widgets/carousel_shimmer_widget.dart';
import '../../../../core/shimmer_widgets/shimmer_home_view_products_sliver.dart';
import '../../../../core/widgets/cached_network_image_widget.dart';
import '../views/products_view.dart';
import 'home_view_products_sliver.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  static final List<String> partners = [
    'https://masalriyadh.com/wp-content/uploads/2025/02/bb.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/bull.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/cm.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/dadco.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/dcp.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/deb.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/fosroc.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/safv.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/silk.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/weber.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/%D8%A7%D8%B1%D9%83-1.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/%D8%A7%D9%8A%D8%B2%D9%88-1.png',
    'https://masalriyadh.com/wp-content/uploads/2025/02/%D8%AF%D9%84%D9%85%D9%88%D9%86.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: state is GetBannersLoading || cubit.mainBanners.isEmpty
                      ? const CarouselShimmerWidget()
                      : CustomCarouselWidget(
                          duration: Duration(seconds: 3),
                          items: cubit.mainBanners
                              .map(
                                (e) => Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CachedNetworkImageWidget(
                                    fit: BoxFit.fill,
                                    image: e.url ??
                                        'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
                                  ),
                                ),
                              )
                              .toList(),
                          height: 200,
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'الأقسام',
                      style: AppTextStyles.primary20Bold
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150,
                    child: state is GetCategoriesLoading ||
                            cubit.mainCategories.isEmpty
                        ? const CategoryShimmerList()
                        : const CategoriesListView(),
                  ),
                ),
                SliverToBoxAdapter(
                  child:
                      state is GetBannersLoading || cubit.secondBanners.isEmpty
                          ? const CarouselShimmerWidget()
                          : cubit.secondBanners.isEmpty
                              ? const SizedBox()
                              : Container(
                                  width: double.infinity,
                                  height: 200,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImageWidget(
                                    fit: BoxFit.fill,
                                    image: cubit.secondBanners.first.url ??
                                        'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
                                  ),
                                ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'منتجات مميزة',
                      style: AppTextStyles.primary20Bold
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is GetProductsLoading ||
                          cubit.featuredProducts.isEmpty
                      ? const ShimmerHomeViewProductsSliver()
                      : HomeViewProductsSliver(
                          specialIndex: '1',
                          products: cubit.featuredProducts,
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'احدث المنتجات',
                      style: AppTextStyles.primary20Bold
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is GetNewProductsLoading ||
                          cubit.newProducts.isEmpty
                      ? const ShimmerHomeViewProductsSliver()
                      : HomeViewProductsSliver(
                          specialIndex: '2',
                          products: cubit.newProducts,
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child:
                      state is GetBannersLoading || cubit.thirdBanners.isEmpty
                          ? const CarouselShimmerWidget()
                          : cubit.thirdBanners.isEmpty
                              ? const SizedBox()
                              : Container(
                                  width: double.infinity,
                                  height: 200,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImageWidget(
                                    fit: BoxFit.fill,
                                    image: cubit.thirdBanners.first.url ??
                                        'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
                                  ),
                                ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عزل ايبوكسى',
                            style: AppTextStyles.primary20Bold
                                .copyWith(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsView(
                                    categoryModel: cubit.mainCategories[4],
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'مشاهدة المزيد',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is GetEpoxyProductsLoadingState ||
                          cubit.epoxy.isEmpty
                      ? const ShimmerHomeViewProductsSliver()
                      : HomeViewProductsSliver(

                          specialIndex: '3',
                    products: (cubit.epoxy..shuffle())
                        .take(5)
                        .toList(),
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عزل حمامات',
                            style: AppTextStyles.primary20Bold
                                .copyWith(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsView(
                                    categoryModel: cubit.mainCategories[6],
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'مشاهدة المزيد',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: state is GetAzlHamamProductsLoadingState || cubit.azlHamam.isEmpty
                      ? const ShimmerHomeViewProductsSliver()
                      : HomeViewProductsSliver(
                          specialIndex: '4',
                          // products: cubit.azlHamam,
                          products: (cubit.azlHamam..shuffle())
                              .take(5)
                              .toList(),
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'شركائنا',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          partners.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CachedNetworkImageWidget(
                                    image: partners[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                )
              ]),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: () async {
                  String whatsappUrl = "https://wa.me/+966538324169";
                  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                    await launchUrl(Uri.parse(whatsappUrl));
                  } else {
                    print("Could not launch $whatsappUrl");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor.withOpacity(.8),
                  ),
                  child: const Row(
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
            )
          ],
        );
      },
    );
  }
}
