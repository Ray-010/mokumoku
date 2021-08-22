import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // ここで設定ページに移動
              },
            ),
          ),
        ],
        title: Text('プロフィール'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
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
                                'ふくろー',
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
              Text('GitHub 草生やす'),
            ],
          ),
        ),
      ),
    );
  }
}