import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../constants/colors.dart';

class CustomCarouselWidget extends StatelessWidget {
  const CustomCarouselWidget({
    super.key,
    required this.items,
     this.height,
    this.duration =  const Duration(seconds: 3),
    this.showIndicator = true,
  });

  final List<Widget> items;
  final double? height;
  final Duration duration;
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      items: items,

      options: FlutterCarouselOptions(
        height: height,
        showIndicator: showIndicator,
        autoPlay: true,

        pauseAutoPlayOnManualNavigate:  true,
        pauseAutoPlayOnTouch:  false,
        pauseAutoPlayInFiniteScroll:  false,
        autoPlayInterval: duration,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: const SlideIndicatorOptions(
            indicatorBorderColor: Colors.white,
            indicatorBackgroundColor: AppColors.primaryColor,

          ),
        ),
      ),
    );
  }
}
