import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  // final FirebaseAuth auth = FirebaseAuth.instance;
  

  // SignUp
  static Future signUp(String email, uid) async {
    _firestoreInstance.collection('users').doc(uid).set({
      'name': 'ゲスト',
      'imagePath': 'imagePath',
      'email': email,
      'createdAt': Timestamp.now(),
    });
  }

  // Sign in User


  // Reset Password



  // Sign Out


  // get user information
  // static Future<User> getUserProfile(String uid) async {
  //   try {

  //   } catch(e) {
  //     print('取得失敗 --- $e');
  //     return null;
  //   }
  // }


}