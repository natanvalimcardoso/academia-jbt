// import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:optimized_time/app/modules/register/register_page.dart';
import 'package:optimized_time/app/modules/register/widgets/input_widget.dart';
import 'package:validatorless/validatorless.dart';

import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      bloc: widget.controller,
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
                  Color.fromARGB(255, 254, 254, 254),
                  Color.fromARGB(255, 254, 254, 254),
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
                      key: widget.controller.formKeyLogin,
                      child: Column(
                        children: [
                          InputWidget(
                            labelText: 'Seu Email',
                            keyboard: TextInputType.text,
                            controller: widget.controller.emailController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('O campo de email é obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          InputWidget(
                            labelText: 'Sua Senha',
                            controller: widget.controller.passwordController,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('O campo de senha é obrigatório'),
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
                          if (widget.controller.formKeyLogin.currentState!.validate()) {
                            widget.controller.login(
                              widget.controller.emailController.text,
                              widget.controller.passwordController.text,
                              context,
                            );
                            setState(() {
                              widget.controller.isLoaded = true;
                            });
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                widget.controller.isLoaded = false;
                              });
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        child: widget.controller.isLoaded == false
                            ? const Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const CircularProgressIndicator()),
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
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  BlocSelector<LoginController, LoginState, bool>(
                    bloc: widget.controller,
                    selector: (state) => state.status == LoginStatus.loading,
                    builder: (context, show) {
                      return Visibility(
                        visible: show,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.purple,
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
