import 'package:flutter/material.dart';

class Measure extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイマー"), // <- (※2)
      ),
      body: Center(child: Text("タイマー") // <- (※3)
      ),
    );
  }
}