import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/data/auth_service.dart';
import 'package:masalriyadh/core/services/register_services.dart';
import 'package:masalriyadh/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:masalriyadh/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginCubit(authService: getIt.get<AuthService>()),
      child: const LoginViewBody(),
    ));
  }
}
