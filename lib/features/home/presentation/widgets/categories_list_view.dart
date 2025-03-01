import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../manager/home_cubit/home_cubit.dart';
import '../views/products_view.dart';
import 'category_widget.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ListView.builder(
                itemCount: cubit.mainCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CategoryWidget(
                        categoryModel: cubit.mainCategories[index],
                        onTap: () {
                          print(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsView(
                                  categoryModel: cubit.mainCategories[index],
                                ),
                              ));
                        },
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
