import 'package:flutter/material.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';

import '../../features/auth/presentation/view/login_view.dart';

showLoginDialog(context) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('عزيزي المستخدم'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('يجب عليك تسجيل الدخول للمتابعة'),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height:  50,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
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
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: CustomButton(
                        title:  'الغاء',
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
            )
          ],
        );
      });
}
