import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gui/pages/CourseListPage.dart';
import 'package:online_course/DownloadListPage.dart';
import 'package:online_course/ForgetPasswordPage.dart';
import 'package:online_course/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ClientHandler.dart';
import 'gui/pages/HomePage.dart';
import 'gui/pages/LoginPage.dart';
import 'gui/pages/SearchPage.dart';
import 'package:online_course/SplashPage.dart';
import 'package:online_course/gui/pages/LoadingPage.dart';
import 'RatingStar.dart';

void main() {
  runApp(MyApp());
}

SharedPreferences localStorage;

class MyApp extends StatelessWidget {
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
    UserInfo();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();
    return MaterialApp(
      title: 'Online course App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OnLoading(),
      // home: MyHomePage(title: 'Online Courses Home page'),
      //home: CourseListPage(title: 'Online Courses'),
      //home: DownloadListPage(title: 'Downloads Courses'),
      //home: SearchPage(title: ''),
      // home: LoginPage(title: ''),
      // home: ForgetPasswordPage(title: ''),
      //home: SplashPage(title: ''),
    );
  }
}

