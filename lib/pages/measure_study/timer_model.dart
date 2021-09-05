import 'dart:async';

import 'package:flutter/material.dart';

class IndividualTimerProvider extends ChangeNotifier {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '00:00:00';
  int pauseTime = 0;
  bool checkTimer = true;
  late Timer _timer;

  void changeHourVal(val) {
    this.hour = val;
    notifyListeners();
  }
  void changeMinuteVal(val) {
    this.min = val;
    notifyListeners();
  }
  void changeSecondVal(val) {
    this.sec = val;
    notifyListeners();
  }

  static const durationSec = const Duration(seconds: 1);

  void startTimer() {
    if(stopped==true) {
      this.timeForTimer = ((this.hour*60*60)+(this.min*60)+this.sec);
    } else {
      this.timeForTimer = pauseTime;
    }
    started = false;
    stopped = true;
    notifyListeners();
    
    _timer = Timer.periodic(durationSec, (timer) {
      if(this.timeForTimer < 1) {
        timer.cancel();
        this.checkTimer = true;
        this.timeToDisplay = '00:00:00';
        stopped = true;
        started = true;
      } else if(this.checkTimer==false) {
        pauseTime = timeForTimer;
        timer.cancel();
        stopped = false;
        started = true;
        this.checkTimer = true;
      } else if(this.timeForTimer < 60) {
        this.timeToDisplay = '00:00:'+this.timeForTimer.toString().padLeft(2, "0");
        this.timeForTimer = this.timeForTimer-1;
      } else if(this.timeForTimer < 3600) {
        int m = (this.timeForTimer / 60).floor();
        int s = this.timeForTimer - (60*m);
        this.timeToDisplay = '00:' + m.toString().padLeft(2, "0") + ':' + s.toString().padLeft(2, "0");
        this.timeForTimer = this.timeForTimer -1;
      } else {
        int h = (this.timeForTimer / 3600).floor();
        int t = this.timeForTimer -(3600*h);
        int m = (t / 60).floor();
        int s = t-(60*m);
        this.timeToDisplay = h.toString().padLeft(2, "0") + ':' + m.toString().padLeft(2, "0") + ':' + s.toString().padLeft(2, "0");
        this.timeForTimer = this.timeForTimer -1;
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    started = true;
    stopped = false;
    checkTimer = false;
  }
  void resetTime() {
    _timer.cancel();
    timeForTimer = 0;
    started = true;
    stopped = true;
    this.timeToDisplay = '00:00:00';
    notifyListeners();
  }
  
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}