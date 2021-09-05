import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_with_us_test/pages/login_authentication/authentication_error.dart';


class ForgotPasswordPage extends StatefulWidget {

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  // Firebase 認証
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _email = '';
  String _infoText = '';

  final authError = AuthenticationError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        // leading: IconButton(
        //   onPressed: ()=> Navigator.of(context).pop(), 
        //   icon: Icon(Icons.arrow_back_ios)
        // ),
        centerTitle: true,
        title: Text(
          'パスワードをリセット',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
            letterSpacing: 2.0,
          ),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlueAccent,
          child: Column(
            children: [
              SizedBox(height: 60,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'パスワードを\nお忘れの方へ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  )
                ),
              ),

              SizedBox(height: 10.0,),

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                child: Text(
                  'ご登録いただいているメールアドレスをご入力ください。'
                      'そちらのメールアドレスへパスワード発行URLをお送りいたします。',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 30.0,),

              // メールアドレス入力
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'メールアドレス',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    prefixIcon: Icon(
                      Icons.mail,
                      size: 30.0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),

              // パスワードリセットメール送信ボタン
              GestureDetector(
                onTap: () {
                  try {
                    auth.sendPasswordResetEmail(email: _email);
                  } catch (e) {
                    print('メールの送信に失敗しました。');
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  alignment: Alignment.center,
                  height: 45.0,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[400],
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(
                    '送信',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),

              // ログイン失敗時のエラーメッセージ
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _infoText,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}