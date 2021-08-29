import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/model/user.dart';
import 'package:study_with_us_test/pages/user_profile/user_setting_page.dart';
import 'package:study_with_us_test/utils/firebase.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';


class UserProfile extends StatefulWidget {

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProfileModel userInfo;

  Future<void> getMyUid() async{
    String myUid = SharedPrefs.getUid();
    userInfo = await Firestore.getProfile(myUid);
    print('getMyUid done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title: Text('プロフィール'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => UserSetting()));
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getMyUid(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          if(snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // プロフィール
                Container(
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
                            backgroundImage: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
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
                                  Text('100')
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                Text('GitHub 草生やす'),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
