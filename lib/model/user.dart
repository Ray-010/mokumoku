import 'package:cloud_firestore/cloud_firestore.dart';

class UserSignUpModel {
  String name;
  String email;
  String imagePath;
  int favorite;
  Timestamp createdAt;

  UserSignUpModel({required this.name, required this.email, required this.imagePath, required this.favorite, required this.createdAt});
}

class UserProfileModel {
  String name;
  String imagePath;
  String uid;
  int favorite;

  UserProfileModel({required this.name, required this.imagePath, required this.uid, required this.favorite});
}