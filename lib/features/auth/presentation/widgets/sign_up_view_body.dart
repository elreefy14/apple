import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/auth/manager/signup_cupit/signup_cubit.dart';
import 'package:masalriyadh/features/auth/manager/signup_cupit/signup_cubit.dart';
import 'package:masalriyadh/features/auth/presentation/view/login_view.dart';
import 'package:masalriyadh/features/auth/presentation/widgets/sign_up_form_section.dart';
import 'package:masalriyadh/features/auth/presentation/widgets/auth_image_section.dart';
import 'package:masalriyadh/home_layout.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is SignupSuccess) {
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
              builder: (context) => const LoginView(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var cubit = SignupCubit.get(context);
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: AuthImageSection()),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SignUpFormSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'اضغط هنا لتسجيل الدخول',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                      Text(
                        'لديك حساب؟',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
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
                        title: 'تسجيل',
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.signUp();
                          } else {
                            cubit.autoValidateMode = AutovalidateMode.always;
                          }
                        },
                        isLoading: state is SignupLoading ? true : false,
                      ),
                      SizedBox(height: 20)
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
