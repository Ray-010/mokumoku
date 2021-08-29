import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_with_us_test/model/user.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final userRef = _firestoreInstance.collection('users');

  // final FirebaseAuth auth = FirebaseAuth.instance;
  

  // SignUp
  static Future signUp(String email, uid) async {
    _firestoreInstance.collection('users').doc(uid).set({
      'name': 'ゲスト',
      'imagePath': 'imagePath',
      'email': email,
      'createdAt': Timestamp.now(),
    });
    await SharedPrefs.setUid(uid); // 端末保存
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

  // ユーザ情報取得
  static Future<UserProfileModel> getProfile(String uid) async {
    final profile = await userRef.doc(uid).get();
    UserProfileModel myProfile = UserProfileModel(
      name: profile.data()?['name'], 
      imagePath: profile.data()?['imagePath'], 
      uid: uid,
    );
    return myProfile;
  }
}