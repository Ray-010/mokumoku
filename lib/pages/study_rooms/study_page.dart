import 'package:flutter/material.dart';
import 'package:study_with_us_test/model/user.dart';
import 'package:study_with_us_test/utils/firebase.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';


// 勉強部屋に入った後の画面 実際の勉強部屋
class StudyPage extends StatefulWidget {
  final String title;
  final DateTime finishedTime;
  final String members;
  final String documentId;
  final String myUid;

  StudyPage(this.title, this.finishedTime, this.members, this.documentId, this.myUid);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {

  List inRoomUserList = [];
  int inRoomUserNum = 0;
  Future<void> createUsers() async {
    inRoomUserList = await Firestore.getUsers(widget.documentId, widget.myUid, inRoomUserList);
    inRoomUserNum = inRoomUserList.length;
    print('createUsers');
  }
  late UserProfileModel userInfo;
  Future<void> getMyUid() async{
    userInfo = await Firestore.getProfile(widget.myUid);
    print('getMyUid done');
  }
  
  @override
  Future<void> dispose() async {
    String myUid = SharedPrefs.getUid();
    Firestore.getOutRoom(widget.documentId, myUid);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('『' + widget.title + '』部屋'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getMyUid(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // アイコン画像
                    Container(
                      child:  CircleAvatar(
                        // backgroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.blue,
                        radius: 53,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userInfo.imagePath),
                          radius: 50,
                        ),
                      ),
                    ),
                    // アイコン右ユーザ詳細
                    Container(
                      // color: Colors.indigo,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 名前
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userInfo.name,
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
                          // いいね数
                          Padding( 
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                ),
                                Text(
                                  userInfo.favorite.toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              );
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
          ),
          
          // 部屋に入っているユーザー表示
          StreamBuilder(
            stream: Firestore.roomRef.doc(widget.documentId).collection('users').snapshots(),
            builder: (context, snapshot) {
              return FutureBuilder(
                future: createUsers(),
                builder: (context, snapshot) {
                  // if(snapshot.connectionState == ConnectionState.done) {
                    return Flexible(
                      child: Column(
                        children: [
                          // 部屋の人数
                          Text(
                            inRoomUserNum.toString() + '人があなたと一緒に勉強しています。',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          // AnimatedSwitcher, これではできない。再読み込みではなく、animatedListのようなlistで管理しなければanimationができないと思われる。
                          // duration: Duration(milliseconds: 5000),
                          //   key: ValueKey<int>(inRoomUserList.length),
                          //   transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(
                          //     child: child, 
                          //     scale: animation), // .drive(Tween<double>(begin: 0.2, end: 1),)
                          Flexible(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4
                              ),
                              itemCount: inRoomUserList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // いいね処理
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 37,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(inRoomUserList[index].imagePath),
                                          radius: 35,
                                        ),
                                      ),
                                      Text(
                                        inRoomUserList[index].name,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    );
                  // } else {
                  //   return Center(child: CircularProgressIndicator(),);
                  // }
                },
              );
            }
          ),
        ],
      ),
    );
  }
}