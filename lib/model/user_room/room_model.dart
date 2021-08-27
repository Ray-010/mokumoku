import 'package:cloud_firestore/cloud_firestore.dart';

/*
勉強部屋に必要なもの
部屋のID -> id
Room名 -> title
何人入っているか -> members (intに変換してから加算)
勉強時間 -> studyTime (intに変換してから加算)
作った時の時間 -> createdTime
勉強し終わったときの未来の時間 -> finishedTime (studyTime + createdTime)
（出来たら）タグ -> tags
 */

class Room {
  Room(this.id, this.title, this.members, this.createdTime, this.finishedTime, this.studyTime, this.roomIn);

  String id;
  String title;
  String members;
  String studyTime;
  Timestamp createdTime;
  Timestamp finishedTime;
  bool roomIn;
}

class roomUser {
  /*

  name
  image
  time
  good
  id

   */
}