import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/features/auth/manager/signup_cupit/signup_cubit.dart';
import 'package:masalriyadh/features/auth/manager/signup_cupit/signup_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SignUpFormSection extends StatelessWidget {
  const SignUpFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SignupCubit.get(context);
        return Form(
          key: cubit.formKey,
          autovalidateMode: cubit.autoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                label: 'الاسم الاول',
                icon: Icons.person,
                controller: cubit.firstNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: 'الاسم الاخير',
                icon: Icons.person,
                controller: cubit.lastNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: 'البريد الالكتروني',
                icon: Icons.email,
                controller: cubit.emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: 'رقم الجوال',
                icon: Icons.phone,
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل رقم الجوال';
                  } else if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                    return 'يجب أن يبدأ رقم الجوال بـ 05 ويكون مكونًا من 10 أرقام';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: 'كلمة المرور',
                icon: Icons.lock,
                controller: cubit.passwordController,
                obscureText: cubit.isSecure,
                maxLines: 1,
                // لازم يكون 1 عشان الحقل Password
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.iconToggle();
                  },
                  icon: cubit.isSecure
                      ? Icon(
                          Icons.visibility_off_sharp,
                          color: AppColors.primaryColor.withOpacity(.6),
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                          color: AppColors.primaryColor,
                        ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال كلمة المرور';
                  } else if (value.length < 6) {
                    return 'يجب أن تتكون كلمة المرور من 6 أحرف أو أرقام على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: 'تاكيد كلمة المرور',
                icon: Icons.lock,
                controller: cubit.confirmPasswordController,
                obscureText: cubit.isSecure,
                maxLines: 1,
                // لازم يكون 1 عشان الحقل Password
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.iconToggle();
                  },
                  icon: cubit.isSecure
                      ? Icon(
                    Icons.visibility_off_sharp,
                    color: AppColors.primaryColor.withOpacity(.6),
                  )
                      : const Icon(
                    Icons.remove_red_eye,
                    color: AppColors.primaryColor,
                  ),
                ),
                validator: (value) {
                  if (value != cubit.passwordController.text) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
