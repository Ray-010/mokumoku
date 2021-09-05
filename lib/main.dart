import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/check_user_account.dart';
import 'package:study_with_us_test/pages/login_authentication/login.dart';
import 'package:study_with_us_test/pages/measure_study/measure_top_page.dart';
import 'package:study_with_us_test/pages/measure_study/review.dart';
import 'package:study_with_us_test/utils/shared_prefs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.setInstance();
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
        // primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      // home: CheckAccount(),
      // home: LoginPage(),
      // home: Review(),
      home: TimerPage(),
    );
  }
}
