/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> login() async {}

Future<bool> register(String fullname, String email, String username, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;

  } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak. ');

      } else if (e.code == 'email-already-in-use') {
        print('The account already exist for that email.');
      }
      return false;

  } catch (e) {
    print(e.toString());
    return false;
  }
}
 */

