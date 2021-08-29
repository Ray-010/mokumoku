import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// 勉強部屋に入った後の画面　実際の勉強部屋
class StudyPagePractice extends StatefulWidget {
  final String title;
  final String members;
  final String documentId;

  StudyPagePractice(this.title, this.members, this.documentId);

  @override
  _StudyPagePracticeState createState() => _StudyPagePracticeState();
}

class _StudyPagePracticeState extends State<StudyPagePractice> {
  CollectionReference rooms = FirebaseFirestore.instance.collection('room2');

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final Stream<QuerySnapshot> _roomsStream = FirebaseFirestore.instance.collection('room2').snapshots();

  // rooms > 部屋のドキュメント > 値・usersのコレクション
  Future<void> deleteUsers(roomDocumentId, userDocumentId){
    return rooms
        .doc(roomDocumentId)
        .collection('users')
        .doc(userDocumentId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  
  Future<void> updateGood(userDocumentId, goodCount){
    return rooms
        .doc(widget.documentId)
        .collection('users')
        .doc(userDocumentId)
        .update({'good': (goodCount+1).toString()})
        .then((value) => print("Good Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // 人数を更新する
  Future<void> updatePlusMembers(int before) {
    return rooms
        .doc(widget.documentId)
        .update({'members': (before+1).toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> test(){
    return users.get() .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
      });
    });
  }

  @override
  void initState() {
    // 部屋に入ってきたときに人数を更新
    updatePlusMembers(int.parse(widget.members));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: rooms.doc(widget.documentId).collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('『' + widget.title + '』部屋'),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                children: [

                  // タイマーの記述
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 10.0, // Underline thickness
                                ))
                            ),
                            child: Text(
                              'test',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // とりあえずのプロフィール部分　自分の情報を入れておきたい
                  Container(
                    // color: Colors.pink[100], // 確認用
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container( // アイコン画像
                              // color: Colors.green[100], // 確認用
                              child:  ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                        ),

                        Expanded(
                          flex: 2,
                          child: Container( // 個人プロフィール
                            padding: EdgeInsets.all(16.0),
                            // color: Colors.blue, // 確認用
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding( // 名前
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'プロフ例',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding( // 総勉強時間
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '総勉強時間: ',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '10',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' 時間',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                Padding( // いいね数
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      ),
                                      Text('100')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // ボタン
                  ElevatedButton(
                    onPressed: () {
                      deleteUsers(widget.documentId, 'gt5ZarnI57RmGqsiMQxi1msjqxp2');
                      Navigator.pop(context);
                    },
                    child: Text('戻る'),
                  ),

                  // 他の部屋に入っているユーザー表示部分
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 3, // 1行に表示する数
                        crossAxisSpacing: 4.0, // 縦スペース
                        mainAxisSpacing: 4.0, // 横スペース
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          test();

                          return Container(
                            // padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                              ),
                              child:GridTile(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(data['name']),
                                        Text(
                                          //users.doc(document.id).get().
                                          data['good'],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // いいね部分
                                  footer: IconButton(
                                    alignment: Alignment.bottomRight,
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.pink,
                                    ),
                                    onPressed: (){
                                      print(data['good']);
                                      print(document.id);
                                      updateGood(document.id, int.parse(data['good']));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('いいねを押しました')),
                                      );
                                    },
                                  )
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}