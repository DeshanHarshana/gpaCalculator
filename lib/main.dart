import 'package:loginregistroy/GPA1.dart';
import 'package:loginregistroy/GPA2.dart';
import 'package:loginregistroy/GPA3.dart';
import 'package:loginregistroy/GPA4.dart';
import 'package:loginregistroy/GPA5.dart';
import 'package:loginregistroy/GPA6.dart';
import 'package:loginregistroy/GPA7.dart';
import 'package:loginregistroy/GPA8.dart';
import 'package:loginregistroy/chats.dart';

import 'adddpage.dart';
import 'homepage2.dart';
import 'uploadpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';
import 'semesterpage.dart';
import 'GPALoginpage.dart';
import 'GPAsignUp.dart';
import 'resetpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
 
  
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home:GPA1(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context) => new Registor(),
        '/homepage': (BuildContext context) => new HomePage2(),
        '/login': (BuildContext context) => new Login2Screen(),
        '/upload':(BuildContext context) => new UploadData(),
        '/test':(BuildContext context) => new Addpage(),
        '/GPA1':(BuildContext context) => new GPA1(),
        '/GPA2':(BuildContext context) => new GPA2(),
        '/GPA3':(BuildContext context) => new GPA3(),
        '/GPA4':(BuildContext context) => new GPA4(),
        '/GPA5':(BuildContext context) => new GPA5(),
        '/GPA6':(BuildContext context) => new GPA6(),
        '/GPA7':(BuildContext context) => new GPA7(),
        '/GPA8':(BuildContext context) => new GPA8(),
        '/back':(BuildContext context) => new SemesterPage(),
        '/reset':(BuildContext context) => new Reset(),
        
      },
    );
  }
}