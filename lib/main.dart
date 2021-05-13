import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/routes/welcome.dart';
import 'package:sinapps/routes/login.dart';
import 'package:sinapps/routes/signup.dart';
import 'package:sinapps/routes/walkthrough.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/welcome.dart';
import 'routes/unknownWelcome.dart';
// import 'package:firebase_core/firebase_core.dart';
//STEP 3 SINAPPS

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Widget defaultHome =  Welcome();
  if (defaultHome ==  Welcome()){ print("yes");}
  // in order to save and access user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool ifFirst = false;
  // Firebase initialization
  // await Firebase.initializeApp();
  print("1");
  if (prefs.getBool('initialRun')==null) {
    ifFirst = true;
    await setDefaultPreferences(prefs);
    defaultHome = WalkThrough();
  }
  print("2");
  //Widget build(BuildContext context) {
   //
    //return App(defaultHome: defaultHome);
  //}
  print("4");
  if (defaultHome == Welcome()) {
    print("a");
  }
  else if(defaultHome == WalkThrough()) {
    print("b");
  }
  runApp(App(ifFirst: ifFirst));
}
  class App extends StatefulWidget {
    final bool ifFirst;
    const App({Key key, this.ifFirst}): super(key: key);

    @override
      _AppState createState() => _AppState();
    }

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool ifFirst;
  @override
  void initState() {
    super.initState();
    ifFirst = widget.ifFirst;
}

  //var temp2 = main(defaultHome: defaultHome);
  //var defaulthome = temp2.defaultHome;
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("Firebase connected");
            return AppFlow(ifFirst: ifFirst);
          }
          return MaterialApp(
            home: UnknownWelcome(),
          );
        }
    );
  }
}

class AppFlow extends StatelessWidget {
  final bool ifFirst;
  const AppFlow({
    Key key,
    this.ifFirst,
  }) : super(key: key);



  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    if (ifFirst == false) {

      return MaterialApp(

        navigatorObservers: <NavigatorObserver>[observer],
        home: Welcome(analytics: analytics, observer: observer),
        routes: {
          '/walkthrough': (context) => WalkThrough(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          "/welcome": (context) => Welcome(),
          '/profile': (context) => Profile(),
        },

      );
    }
    else if(ifFirst == true) {
      print("aa");
      return MaterialApp(

        navigatorObservers: <NavigatorObserver>[observer],
        home: WalkThrough(analytics: analytics, observer: observer),
        routes: {
          '/walkthrough': (context) => WalkThrough(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          "/welcome": (context) => Welcome(),
          '/profile': (context) => Profile(),
        },

      );
    }
  }
}




