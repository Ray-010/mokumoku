import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/measure_study/review.dart';
import 'package:study_with_us_test/pages/measure_study/select_purpose_model.dart';
import 'package:study_with_us_test/pages/measure_study/timer_model.dart';

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
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
                        Column(
                          children: [
                            Text(
                              'SS',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            NumberPicker(
                              minValue: 0, 
                              maxValue: 59, 
                              value: model.sec, 
                              onChanged: (val) {
                                model.changeSecondVal(val);
                              }
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        model.timeToDisplay,
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: (){
                            model.resetTime();
                          }, 
                          icon: Icon(Icons.settings_backup_restore_rounded),
                          iconSize: 50.0,
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: (){
                            model.started ? model.startTimer() : model.stopTimer();
                          }, 
                          icon: model.started ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                          iconSize: 50.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
          SizedBox(height: 30.0),
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => Review()));
              },
            ),
          ),

        ],
      ),
    );
  }
}