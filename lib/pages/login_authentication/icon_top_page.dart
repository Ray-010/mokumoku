import 'dart:async';

import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/login_authentication/animation_login.dart';

class IconTopPage extends StatefulWidget {

  @override
  _IconTopPageState createState() => _IconTopPageState();
}

class _IconTopPageState extends State<IconTopPage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _onTimer);
    super.initState();
  }


  Future _onTimer() {
    Navigator.pop(context);
    return Navigator.push(context, MaterialPageRoute(builder: (_) => AnimationLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.lightBlueAccent,
      child: Center(
        child: Image(
          width: 200,
          image: AssetImage('images/Icon.png'),
        ),
      ),
    );
  }
}