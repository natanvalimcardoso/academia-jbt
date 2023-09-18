import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Modular.to.pushReplacementNamed('/home');
      return credential.user;
    } on FirebaseAuthException {
      return await Get.dialog(
        CupertinoAlertDialog(
          title: const Text('Alerta!'),
          content: const Text('E-mail inválido'),
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
