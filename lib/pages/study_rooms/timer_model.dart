import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:study_with_us_test/utils/firebase.dart';

class TimerProvider extends ChangeNotifier {
  String roomId;
  TimerProvider(this.roomId);

  String timer = 'Loading...';
  var time = 0;
  int hour = 0;
  int min = 0;
  int sec = 0;
  static const durationSec = const Duration(seconds: 1);
  late Timer _timer;

  void startTimer() {
    Firestore.getRestTime(roomId).then((restTime) {
      time = restTime;
      hour = (time / (60 * 60)).floor();
      var mod = time % (60 * 60);
      min = (mod / 60).floor();
      sec = (mod % 60);
      _timer = Timer.periodic(durationSec, (timer) {
        formatTimer();
      });
    });
  }

  void formatTimer() {
    sec--;
    if(sec < 0) {
      sec = 59;
      min--;
    }
    if(min < 0) {
      min = 59;
      hour--;
    }
    if(hour < 0) {
      hour = 0;
    }
    if(hour <= 0 && min <= 0 && sec <= 0) {
      _timer.cancel();
    }
    
    timer = '${hour.toString().padLeft(2, "0")}時間${min.toString().padLeft(2, "0")}分${sec.toString().padLeft(2, "0")}秒';
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    print('timer cancel');
    super.dispose();
  }
}