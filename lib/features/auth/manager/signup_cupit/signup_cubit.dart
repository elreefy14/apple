import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masalriyadh/core/services/data/auth_service.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/customer_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.authService}) : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  final AuthService authService;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isSecure = true;
  iconToggle(){
    isSecure = !isSecure;
    emit(IconToggle());
  }
  signUp() async {
    CustomerModel customer = CustomerModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username:
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );
    emit(SignupLoading());
    try {
      final response = await authService.signUp(customer);
      if (!response) {
        emit(SignupError(error: 'error'));
      }
      emit(SignupSuccess());
    } catch (e) {
      if (e is DioException) {
        print('---------------------------------------');
        emit(SignupError(error: e.response?.data['message']));
      } else {
        emit(SignupError(error: e.toString()));
      }
    }
  }
}
