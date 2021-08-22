import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'measure_top_page.dart';

class ThirtyMinutesPage extends StatefulWidget {
  @override
  _ThirtyMinutesPageState createState() => _ThirtyMinutesPageState();
}

class _ThirtyMinutesPageState extends State<ThirtyMinutesPage> {
  Result? _result = Result.veryGood;

  CountdownController countdownController =
  CountdownController(
    duration: Duration(minutes: 30),
    onEnd: () {
      print('onEnd');
    },
  );
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('10minutes'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Countdown(
                    countdownController: countdownController,
                    builder: (_, Duration time) {
                      if(time.inHours == 0 && time.inMinutes == 0 && time.inSeconds == 0){
                        return TimerFin(deviceWidth);
                      } else {
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                '${time.inHours} 時間 ${time.inMinutes % 60} 分 ${time.inSeconds % 60} 秒 ',
                                style: TextStyle(
                                  fontSize: 36,
                                ),
                              ),
                              Timer(),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Timer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: (){
              if (!countdownController.isRunning) {
                countdownController.start();
                setState(() {
                  isRunning = true;
                });
              } else {
                countdownController.stop();
                setState(() {
                  isRunning = false;
                });
              }
            },
            child: Icon(
              isRunning ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '目標',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          child: Text(
            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
          ),
        ),
      ],
    );
  }

  Widget TimerFin(double width) {
    final double deviceWidth = width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'お疲れ様でした！',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.warning,
                size: 50,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: '記録する場合は必ず一番下にある',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: '「記録する」',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'ボタンを押してください',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '振り返り',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                        icon: Icon(
                          Icons.sentiment_very_satisfied_outlined,
                          color: _result == Result.veryGood ? Colors.red : Colors.blue,
                        ),
                        onPressed: (){
                          setState(() {
                            _result = Result.veryGood;
                          });
                        },
                      ),
                      Radio<Result>(
                        activeColor: Colors.red,
                        value: Result.veryGood,
                        groupValue: _result,
                        onChanged: (Result? value) {
                          setState(() {
                            _result = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                        icon: Icon(
                          Icons.sentiment_satisfied_outlined,
                          color: _result == Result.good ? Colors.red : Colors.blue,
                        ),
                        onPressed: (){
                          setState(() {
                            _result = Result.good;
                          });
                        },
                      ),
                      Radio<Result>(
                        activeColor: Colors.red,
                        value: Result.good,
                        groupValue: _result,
                        onChanged: (Result? value) {
                          setState(() {
                            _result = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                        icon: Icon(
                          Icons.sentiment_neutral_outlined,
                          color: _result == Result.neutral ? Colors.red : Colors.blue,
                        ),
                        onPressed: (){
                          setState(() {
                            _result = Result.neutral;
                          });
                        },
                      ),
                      Radio<Result>(
                        activeColor: Colors.red,
                        value: Result.neutral,
                        groupValue: _result,
                        onChanged: (Result? value) {
                          setState(() {
                            _result = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: deviceWidth >= 420 ? 70 : deviceWidth / 6,
                        icon: Icon(
                          Icons.sentiment_very_dissatisfied_outlined,
                          color: _result == Result.bad ? Colors.red : Colors.blue,
                        ),
                        onPressed: (){
                          setState(() {
                            _result = Result.bad;
                          });
                        },
                      ),
                      Radio<Result>(
                        activeColor: Colors.red,
                        value: Result.bad,
                        groupValue: _result,
                        onChanged: (Result? value) {
                          setState(() {
                            _result = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '今回の目標',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          child: Text(
            'aaaaaaaaaaa\n\n\n\n\n\n\n\n\n\naaaaaaaaa',
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
          ),
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('記録する'),
        ),
      ],
    );
  }
}

enum Result { veryGood, good, neutral, bad }