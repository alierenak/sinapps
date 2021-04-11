import 'package:flutter/material.dart';
import 'package:flutter_app_project/routes/welcome.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/routes/signup.dart';
import 'package:flutter_app_project/routes/walkthrough.dart';

void main() => runApp(MaterialApp(
  //home: Welcome(),
  initialRoute: '/walkthrough',
  routes: {
    '/walkthrough': (context) => WalkThrough(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    "/welcome": (context) => Welcome(),
  },
));