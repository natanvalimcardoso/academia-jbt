// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerApp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Modular.to.pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Email já cadastrado'),
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
      } else if (e.code == 'invalid-email') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Email inválido'),
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
      } else if (e.code == 'operation-not-allowed') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Operação não permitida'),
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
      } else {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Erro desconhecido'),
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
}
