import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/lists/lists_top_page.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class AddListPage extends StatefulWidget {
  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final _formKey = GlobalKey<FormState>();

  String? dropdownValue;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // users>listsに目標を追加していく
  Future<void> addList(userId) async {
    return users
        .doc(userId)
        .collection('lists')
        .add({
          'title': titleController.text,
          'content': contentController.text,
          'createdTime': Timestamp.now(),
          'completedTime': Timestamp.now(),
          'isDone': false,
        })
        .then((value) => print("List Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

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
                    controller: titleController,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: "タイトル",
                      // hintText: "Some Hint",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'タイトルを入力してください';
                      }
                      return null;
                    },
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
                    controller: contentController,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                    ),
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "内容",
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {

                          final myUid = SharedPrefs.getUid();
                          await addList(myUid);

                          // 前のページに戻る
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        '追加',
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