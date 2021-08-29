import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/login_authentication/login.dart';
import 'package:study_with_us_test/root.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

class CheckUserAccount extends StatefulWidget {

  @override
  _CheckUserAccountState createState() => _CheckUserAccountState();
}

class _CheckUserAccountState extends State<CheckUserAccount> {
  String myUid = '';

  Future<void> checkUserAccount() async {
    myUid = SharedPrefs.getUid();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkUserAccount(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          print(myUid);
          if(myUid != '') {
            print('Rootページ');
            Navigator.push(context, MaterialPageRoute(builder: (context) => RootWidget()));
          } else {
            print('ログインページ');
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
          return Center();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}