import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/auth/presentation/view/sign_up_view.dart';
import 'package:masalriyadh/features/auth/presentation/widgets/login_form_section.dart';
import 'package:masalriyadh/features/auth/presentation/widgets/auth_image_section.dart';
import 'package:masalriyadh/features/settings/prsentation/reset_pass_view.dart';
import 'package:masalriyadh/home_layout.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم التسجيل بنجاح',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeLayout(),
            ),
            (route) => false,
          );
        }
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'البريد الالكتروني او كلمة المرور غير صحيحة',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,

            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: AuthImageSection()),
            const SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                child: LoginFormSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassView(),
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpView(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'اضغط هنا لتسجيل حساب جديد',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Text(
                    ' ليس لديك حساب؟',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayout(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'استكمل التسجيل كزائر',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        title: 'تسجيل الدخول',
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.login();
                          } else {
                            cubit.autoValidateMode = AutovalidateMode.always;
                          }
                        },
                        isLoading: state is LoginLoading ? true : false,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
