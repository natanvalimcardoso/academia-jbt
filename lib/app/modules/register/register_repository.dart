import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class RegisterRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerApp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _firebaseAuth.currentUser?.updateDisplayName(name);
        await _firebaseAuth.signOut();
        await Get.dialog(
          CupertinoAlertDialog(
            title: const Text('Sucesso!'),
            content: const Text('Usuário cadastrado com sucesso!'),
            actions: [
              CupertinoDialogAction(
                onPressed: () async {
                  await Get.offAllNamed('/login');
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
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
