import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_us_test/pages/lists/list_detail_page.dart';
import 'package:study_with_us_test/root_practice.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

import 'add_list_page.dart';

class ListTopPage extends StatefulWidget {
  @override
  _ListTopPageState createState() => _ListTopPageState();
}

class _ListTopPageState extends State<ListTopPage> {
  final myUid = SharedPrefs.getUid();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddListPage(),
                      fullscreenDialog: true,
                    ));
              },
            )
          ], // タブバー
          bottom: TabBar(
            labelColor: Colors.blue,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(
                // icon: Icon(Icons.android),
                text: "NOT YET",
              ),
              Tab(
                // icon: Icon(Icons.phone_iphone),
                text: "COMPLETED",
              ),
            ],
          ),
          centerTitle: true,
          title: new Text(
            '目標リスト',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(children: <Widget>[

          // 未達成のもの
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(myUid).collection('lists').orderBy('createdTime', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Container(
                      padding: data['isDone'] ? null :
                      const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      decoration: data['isDone'] ? null :
                      new BoxDecoration(
                          border: new Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          )),
                      child: data['isDone'] ? null :
                      ListTile(
                        leading: Icon(
                          Icons.circle,
                          color: Colors.lightBlueAccent,
                        ),
                        title: Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        // subtitle: Text(data['content']),
                        onTap: () {
                          // 詳細ページに飛ぶ
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListDetailPage(document.id),
                              ));
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          // 達成済み
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(myUid).collection('lists').orderBy('createdTime', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Container(
                      padding: data['isDone'] ? const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0)
                          : null,
                      decoration: data['isDone'] ? new BoxDecoration(
                          border: new Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          )) : null,
                      child: data['isDone'] ? ListTile(
                        title: Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        subtitle: Text(
                            '達成日：${DateFormat("yyyy/MM/dd").format(data['completedTime'].toDate().add(Duration(hours: 9)))}'
                        ),
                        onTap: () async {
                          // 詳細ページに飛ぶ
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListDetailPage(document.id),
                              ));
                          //
                          // await Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => RootPracticeWidget(0),
                          //     ));
                          // Navigator.pop(context);
                        },
                      ) : null,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
