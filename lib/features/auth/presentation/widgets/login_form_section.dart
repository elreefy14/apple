import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/constants/colors.dart';

import '../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
          key: cubit.formKey,
          autovalidateMode: cubit.autoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                label: 'البريد الالكتروني',
                icon: Icons.email,
                controller: cubit.emailController,
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
                // تأكد إن maxLines بواحد

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
              ),
            ],
          ),
        );
      },
    );
  }
}
