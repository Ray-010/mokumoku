import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'measure_top_page.dart';

class CountdownPage extends StatefulWidget {
  final int min;
  final int hour;
  CountdownPage({Key? key, required this.min, required this.hour}) : super(key: key);


  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {

  CountdownController countdownController =
  CountdownController(
      duration: Duration(
        hours: 10,
        minutes: 0,
        seconds: 100,
      ),
      onEnd: () {
        print('onEnd');
      },
  );
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hour.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Countdown(
                countdownController: countdownController,
                builder: (_, Duration time) {
                  if(time.inHours == 0 && time.inMinutes == 0 && time.inSeconds == 0){
                    return Text('Game over');
                  }
                  return Text(
                    '${time.inHours} 時間 ${time.inMinutes % 60} 分 ${time.inSeconds % 60} 秒 ',
                    style: TextStyle(fontSize: 20),
                  );
                }),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('BACK'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
        Icon(isRunning ? Icons.stop : Icons.play_arrow),
        onPressed: () {
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
      ),
    );
  }
}