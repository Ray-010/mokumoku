import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_with_us_test/pages/login_authentication/authentication_error.dart';
import 'package:study_with_us_test/pages/login_authentication/verify.dart';
import 'package:study_with_us_test/utils/firebase.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  String _infoText = '';
  bool _pswdOK = false;

  // エラーメッセージを日本語化するためのクラス
  final authError = AuthenticationError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          '新規登録',
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
              SizedBox(height: 20,),
              Container(
                child:  CircleAvatar(
                  // backgroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width / 4.5,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/Icon.png'),
                    radius: MediaQuery.of(context).size.width / 5,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'MokuMokuヘ\nようこそ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'みんなともくもく勉強しよう！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 20,),

              // メールアドレス入力
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
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


              // パスワード入力
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced, // 入力可能な文字数
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'パスワード ( 8 ~ 20 文字 )',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30.0,
                    ),
                  ),
                  onChanged: (value) {
                    if(passwordController.text.length >= 8){
                      setState(() {
                        _password = value.trim();
                      });
                      _pswdOK = true;
                    } else {
                      _pswdOK = false;
                    }
                  },
                ),
              ),

              // ユーザ登録ボタン
              GestureDetector(
                onTap: () {
                  if(_pswdOK) {
                    try {
                      // メール/パスワードでAuthenticationにユーザ登録→DBにユーザ登録
                      auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_) {
                        Firestore.signUp(_email, auth.currentUser!.uid).then((_) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => VerifyPage()));
                        });
                      });
                    } catch (e) {
                      print('メールアドレスが存在します');
                      // setState(() {
                      //   _infoText = authError.registerErrorMsg(e.code);
                      // });
                    }
                  } else {
                    setState(() {
                      _infoText = 'パスワードは8文字以上です。';
                    });
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
                    'SIGN UP',
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
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  _infoText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}