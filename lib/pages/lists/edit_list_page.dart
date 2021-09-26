import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class EditListPage extends StatefulWidget {
  final String documentId;
  final String title;
  final String content;

  EditListPage(this.documentId, this.title, this.content);

  @override
  _EditListPageState createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  final _formKey = GlobalKey<FormState>();

  final myUid = SharedPrefs.getUid();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // List内容を更新
  Future<void> editList(userId, documentId) async {
    return users
        .doc(userId)
        .collection('lists')
        .doc(documentId)
        .update({
          'title': titleController.text,
          'content': contentController.text,
          'createdTime': Timestamp.now(),
          'completedTime': Timestamp.now(),
        })
        .then((value) => print("目標を達成しました"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    contentController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(myUid).collection('lists').doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              title: Text('編集画面'),
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
                            labelText: "メモ",
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

                                await editList(myUid, widget.documentId);

                                // 前のページに戻る
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              '変更',
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

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}