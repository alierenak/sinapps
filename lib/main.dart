import 'package:flutter/material.dart';
import 'package:flutter_app_project/routes/welcome.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/routes/signup.dart';
import 'package:flutter_app_project/routes/walkthrough.dart';
import 'package:flutter_app_project/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget _defaultHome =  Welcome();

  // in order to save and access user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('initialRun')!=Null) {
    print("Initial Run Value: ");
    print(prefs.getBool('initialRun'));
    await setDefaultPreferences(prefs);
    _defaultHome = WalkThrough();
  } else if (prefs.getBool('isLogged')!=false) {
    //TODO: If user is logged in no need to show Welcome -> check !!
    _defaultHome = Login();
  }

  Widget app = MaterialApp(
    title: 'sinapps',
    home: _defaultHome,
    routes: {
      '/walkthrough': (context) => WalkThrough(),
      '/login': (context) => Login(),
      '/signup': (context) => SignUp(),
      "/welcome": (context) => Welcome(),
    },
  );

  runApp(app);
}



