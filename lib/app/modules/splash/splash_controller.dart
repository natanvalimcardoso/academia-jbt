import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';


class FetchDataController {
  // ignore: cancel_subscriptions
  StreamSubscription? subscription;

  Future<void> redirectPage() async {
   subscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Modular.to.navigate('/login/');
      } else {
        Modular.to.navigate('/home/');
      }
    });
  }
}