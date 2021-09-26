import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/lists/edit_list_page.dart';
import 'package:study_with_us_test/utils/firebase_list.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class ListDetailPage extends StatefulWidget {
  final String documentId;

  ListDetailPage(this.documentId);

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {

  final myUid = SharedPrefs.getUid();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
                title: Text(
                  '詳細確認'
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditListPage(widget.documentId, data['title'], data['content']),
                            fullscreenDialog: true,
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () async {
                      // 削除するかどうかダイアログを表示
                      await FirebaseList.showConfirmDialog(context, widget.documentId, myUid, data['title']);
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [

                      // タイトル部分
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          'タイトル',
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Text(
                          '${data['title']}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // 内容部分
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Text(
                          '内容',
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Text(
                          '${data['content']}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                      // 勉強記録部分
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        // color: Colors.green[100],
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                        child: Text(
                          '記録',
                        ),
                      ),

                      Container(
                        child: data['isDone'] ?
                        Text(
                          '間違えて達成ボタンを押してしまった場合',
                        ):
                        null,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () async{
                            if (data['isDone']) {
                              // 取り消したいとき
                              await FirebaseList.updateCompleteListFalse(widget.documentId, myUid);
                              Navigator.pop(context);
                            } else {
                              // 達成したとき
                              await FirebaseList.updateCompleteListTrue(widget.documentId, myUid);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            data['isDone'] ? '取り消す' : '達成',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      );
  }
}