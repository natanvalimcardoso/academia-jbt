import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class RegisterRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerApp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Modular.to.navigate('/login/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await Get.dialog(
          CupertinoAlertDialog(
            title: const Text('Alerta!'),
            content: const Text('Este e-mail já está em uso!'),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else if (e.code == 'invalid-email') {
        await Get.dialog(
          CupertinoAlertDialog(
            title: const Text('Alerta!'),
            content: const Text('Este e-mail é inválido!'),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else if (e.code == 'operation-not-allowed') {
        await Get.dialog(
          CupertinoAlertDialog(
            title: const Text('Alerta!'),
            content: const Text('Operação não permitida!'),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        await Get.dialog(
          CupertinoAlertDialog(
            title: const Text('Alerta!'),
            content: const Text('ocorreu um  erro desconhecido!'),
            actions: [
              CupertinoDialogAction(
                onPressed: Get.back,
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }
}
