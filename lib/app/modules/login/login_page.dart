// import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:optimized_time/app/modules/register/register_page.dart';
import 'package:optimized_time/app/modules/register/widgets/input_widget.dart';
import 'package:validatorless/validatorless.dart';

import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ?? 'Error when logging';
          print(message);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8A2BE2),
                  Color(0xFF7B68EE),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/man.json'),
                  Lottie.asset(
                    'assets/images/freela.json',
                    height: screenSize.height * .2,
                  ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: controller.formKeyLogin,
                      child: Column(
                        children: [
                          InputWidget(
                            labelText: 'Seu Email',
                            keyboard: TextInputType.text,
                            controller: controller.emailController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'O campo de email é obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          InputWidget(
                            labelText: 'Sua Senha',
                            controller: controller.passwordController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required(
                                    'O campo de senha é obrigatório'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  SizedBox(
                    height: 49,
                    width: screenSize.width * .3,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.formKeyLogin.currentState!.validate()) {
                          controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  SizedBox(
                    height: 49,
                    width: screenSize.width * .3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  BlocSelector<LoginController, LoginState, bool>(
                    bloc: controller,
                    selector: (state) => state.status == LoginStatus.loading,
                    builder: (context, show) {
                      return Visibility(
                        visible: show,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
