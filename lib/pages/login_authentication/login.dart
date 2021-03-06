import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_us_test/pages/login_authentication/forgot_password.dart';
import 'package:study_with_us_test/pages/login_authentication/login_model.dart';
import 'package:study_with_us_test/pages/login_authentication/register.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_)=> LoginModel(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<LoginModel>(
            builder: (context, model, child) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlueAccent,
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
                        onChanged: (email) {
                          model.email = email;
                        },
                      ),
                    ),
                    // パスワード入力
                    Padding(
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
                        onChanged: (password) {
                          model.password = password;
                        },
                      ),
                    ),
          
                    // ログイン登録ボタン
                    GestureDetector(
                      onTap: () async {
                        try {
                          await model.login();
                        } catch (e) {
                          
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    //   child: Container(
                    //     alignment: Alignment.topLeft,
                    //     child: Text(
                    //       _infoText,
                    //       style: TextStyle(
                    //         color: Colors.red,
                    //         fontSize: 16.0,
                    //       ),
                    //     ),
                    //   ),
                    // )
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: model.remember,
                            onChanged: (value){
                              if(model.remember){
                                model.remember = false;
                              } else {
                                model.remember = true;
                              }
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
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Resister())),
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
                ),
              );
            }
          ),
        ),
      )
    );
  }
}