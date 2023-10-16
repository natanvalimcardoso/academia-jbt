// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimized_time/app/modules/register/widgets/input_widget.dart';
import 'package:validatorless/validatorless.dart';

import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.05,
          left: size.width * 0.04,
          right: size.width * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.04,
                ),
                child: Form(
                  key: controller.formKeyRegister,
                  child: Column(
                    children: [
                      InputWidget(
                        labelText: 'Nome completo',
                        keyboard: TextInputType.text,
                        controller: controller.nameController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'O campo de nome é obrigatório'),
                            Validatorless.min(
                                6, 'O nome deve ter no mínimo 6 caracteres'),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      InputWidget(
                        labelText: 'E-mail',
                        keyboard: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'O campo de email é obrigatório'),
                            Validatorless.email('E-mail inválido'),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      InputWidget(
                        labelText: 'Confirme seu e-mail',
                        keyboard: TextInputType.emailAddress,
                        controller: controller.emailConfirmController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'O campo de email é obrigatório'),
                            Validatorless.email('E-mail inválido'),
                            Validatorless.compare(
                              controller.emailController,
                              'Os e-mails não coincidem',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      InputWidget(
                        labelText: 'Senha',
                        keyboard: TextInputType.visiblePassword,
                        controller: controller.passwordController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'O campo de senha é obrigatório'),
                            Validatorless.min(
                                6, 'A senha deve ter no mínimo 6 caracteres'),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      InputWidget(
                        labelText: 'Confirme sua senha',
                        isLastInput: true,
                        keyboard: TextInputType.visiblePassword,
                        controller: controller.passwordConfirmController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'O campo de senha é obrigatório'),
                            Validatorless.min(
                                6, 'A senha deve ter no mínimo 6 caracteres'),
                            Validatorless.compare(
                              controller.passwordController,
                              'As senhas não coincidem',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.04,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.formKeyRegister.currentState!.validate()) {
                      controller.register(
                        controller.emailController.text,
                        controller.passwordController.text,
                        context,
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
