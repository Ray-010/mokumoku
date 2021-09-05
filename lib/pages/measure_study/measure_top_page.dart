import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/measure_study/ten_minutes.dart';
import 'package:study_with_us_test/pages/measure_study/thirty_minutes.dart';

import 'one_hour.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

enum TimerSet { ten, thirty, sixty }

class _TimerPageState extends State<TimerPage> {
  TimerSet? _timerSet = TimerSet.ten;

  int timer = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'タイマー',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.topLeft,
              child: Text(
                '時間を選択',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            RadioListTile<TimerSet>(
              title: const Text('10分'),
              value: TimerSet.ten,
              groupValue: _timerSet,
              onChanged: (TimerSet? value) {
                timer = 10;
                setState(() {
                  _timerSet = value;
                });
              },
            ),
            RadioListTile<TimerSet>(
              title: const Text('30分'),
              value: TimerSet.thirty,
              groupValue: _timerSet,
              onChanged: (TimerSet? value) {
                timer = 30;
                setState(() {
                  _timerSet = value;
                });
              },
            ),
            RadioListTile<TimerSet>(
              title: const Text('60分'),
              value: TimerSet.sixty,
              groupValue: _timerSet,
              onChanged: (TimerSet? value) {
                timer = 60;
                setState(() {
                  _timerSet = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 3,
                      // controller: titleController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelText: '目標【任意】',
                        hintText: "例：テキスト１ページ終わらせる！",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: (){
                  if(timer == 10) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TenMinutesPage(),
                    ));
                  } else if (timer == 30) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ThirtyMinutesPage(),
                    ));
                  } else if (timer == 60) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => OneHourPage(),
                    ));
                  }
                },
                child: Text(
                  'START'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}