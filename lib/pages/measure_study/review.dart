import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/measure_study/review_model.dart';

class Review extends StatelessWidget {

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
          // Text(
          //   '勉強時間'
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Icon(
          //         Icons.warning_amber_rounded,
          //         size: 30,
          //       ),
          //     ),
          //     Expanded(
          //       flex: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           '記録する場合は必ず一番下にある「記録する」ボタンを押してください',
          //           style: TextStyle(
          //             color: Colors.red,
          //             fontSize: 14.0,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ChangeNotifierProvider<ReviewModel>(
            create: (_) => ReviewModel(),
            child: Consumer<ReviewModel>(
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
                                  model.checkedBad();
                                },
                              ),
                              Text('Bad'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 40.0,),
                    Container(
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
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}