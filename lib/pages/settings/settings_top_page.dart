import 'package:flutter/material.dart';

class Settings extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"), // <- (※2)
      ),
      body: Center(child: Text("設定") // <- (※3)
      ),
    );
  }
}