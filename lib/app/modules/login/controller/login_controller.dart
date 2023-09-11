import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimized_time/app/modules/login/login_repository.dart';
import 'package:optimized_time/app/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();

  LoginController({
    required AuthService authService,
  })  : _authService = authService,
        super(const LoginState.initial());

  final AuthService _authService;

  final LoginRepository repository = LoginRepository();

  Future<void> login(
    String email,
    String password,
  ) async {
    await repository.loginWithEmail(
      emailController.toString(),
      passwordController.toString(),
    );
  }

  Future<void> signIn() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authService.signIn();
    } catch (e, s) {
      developer.log('Error when signing in', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Error when logging in',
        ),
      );
    }
  }
}
