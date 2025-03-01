import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';
import 'package:masalriyadh/features/auth/presentation/view/login_view.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../home_layout.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    super.key,
    this.height = 75,
    this.icon,
    required this.title,
    this.onTap,
    this.showButton = false,
  });

  final double height;
  final IconData? icon;
  final String title;
  final void Function()? onTap;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  icon != null
                      ? Icon(icon, color: AppColors.primaryColor)
                      : const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                          ),
                        ),
                  SizedBox(width: 10),
                  AutoSizeText(title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  Spacer(),
                ],
              ),
              if (showButton == true) SizedBox(height: 10),
              if (showButton == true)
                CustomButton(
                  title: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                            (route) => false,
                      );
                    },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
