import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/study_rooms/add_study_room.dart';

class StudyRooms extends StatefulWidget {
  @override
  _StudyRoomsState createState() => _StudyRoomsState();
}

class _StudyRoomsState extends State<StudyRooms> {
  @override
  Widget build(BuildContext context) {
    var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ",];
    return MaterialApp(
        home: Scaffold(
            appBar:AppBar(
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
              title: Text(
                '勉強部屋',
              ),
              elevation: 0.0,
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index >= list.length) {
                  list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
                }
                return _messageItem(list[index]);
              },
            )
        )
    );
  }

  Widget _messageItem(String title) {
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
          showConfirmDialog();
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }

  Future showConfirmDialog(
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
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
                return 'Room名を入力';
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
                // ここでその部屋に入る
                Navigator.pop(context); // 今はとりあえず戻っている
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('入室したよ！'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}