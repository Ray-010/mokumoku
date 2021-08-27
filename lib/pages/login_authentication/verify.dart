import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/login_authentication/login.dart';
import 'package:study_with_us_test/root.dart';

class VerifyPage extends StatefulWidget {

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;


  // 起動時に一度だけ実行
  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }
  
  // 終了処理
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verification',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Container(
          height: MediaQuery.of(context).size.height-80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Please Verify',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'We sent ${user.email} a URL for verification. You have to click the URL to verify your email address within 30 minutes.\n\n Do not leave this page. Verification will be canceled',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),

                // ログイン画面に戻る
                Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter, // stick to the bottom
                  child: GestureDetector(
                    onTap: () {
                      timer.cancel();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      height: 80.0,
                      child: Text(
                        'Back to Login Screen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
    }
  }
}