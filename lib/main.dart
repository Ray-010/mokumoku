import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study with Us',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[400],
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: RootWidget(),
    );
  }
}
