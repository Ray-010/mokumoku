import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_us_test/pages/study_rooms/add_study_room.dart';
import 'package:study_with_us_test/pages/study_rooms/practice_study_page.dart';
import 'package:study_with_us_test/pages/study_rooms/study_page.dart';


// 勉強部屋一覧画面
class StudyRoomsPractice extends StatefulWidget {
  @override
  _StudyRoomsPracticeState createState() => _StudyRoomsPracticeState();
}

class _StudyRoomsPracticeState extends State<StudyRoomsPractice> {
  final _formKey = GlobalKey<FormState>();

  final Stream<QuerySnapshot> _roomsStream = FirebaseFirestore.instance.collection('room2').snapshots();

  CollectionReference rooms = FirebaseFirestore.instance.collection('room2');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // rooms > 部屋のドキュメント > 値・usersのコレクション
  Future<void> addUsers(roomDocumentId, userDocumentId){
    return rooms
        .doc(roomDocumentId)
        .collection('users')
        .doc(userDocumentId)
        .set({'inTime': Timestamp.now(), 'name': 'test', 'good': '0'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _roomsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  // IconButton(
                  //   icon: const Icon(Icons.search),
                  //   onPressed: () {
                  //
                  //   },
                  // ),

                  // プラスボタン　ここから部屋を新しく作れる
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddStudyRoomPage(),
                          fullscreenDialog: true,
                        ));
                      },
                    ),
                  ),
                ],

                // タブバー
                bottom: TabBar(
                  tabs: [
                    Tab(
                      // icon: Icon(Icons.android),
                      text: "ゆるゆる",
                    ),
                    Tab(
                      // icon: Icon(Icons.phone_iphone),
                      text: "つよつよ",
                    ),
                  ],
                ),
                title: Text('勉強部屋'),
              ),
              body: TabBarView(
                children: [
                  Center(
                    // ゆるゆる部屋
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                        return Card(
                          child: ListTile(

                            // 部屋のタイトル
                            title: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0, // Underline thickness
                                  ))
                              ),
                              child: Text(
                                data['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),

                            // 何人入っているか
                            trailing: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width / 5,
                              height: 50,
                              child: Text(
                                data['members'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            onTap: (){
                              // 部屋に入る人をrooms>usersにセットする
                              addUsers(document.id, 'gt5ZarnI57RmGqsiMQxi1msjqxp2');

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => StudyPagePractice(data['title'], data['members'], document.id),
                              ));
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Center(
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                        return Card(
                          child: ListTile(
                            // leading: FlutterLogo(size: 56.0),
                            title: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0, // Underline thickness
                                  ))
                              ),
                              child: Text(
                                data['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                data['members'] + '名',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            onTap: (){
                              // つよつよ部屋に入れるのは目標を宣言した場合のみ
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return Form(
                                    key: _formKey,
                                    child: AlertDialog(
                                      title: Text('『' + data['title'] + '』部屋'),
                                      content: TextFormField(
                                        autofocus: true,
                                        maxLines: 5,
                                        // controller: titleController,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "例：テキスト１ページ終わらせる！",
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '目標を記入してください';
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("キャンセル"),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: Text("入室する"),
                                          onPressed: () async {
                                            addUsers(document.id, 'gt5ZarnI57RmGqsiMQxi1msjqxp2');
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => StudyPagePractice(data['title'], data['members'], document.id),
                                            ));
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }).toList(),
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