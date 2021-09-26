
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/utils/firebase.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class RegisterModel extends ChangeNotifier {
  
  String? email;
  String? password;
  bool pswdOK = false;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
  void setPassword(String password) {
    this.password = password;
    if(password.length >= 8){
      pswdOK = true;
    } else {
      pswdOK = false;
    }
    notifyListeners();
  }

  Future signUp() async {
    if(email != null && password != null) {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;
      if(user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'name': 'ゲスト',
          'imagePath': 'https://www.silhouette-illust.com/wp-content/uploads/2017/10/jinbutsu_male_40219-300x300.jpg',
          'email': email,
          'favorite': 0,
          'createdAt': Timestamp.now(),
        });
      }
    }
  }
}