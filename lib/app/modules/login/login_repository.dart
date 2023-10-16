import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Modular.to.pushReplacementNamed('/home');
      return credential.user;
    } on FirebaseAuthException {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Email ou senha incorretos'),
            actions: [
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }
}
