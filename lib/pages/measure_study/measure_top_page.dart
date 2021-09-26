import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/measure_study/radial_painter.dart';
import 'package:study_with_us_test/pages/measure_study/review.dart';
import 'package:study_with_us_test/pages/measure_study/timer_model.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class TimerPage extends StatelessWidget {

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
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.0),
          ChangeNotifierProvider<IndividualTimerProvider>(
            create: (_) => IndividualTimerProvider(),
            child: Consumer<IndividualTimerProvider>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        // 時間設定画面
                        Offstage(
                          offstage: !model.show,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 1.3,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'HH',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      NumberPicker(
                                        minValue: 0, 
                                        maxValue: 23,
                                        value: model.hour,
                                        onChanged: (val) {
                                          model.changeHourVal(val);
                                        }
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'MM',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      NumberPicker(
                                        minValue: 0, 
                                        maxValue: 59, 
                                        value: model.min, 
                                        onChanged: (val) {
                                          model.changeMinuteVal(val);
                                        }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // 勉強計測画面
                        Offstage(
                          offstage: model.show,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 1.3,
                            width: MediaQuery.of(context).size.width,
                            child: AnimatedSwitcher(
                              duration: Duration(seconds: 1),
                              child: CustomPaint(
                                foregroundPainter: RadialPainter(
                                  bgColor: model.percent!=0 ? Colors.grey[200]:  Colors.red,
                                  lineColor: Colors.blue,
                                  percent: model.percent,
                                  width: 15.0,
                                ),
                                child: Center(
                                  child: Text(
                                    model.timeToDisplay,
                                    style: TextStyle(
                                      fontSize: 45.0,
                                      color: model.percent!=0 ? Colors.black:  Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: (){
                            model.resetTime();
                            model.show = true;
                          }, 
                          icon: Icon(Icons.settings_backup_restore_rounded),
                          iconSize: 50.0,
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: (){
                            model.started ? model.startTimer() : model.stopTimer();
                            model.show = false;
                          },
                          icon: model.started ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                          iconSize: 50.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 30,),
                    // 勉強記録
                    Offstage(
                      offstage: model.show,
                      child: Container(
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
                            model.stopTimer();
                            model.saveStudyTime();
                            final myUid = SharedPrefs.getUid();
                            // 記録保存処理
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Review(myUid: myUid, setTime: model.studyTime,)));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
          // 目標リストから何のための勉強なのか選択する
          // Container(
          //   padding: const EdgeInsets.all(8.0),
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   child: Column(
          //     children: [
          //       TextFormField(
          //         style: TextStyle(
          //           fontSize: 20,
          //         ),
          //         decoration: InputDecoration(
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           labelText: '目標【任意】',
          //           hintText: "例：テキスト１ページ終わらせる！",
          //           border: OutlineInputBorder(),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // multiprovider等を使わないとproviderは複数使えない
          // Container(
          //   width: MediaQuery.of(context).size.width*0.6,
          //   margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          //   alignment: Alignment.topLeft,
          //   child: Column(
          //     children: [
          //       Text(
          //         '勉強目的を選択',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       ChangeNotifierProvider<SelectPurposeModel>(
          //         create: (_) => SelectPurposeModel(),
          //         child: Consumer<SelectPurposeModel>(
          //           builder: (context, model, child) {
          //             return DropdownButton(
          //               value: model.selectedItem,
          //               onChanged: (newValue) {
          //                 model.setSelectedItem(newValue.toString());
          //               },
          //               items: model.items.map<DropdownMenuItem<String>>((String value) {
          //                 return DropdownMenuItem(
          //                   value: value,
          //                   child: Text(value),
          //                 );
          //               }).toList(),
          //             );
          //           },
          //         ),
          //       ),
          //     ]
          //   ),
          // ),
          

        ],
      ),
    );
  }
}