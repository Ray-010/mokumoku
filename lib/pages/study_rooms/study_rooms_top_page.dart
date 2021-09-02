import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_us_test/pages/study_rooms/add_study_room.dart';
import 'package:study_with_us_test/pages/study_rooms/study_page.dart';
import 'package:study_with_us_test/utils/firebase.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';


// 勉強部屋一覧画面
class StudyRooms extends StatefulWidget {
  @override
  _StudyRoomsState createState() => _StudyRoomsState();
}

class _StudyRoomsState extends State<StudyRooms> {
  final _formKey = GlobalKey<FormState>();

  final Stream<QuerySnapshot> _roomsStream = FirebaseFirestore.instance.collection('rooms').orderBy('finishedTime', descending: true).snapshots();

  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // タイマーが終了してから30分後には全て削除
  Future<void> batchDelete() {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return rooms.get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        var finished = document['finishedTime'].toDate().add(Duration(minutes: 30));
        var now = DateTime.now();
        var time = finished.difference(now).inSeconds;
        if (time <= 0) {
          batch.delete(document.reference);
        }
      });

      return batch.commit();
    });
  }

  @override
  void initState() {
    batchDelete();
    super.initState();
  }

  // 時間が終了しているかいなか
  bool roomIn = true;

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

                // プラスボタン ここから部屋を新しく作れる
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

                      // 終了後に新たに入れないようにする
                      var finished = data['finishedTime'].toDate();
                      var now = DateTime.now();
                      var time = finished.difference(now).inSeconds;
                      if (time <= 0) {
                        // 終了済み ＝ 入れない
                        roomIn = false;
                        Firestore.updateRoomIn(document.id, roomIn);
                      } else {
                        roomIn = true;
                      }

                      return Card(
                          child: ListTile(
                            tileColor: data['roomIn'] ? Colors.white : Colors.black12,
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
                                  decoration: data['roomIn'] ? TextDecoration.none : TextDecoration.lineThrough,
                                  color: data['roomIn'] ? Colors.black : Colors.black38,
                                  fontSize: 24,
                                ),
                              ),
                            ),

                            // 時間表示
                            subtitle: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    (DateFormat("HH:mm").format(data['createdTime'].toDate().add(Duration(hours: 9))).toString()) + "~" +
                                        (DateFormat("HH:mm").format(data['finishedTime'].toDate().add(Duration(hours: 9))).toString())
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
                                data['members'] + '名',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            onTap: (){
                              // roomInがTrueであれば入ることができる
                              if (data['roomIn']) {
                                // 部屋に入る人をrooms>usersにセットする
                                final myUid = SharedPrefs.getUid();
                                Firestore.addUsers(document.id, myUid);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => StudyPage(data['title'], data['finishedTime'].toDate(), data['members'], document.id, myUid),
                                ));
                              }
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

                      // 終了後に新たに入れないようにする
                      var finished = data['finishedTime'].toDate();
                      var now = DateTime.now();
                      var time = finished.difference(now).inSeconds;
                      if (time <= 0) {
                        // 終了済み ＝ 入れない
                        roomIn = false;
                        Firestore.updateRoomIn(document.id, roomIn);
                      } else {
                        roomIn = true;
                      }

                      return Card(
                        child: ListTile(
                          tileColor: data['roomIn'] ? Colors.white : Colors.black12,
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
                                decoration: data['roomIn'] ? TextDecoration.none : TextDecoration.lineThrough,
                                color: data['roomIn'] ? Colors.black : Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  (DateFormat("HH:mm").format(data['createdTime'].toDate().add(Duration(hours: 9))).toString()) + "~" +
                                      (DateFormat("HH:mm").format(data['finishedTime'].toDate().add(Duration(hours: 9))).toString())
                              ),
                            ),
                          ),
                          // trailing: Icon(Icons.more_vert),
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
                                          if (data['roomIn']) {
                                            if (_formKey.currentState!.validate()) {
                                              final myUid = SharedPrefs.getUid();
                                              await Firestore.addUsers(document.id, myUid);
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => StudyPage(data['title'], data['finishedTime'].toDate(), data['members'], document.id, myUid),
                                              ));
                                            }
                                          }
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