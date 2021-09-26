import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class FirebaseList {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');

  final myUid = SharedPrefs.getUid();

  // 指定されたListの削除
  static Future<void> deleteList(documentId, userId) {
    return users
        .doc(userId)
        .collection('lists')
        .doc(documentId)
        .delete()
        .then((value) => print("List Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // 指定されたListが達成された
  static Future<void> updateCompleteListTrue(documentId, userId) {
    return users
        .doc(userId)
        .collection('lists')
        .doc(documentId)
        .update({
          'isDone': true,
          'completedTime': Timestamp.now()
        })
        .then((value) => print("目標を達成しました"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> updateCompleteListFalse(documentId, userId) {
    return users
        .doc(userId)
        .collection('lists')
        .doc(documentId)
        .update({
      'isDone': false,
      'completedTime': Timestamp.now()
    })
        .then((value) => print("達成を取り消しました"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // 削除するかチェックする
  static Future showConfirmDialog(
      BuildContext context,
      String documentId,
      String userId,
      String title,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${title}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("キャンセル"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("削除"),
              onPressed: () async {
                // modelで削除
                await deleteList(documentId, userId);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}