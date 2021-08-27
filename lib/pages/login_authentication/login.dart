import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_with_us_test/pages/login_authentication/authentication_error.dart';
import 'package:study_with_us_test/pages/login_authentication/forgot_password.dart';
import 'package:study_with_us_test/pages/login_authentication/sign_up.dart';
import 'package:study_with_us_test/root.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  // Firebase 認証
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User _user; // FirebaseUser has been changed to User

  String _email = '';
  String _password = '';
  String _infoText = '';
  bool remember= false;

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
          'Sign in',
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
              SizedBox(height: 40,),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcome Back',
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
                  'Sign in with your email and password \nor continue with social media',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 40.0,),

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

              // パスワード入力
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30.0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),
              
              // check box and forgot password
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: remember, 
                      onChanged: (value){
                        setState(() {
                          remember = value!;
                        });
                      },
                    ),
                    Text('Remember me'),
                    
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ],
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

              // ログインボタン
              GestureDetector(
                onTap: () {
                  try {
                    auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
                      _user = auth.currentUser!;
                    });
                    // ログインユーザのIDを取得
                    if(_user.emailVerified) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
                    } else {
                      //Email check
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
                      print('メールアドレスが認証されていません');
                    }

                  } catch (e) {
                    // ログイン失敗時
                    if(_email.isEmpty) {
                      setState(() {
                        _infoText = 'Please enter your email';
                      });
                    } else if(_password.isEmpty) {
                      setState(() {
                        _infoText = 'Please enter your password';
                      });
                    }
                    print('メール認証が済んでいません。$e');
                    // setState(() {
                    //   _infoText = authError.loginErrorMsg(e.hashCode);
                    // });
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
                    'Login',
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