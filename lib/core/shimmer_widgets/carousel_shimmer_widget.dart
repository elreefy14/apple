import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class CarouselShimmerWidget extends StatelessWidget {
  const CarouselShimmerWidget({
    super.key,
    this.height = 200,
    this.itemCount = 3,
  });

  final double height;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      items: List.generate(
        itemCount,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      options: FlutterCarouselOptions(
        height: height,
        showIndicator: false, // لا نحتاج مؤشر أثناء التحميل
        autoPlay: false, // لا حاجة للتشغيل التلقائي في الشيمر
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}
