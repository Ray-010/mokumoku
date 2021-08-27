import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_with_us_test/pages/login_authentication/authentication_error.dart';
import 'package:study_with_us_test/pages/login_authentication/sign_up.dart';


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
          'Forgot Password',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
            letterSpacing: 2.0,
          ),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-80,
          child: Column(
            children: [
              SizedBox(height: 60,),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  )
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Please enter your email and we will send \nyou a link to return to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 80.0,),

              // メールアドレス入力
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)
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
                  margin: EdgeInsets.symmetric(horizontal: 60.0),
                  alignment: Alignment.center,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
              
              // Sign Up 遷移ボタン
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter, // stick to the bottom
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp())),
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      height: 80.0,
                      child: Text(
                        'Don\'t have an account? Sign up',
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
    );
  }
}