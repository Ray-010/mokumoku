import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_with_us_test/pages/login_authentication/sign_up.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

import '../../root.dart';
import 'authentication_error.dart';
import 'forgot_password.dart';

/// `StatefulWidget`を作成します。
class AnimationLogin extends StatefulWidget
{
  @override
  _AnimationLoginState createState() => _AnimationLoginState();
}

/// `State`に対して`TickerProviderStateMixin`を適用します。
class _AnimationLoginState extends State<AnimationLogin> with TickerProviderStateMixin
{
  late AnimationController _controller;

  // Firebase 認証
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User _user; // FirebaseUser has been changed to User

  String _email = '';
  String _password = '';
  String _infoText = '';
  bool remember= false;

  final authError = AuthenticationError();


  @override
  void initState()
  {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.forward(from: 0.0);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _logo(_animation1),
                  _mail(_animation2),
                  _pass(_animation3),
                  _button(_animation4),
                  _others(_animation5),
                ],
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if(_controller.status == AnimationStatus.completed){
      //       _controller.reverse();
      //       // Navigator.pop(context);
      //       // Navigator.push(context, MaterialPageRoute(builder: (_) => IconTopPage()));
      //     } else{
      //       _controller.forward();
      //     }
      //   },
      //   backgroundColor: Colors.green,
      //   child: Icon(Icons.play_arrow),
      // ),
    );
  }


  late final Animation<double> _animation1 = CurvedAnimation(
    parent: _controller,
    curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
  );

  late final Animation<double> _animation2 = CurvedAnimation(
    parent: _controller,
    curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn),
  );
  late final Animation<double> _animation3 = CurvedAnimation(
    parent: _controller,
    curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
  );
  late final Animation<double> _animation4 = CurvedAnimation(
    parent: _controller,
    curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
  );
  late final Animation<double> _animation5 = CurvedAnimation(
    parent: _controller,
    curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
  );

  FadeTransition _logo(Animation<double> animation){
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: _generateMatrix(animation),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Image(
              width: 200,
              image: AssetImage('images/Icon.png'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                  'MokuMoku',
                  // 'Study With Us'
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  )
              ),
            ),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }

  FadeTransition _mail(Animation<double> animation){
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: _generateMatrix(animation),
        child: Padding(
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
      ),
    );
  }


  FadeTransition _pass(Animation<double> animation){
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: _generateMatrix(animation),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
              fillColor: Colors.white,
              filled: true,
              hintText: 'パスワード',
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
              setState(() {
                _password = value.trim();
              });
            },
          ),
        ),
      ),
    );
  }


  FadeTransition _button(Animation<double> animation){
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: _generateMatrix(animation),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                try {
                  auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
                    _user = auth.currentUser!;
                  });
                  // ログインユーザのIDを取得
                  if(_user.emailVerified) {
                    SharedPrefs.setUid(_user.uid).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootWidget()));
                    });
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
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                alignment: Alignment.center,
                height: 45.0,
                decoration: BoxDecoration(
                    color: Colors.deepOrange[400],
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(
                  'ログイン',
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
        )
      ),
    );
  }


  FadeTransition _others(Animation<double> animation){
    return FadeTransition(
      opacity: animation,
      child: Transform(
        transform: _generateMatrix(animation),
        child: Column(
          children: [
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
                      'パスワードをお忘れの方',
                      style: TextStyle(
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // Sign Up 遷移ボタン
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp())),
              child: Container(
                alignment: Alignment.center,
                color: Colors.lightBlueAccent,
                height: 80.0,
                child: Text(
                    '新規登録はこちら',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Matrix4 _generateMatrix(Animation animation)
  {
    final value = lerpDouble(30.0, 0, animation.value);
    return Matrix4.translationValues(0.0, value!, 0.0);
  }


}