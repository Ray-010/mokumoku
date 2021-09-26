import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();


  String? email;
  String? password;
  bool pswdOK = false;
  bool remember = false;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }


  // ログイン
  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if(email != null && password != null) {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;
    }
  }
}