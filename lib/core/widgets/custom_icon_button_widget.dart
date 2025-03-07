import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomIconButtonWidget extends StatelessWidget {
  const CustomIconButtonWidget({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.isLoading = false,
    required this.iconData,
    required this.iconColor,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final Color iconColor;
  final Color? backgroundColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundColor: backgroundColor ?? Colors.white,
        radius: 20,
        child: isLoading!
            ? const Center(
              child: SizedBox(
                width:  20,
                height: 20,
                child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
              ),
            )
            : Icon(
                iconData,
                color: iconColor,
              ),
      ),
    );
  }
}
