import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/study_rooms/timer_model.dart';

class StudyPageTimer extends StatelessWidget {
  String roomId;
  StudyPageTimer(this.roomId);
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerProvider>(
      create: (_) => TimerProvider(roomId),
      child: Consumer<TimerProvider>(
        builder: (context, model, child) {
          if(count==0) {
            model.startTimer();
            count++;
          }
          return Text(
            model.timer,
            style: TextStyle(
              fontSize: 24.0,
            ),
          );
        },
      ),
    );
  }
}