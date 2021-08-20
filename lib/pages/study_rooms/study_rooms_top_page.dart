import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/study_rooms/add_study_room.dart';

class StudyRooms extends StatefulWidget {
  @override
  _StudyRoomsState createState() => _StudyRoomsState();
}

class _StudyRoomsState extends State<StudyRooms> {
  final _formKey = GlobalKey<FormState>();

  var tab;

  void changeTab(int num) {
    tab = num;
  }

  @override
  Widget build(BuildContext context) {
    var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ",];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
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
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= list.length) {
                    list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
                  }
                  return _messageItem(list[index], DefaultTabController.of(context)!.index);
                },
              )
            ),

            Center(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= list.length) {
                    list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
                  }
                  return _messageItem(list[index], DefaultTabController.of(context)!.index);
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageItem(String title, int tab) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          if (tab == 0) {
            // ゆるゆる
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ゆるゆる部屋に入室したよ！')),
            );
          } else if (tab == 1){
            // つよつよ
            showConfirmDialog();
          }
        },
        onLongPress: () {
          print("onLongTap called.");
        },
      ),
    );
  }

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text("『Room名』部屋"),
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
                  if (_formKey.currentState!.validate()) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('つよつよ部屋に入室したよ！'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // 作った部屋に自動的に移動する
                    Navigator.pop(context); // とりあえず今は戻るようにしてる
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}