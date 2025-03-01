import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({super.key, this.image, this.fit});

  final String? image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: double.infinity,
      imageUrl: image ??
          'https://masalriyadh.com/wp-content/uploads/2025/02/منتجات.jpg',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment:  Alignment.topCenter,
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor.withOpacity(.3),
            backgroundColor: Colors.grey[200],
          )),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
