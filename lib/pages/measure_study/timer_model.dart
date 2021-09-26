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
  bool show = true; // 画面切り替え
  double percent = 1.0;
  int setTime = 0; // 初期時間
  int studyTime = 0; // 総勉強時間
  late Timer _timer;

  void changeHourVal(val) {
    this.hour = val;
    notifyListeners();
  }
  void changeMinuteVal(val) {
    this.min = val;
    notifyListeners();
  }

  static const durationSec = const Duration(seconds: 1);

  void startTimer() {
    if(stopped==true) {
      this.timeForTimer = ((this.hour*60*60)+(this.min*60)+this.sec);
      this.setTime = this.timeForTimer;
    } else {
      this.timeForTimer = pauseTime;
    }
    percent = 1.0; // 初期状態がなぜか0になってしまう
    started = false;
    stopped = true;
    notifyListeners();
    
    _timer = Timer.periodic(durationSec, (timer) {
      if(this.timeForTimer < 1) {
        // timer.cancel();
        // this.checkTimer = true;
        this.timeToDisplay = '00:00:00';
        this.timeForTimer += 1;
        // stopped = true;
        // started = true;
        percent = 0;
      } else if(this.checkTimer==false) { // 一時停止
        pauseTime = timeForTimer;
        timer.cancel();
        stopped = false;
        started = true;
        this.checkTimer = true;
      } else if(this.timeForTimer < 60) {
        this.timeToDisplay = '00:00:'+this.timeForTimer.toString().padLeft(2, "0");
        if(this.percent != 0) {
          this.percent = this.timeForTimer / this.setTime;
          this.timeForTimer -= 1;
        } else {
          this.timeForTimer += 1;
        }
      } else if(this.timeForTimer < 3600) {
        int m = (this.timeForTimer / 60).floor();
        int s = this.timeForTimer - (60*m);
        this.timeToDisplay = '00:' + m.toString().padLeft(2, "0") + ':' + s.toString().padLeft(2, "0");
        if(this.percent != 0) {
          this.percent = this.timeForTimer / this.setTime;
          this.timeForTimer -= 1;
        } else {
          this.timeForTimer += 1;
        }
      } else {
        int h = (this.timeForTimer / 3600).floor();
        int t = this.timeForTimer -(3600*h);
        int m = (t / 60).floor();
        int s = t-(60*m);
        this.timeToDisplay = h.toString().padLeft(2, "0") + ':' + m.toString().padLeft(2, "0") + ':' + s.toString().padLeft(2, "0");
        if(this.percent != 0) {
          this.percent = this.timeForTimer / this.setTime;
          this.timeForTimer -= 1;
        } else {
          this.timeForTimer += 1;
        }
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

  void saveStudyTime() {
    studyTime = setTime - timeForTimer;
  }
  void backToTop() {
    show = false;
    timeForTimer = 0;
    started = true;
    stopped = true;
    studyTime = 0;
    this.timeToDisplay = '00:00:00';
    notifyListeners();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}