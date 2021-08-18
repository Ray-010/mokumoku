import 'package:flutter/material.dart';

class AddStudyRoomPage extends StatefulWidget {
  @override
  _AddStudyRoomPageState createState() => _AddStudyRoomPageState();
}

class _AddStudyRoomPageState extends State<AddStudyRoomPage> {
  final _formKey = GlobalKey<FormState>();

  String? dropdownValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規作成'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    // controller: titleController,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: "Room名",
                      // hintText: "Some Hint",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Room名を入力してください';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(children: [
                      Expanded(
                        flex: 3, // 1 要素分の横幅
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          // color: Colors.red,
                          child: Text(
                            '勉強時間',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // height: 60,
                        ),
                      ),
                      Expanded(
                        flex: 2, // 2 要素分の横幅
                        child: DropdownButton<String>(
                          hint: Text('時間を選択'),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.deepPurple
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          value: dropdownValue,
                          items: <String>['10', '30', '60', '90']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          })
                              .toList(),
                        ),
                      ),
                      Expanded(
                        flex: 1, // 3 要素分の横幅
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: Text(
                            '分',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // color: Colors.green,
                          // height: 60,
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                    ),
                    // controller: detailController,
                    decoration: InputDecoration(
                      labelText: "タグ",
                      // hintText: "Some Hint",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async{

                        // ここのSnackBar要らないかも
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Roomを追加しました')),
                          );
                          // メモ追加の処理
                          // await addMemo();

                          // 作った部屋に自動的に移動する
                          Navigator.pop(context); // とりあえず今は前のページに戻るようにしてる
                        }
                      },
                      child: Text(
                        'スタート',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}