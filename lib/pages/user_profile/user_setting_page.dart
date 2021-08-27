import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/login_authentication/login.dart';

class UserSetting extends StatefulWidget {
  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40.0,),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 60.0),
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 2.0
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}