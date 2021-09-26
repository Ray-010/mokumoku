import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/measure_study/review_model.dart';
import 'package:study_with_us_test/pages/measure_study/timer_model.dart';
import 'package:study_with_us_test/root.dart';
import 'package:study_with_us_test/utils/firebase.dart';

class Review extends StatelessWidget {
  Review({required this.myUid,required this.setTime});
  final myUid;
  final setTime;

  int concentration = 3;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '振り返り',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.0,),
          Text(
            '勉強時間'
          ),
          Text(
            myUid,
          ),
          Text(
            setTime.toString(),
          ),
          
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ReviewModel>(create: (_) =>ReviewModel()),
              ChangeNotifierProvider<IndividualTimerProvider>(create: (_) =>IndividualTimerProvider()),
            ],
            child: Column(
              children: [
                Consumer<ReviewModel>(
                  builder: (context, model, child) {
                    return Column(
                      children: [
                        Text(
                          '集中できましたか?',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                                    icon: Icon(
                                      Icons.sentiment_very_satisfied_outlined,
                                      color: model.great ? Colors.blue : Colors.blue[100],
                                    ),
                                    onPressed: () {
                                      concentration = 3;
                                      model.checkedGreat();
                                    },
                                  ),
                                  Text('Great'),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                                    icon: Icon(
                                      Icons.sentiment_satisfied_outlined,
                                      color: model.good ? Colors.blue : Colors.blue[100],
                                    ),
                                    onPressed: (){
                                      concentration = 2;
                                      model.checkedGood();
                                    },
                                  ),
                                  Text('Good'),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                                    icon: Icon(
                                      Icons.sentiment_neutral_outlined,
                                      color: model.fine ? Colors.blue : Colors.blue[100],
                                    ),
                                    onPressed: (){
                                      concentration = 1;
                                      model.checkedFine();
                                    },
                                  ),
                                  Text('Fine'),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                                    icon: Icon(
                                      Icons.sentiment_very_dissatisfied_outlined,
                                      color: model.bad ? Colors.blue : Colors.blue[100],
                                    ),
                                    onPressed: (){
                                      concentration = 0;
                                      model.checkedBad();
                                    },
                                  ),
                                  Text('Bad'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                ),

                SizedBox(height: 40.0,),
                // 勉強記録ボタン
                Consumer<IndividualTimerProvider>(
                  builder: (context, model, child) {
                    return Container(
                      height: 40.0,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          )
                        ),
                        child: Text(
                          '記録する',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: (){
                          // 記録保存処理
                          Firestore.keepRecordStudyTime(myUid, setTime, 'その他', concentration).then((_) {
                            model.backToTop();
                            // Navigator.pop(context); // timerが作動していないのにdisposeでキャンセルするのでエラーを吐く
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
                          });
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}