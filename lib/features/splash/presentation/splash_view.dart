import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';
import 'package:masalriyadh/features/onboarding/presentation/view/on_boarding_view.dart';
import 'package:masalriyadh/home_layout.dart';

import '../../../core/services/data/local/shared_helper.dart';
import '../../../core/services/data/local/shared_keys.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // يبدأ من فوق
      end: const Offset(0.0, 0.0), // ينتهي في مكانه الطبيعي
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // تشغيل الأنيميشن تلقائيًا
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SharedHelper.get(key: SharedKeys.isFirstLogin) == true ||
                      SharedHelper.get(key: SharedKeys.isFirstLogin) == null
                  ? const OnBoardingView()
                  : const HomeLayout(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const Text(
                'مــاس الرياض',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
