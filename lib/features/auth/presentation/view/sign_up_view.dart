import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/register_services.dart';

import '../../../../core/services/data/auth_service.dart';
import '../../manager/signup_cupit/signup_cubit.dart';
import '../widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupCubit(
          authService:  getIt.get<AuthService>(),
        ),
        child: const SignUpViewBody(),
      ),
    );
  }
}
