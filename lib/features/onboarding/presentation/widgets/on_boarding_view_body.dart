import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';
import 'package:masalriyadh/features/onboarding/presentation/widgets/page_view_widget.dart';

import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../home_layout.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (value) {
            currentPage = value;
            setState(() {});
          },
          children: const [
            PageViewWidget(
              image: 'assets/images/onboarding1.jpg',
              title: 'مرحبا بكم في ماس الرياض',
              subtitle: 'التسوق هنا سهل وممتع، لدينا العديد من العروض الحصريه',
            ),
            PageViewWidget(
              image: 'assets/images/onboarding2.jpg',
              title: 'ماذا نقدم',
              subtitle:
                  'ماس الرياض يقدم لك تجربة تسوق سهلة وممتعة، مع العديد من العروض الحصرية التي لا تفوت',
            ),
          ],
        ),
        if (currentPage != 1)
          Positioned(
            top: 50,
            left: 30,
            child: GestureDetector(
              onTap: () {
                currentPage = 1;
                pageController.jumpToPage(1);
                setState(() {});
              },
              child: Text(
                'تخطى',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 50,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                if (currentPage == 1)
                  CustomButton(
                    title: 'الصفحة الرئيسية',
                    onTap: () {
                      SharedHelper.set(
                          key: SharedKeys.isFirstLogin, value: false);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeLayout(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(

                      duration: const Duration(seconds: 100),
                      height: 6,
                      width: 38,
                      decoration: BoxDecoration(
                          color: currentPage == 1
                              ? AppColors.primaryColor.withOpacity(.5)
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(width: 5),
                    AnimatedContainer(
                      duration: const Duration(seconds: 100),
                      height: 6,
                      width: 38,
                      decoration: BoxDecoration(
                          color: currentPage == 1
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
