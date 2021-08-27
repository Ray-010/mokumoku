import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// 勉強部屋に入った後の画面　実際の勉強部屋
class StudyPage extends StatefulWidget {
  final String title;
  final DateTime finishedTime;
  final String members;
  final String documentId;

  StudyPage(this.title, this.finishedTime, this.members, this.documentId);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  // タイマーの表示に使う
  String _time = '';

  // タイマーがゼロになったかどうか
  bool timerfinish = false;

  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

  // 人数を更新する
  Future<void> updatePlusMembers(int before) {
    return rooms
        .doc(widget.documentId)
        .update({'members': (before+1).toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );

    // 部屋に入ってきたときに人数を更新
    updatePlusMembers(int.parse(widget.members));
    super.initState();
  }

  // タイマーの処理
  void _onTimer(Timer timer) {
    var now = DateTime.now();
    // a.difference(now).inHours
    var time = widget.finishedTime.difference(now).inSeconds;

    if (time <= 0){
      // タイマーがゼロになったとき
      // タイマーが終わったときに音を鳴らす＆通知機能を付けたい
      setState(() {
        _time = '終了！！';
        timerfinish = true;
      });
    } else {
      // タイマーの表示
      String hour = (time / (60 * 60)).floor().toString().padLeft(2, "0");
      var mod = time % (60 * 60);
      String min = (mod / 60).floor().toString().padLeft(2, "0");
      String sec = (mod % 60).toString().padLeft(2, "0");

      setState(() => _time = '$hour時間$min分$sec秒');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(timerfinish ? '' : 'のこり'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                            color: Colors.grey,
                            width: 10.0, // Underline thickness
                          ))
                      ),
                      child: Text(
                        _time,
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
            timerfinish ? ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('記録する'),
            ) : ElevatedButton(
              onPressed: () {
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
                  children: List.generate(100, (index) {
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
                                  Text('User'),
                                  Text(
                                    'Meeage $index',
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('いいねを押しました')),
                              );
                              },
                            )
                        )
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}