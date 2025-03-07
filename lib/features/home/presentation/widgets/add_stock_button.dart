import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class AddStockButton extends StatelessWidget {
  const AddStockButton({super.key, this.onTap, this.icon, this.iconColor, required this.isLoading});

  final IconData? icon;
  final void Function()? onTap;
  final Color? iconColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: Center(
          child: isLoading ? const SizedBox(
            width:  20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primaryColor,
            ),
          ) : Icon(
            icon ?? Icons.add,
            color:iconColor  ,
          ),
        ),
      ),
    );
  }
}
