import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"), // <- (※2)
      ),
      body: Center(child: Text("プロフィール") // <- (※3)
      ),
    );
  }
}