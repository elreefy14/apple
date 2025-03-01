import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/models/all_catigories_model.dart';

import '../../../../core/constants/colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryModel,
    this.onTap,
  });

  final CategoryModel categoryModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // image: DecorationImage(
              //   fit: BoxFit.fitHeight,
              // image: CachedNetworkImageProvider(
              //   categoryModel.imageUrl ??
              //       'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
              //
              //   errorListener: (p0) =>  'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
              // ),
            ),
            child: CachedNetworkImage(
              width:  double.infinity,
              height:  double.infinity,
              imageUrl: categoryModel.imageUrl ??
                  'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator(
                color: AppColors.primaryColor.withOpacity(.8),
                backgroundColor:  Colors.grey[200],
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AutoSizeText(
            categoryModel.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
