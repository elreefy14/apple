import 'package:flutter/material.dart';
import 'package:masalriyadh/core/constants/colors.dart';

showDeleteAccountDialog(
    {required BuildContext context, required String jwtToken, required void Function()? onPressed}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // يمنع إغلاق النافذة بالضغط خارجها
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('تأكيد حذف الحساب'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('هل أنت متأكد أنك تريد حذف حسابك؟'),
              Text('لن تتمكن من استعادته بعد الحذف.'),
            ],
          ),
        ),
        actions: <Widget>[
          SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: onPressed,
                    child: const Text(
                        'حذف الحساب', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // إغلاق النافذة بدون حذف الحساب
                    },
                    child: const Text('إلغاء', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
