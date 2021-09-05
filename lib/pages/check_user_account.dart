import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/login_authentication/login.dart';
import 'package:study_with_us_test/root.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';


class CheckAccount extends StatefulWidget {

  @override
  _CheckAccountState createState() => _CheckAccountState();
}

class _CheckAccountState extends State<CheckAccount> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User _user; // FirebaseUser has been changed to User

  Future<void> checkUser() async{
    final currentUser = auth.currentUser ?? '';
    if(currentUser == '') {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      _user = auth.currentUser!;
      if(_user.emailVerified) {
        SharedPrefs.setUid(_user.uid).then((value) async {
          await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
        });
      } else {
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
      }
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 70.0),
          child: LinearProgressIndicator(
            minHeight: 10.0,
          ),
        ),
      ),
    );
  }
}