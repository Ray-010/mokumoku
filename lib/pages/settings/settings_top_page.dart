import 'package:flutter/material.dart';

import 'add_todo_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddTodoPage(),
                fullscreenDialog: true,
              ));
            },
          )
        ],
        centerTitle: true,
        title: new Text(
          '目標リスト',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: new ListView.builder(
          itemCount: checkBoxListTileModel.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        // activeColor: Colors.pink[300],
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        //font change
                        title: new Text(
                          checkBoxListTileModel[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: checkBoxListTileModel[index].isCheck ? Colors.grey[400] : Colors.black,
                            decoration: checkBoxListTileModel[index].isCheck ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        value: checkBoxListTileModel[index].isCheck,
                        secondary: Container(
                          height: 50,
                          width: 50,
                        ),
                        onChanged: (bool? val) {
                          itemChange(val!, index);
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }
}
class CheckBoxListTileModel {
  int userId;
  String title;
  bool isCheck;

  CheckBoxListTileModel({required this.userId, required this.title, required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,
          title: "ハッカソン優勝！！",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 2,
          title: "基本情報　取得",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 3,
          title: "Flutter理解",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 4,
          title: "マッチョになる",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 5,
          title: "東大合格",
          isCheck: true),
    ];
  }
}