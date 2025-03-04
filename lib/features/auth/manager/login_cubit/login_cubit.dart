import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/models/login_response_model.dart';
import '../../../../core/services/data/auth_service.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authService,
  }) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final AuthService authService;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;

  iconToggle() {
    isSecure = !isSecure;
    emit(IconToggle());
  }
  void login() async {
    try {
      emit(LoginLoading());

      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        emit(LoginError(message: 'Please enter email and password.'));
        return;
      }

      var response = await Dio().post(
        'https://masalriyadh.com/wp-json/jwt-auth/v1/token',
        data: {
          "username": emailController.text,
          "password": passwordController.text,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        var loginResponseModel = LoginResponseModel.fromJson(response.data);
              await SharedHelper.set(
                key: SharedKeys.token,
                value: loginResponseModel.token,
              );
              print(SharedHelper.get(key: SharedKeys.token));
              await SharedHelper.set(
                key: SharedKeys.userEmail,
                value: loginResponseModel.userEmail,
              );
              await SharedHelper.set(
                key: SharedKeys.userName,
                value: loginResponseModel.userDisplayName,
              );
        emit(LoginSuccess());
      } else if (response.statusCode == 403) {
        // فحص محتوى الاستجابة إذا كان فيها كود خطأ معين
        String errorMessage = response.data['message'] ?? 'Access Denied: Incorrect credentials.';
        emit(LoginError(message: errorMessage));
      } else {
        emit(LoginError(message: 'Login failed. Please try again.'));
      }
    } catch (e) {
      emit(LoginError(message: 'An unexpected error occurred: ${e.toString()}'));
    }


  // void login() async {
  //   emit(LoginLoading());
  //
  //   var result = await authService.login(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  //   if (result.statusCode == 200) {
  //     emit(LoginSuccess());
  //   } else {
  //     emit(LoginError(message: 'Invalid email or password'));
  //   }
    //     .then(
    //   (value) {
    //     emit(LoginSuccess());
    //   },
    // ).catchError((e) {
    //   if (e is DioException) {
    //     if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
    //       emit(LoginError(message: 'Invalid email or password'));
    //     }
    //   }
    //   emit(LoginError(message: e.toString()));
    // });
  }
}
