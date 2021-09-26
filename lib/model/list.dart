import 'package:cloud_firestore/cloud_firestore.dart';

class List {
  List(this.id, this.title, this.content, this.createdTime, this.completedTime, this.isDone);

  String id;
  String title;
  String content;
  Timestamp createdTime;
  Timestamp completedTime;
  bool isDone;

}