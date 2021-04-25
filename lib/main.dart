import 'package:flutter/material.dart';
import 'package:sinapps/routes/welcome.dart';
import 'package:sinapps/routes/login.dart';
import 'package:sinapps/routes/signup.dart';
import 'package:sinapps/routes/walkthrough.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/welcome.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome =  Welcome();

  // in order to save and access user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Firebase initialization
  // await Firebase.initializeApp();

  if (prefs.getBool('initialRun')==null) {
    await setDefaultPreferences(prefs);
    _defaultHome = WalkThrough();
  }
  /*
    else if (prefs.getBool('isLogged')!=false) {
    //TODO: If user is logged in no need to show Welcome -> check !!
    _defaultHome = Login();
  }
   */

  Widget app = MaterialApp(
    title: 'sinapps',
    home: _defaultHome,
    routes: {
      '/walkthrough': (context) => WalkThrough(),
      '/login': (context) => Login(),
      '/signup': (context) => SignUp(),
      "/welcome": (context) => Welcome(),
      '/profile': (context) => Profile(),
    },
  );

  runApp(app);
}



