import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:sinapps/routes/welcome.dart';
import 'package:sinapps/routes/login.dart';
import 'package:sinapps/routes/setProfile.dart';
import 'package:sinapps/routes/walkthrough.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/welcome.dart';
import 'routes/unknownWelcome.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'utils/crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // in order to save and access user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool ifFirst = false;
  bool isLogged = false;

  // Firebase initialization
  await Firebase.initializeApp();
  FirebaseAuth _auth;
  User _user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  crashlytics.log("crashlytics enabled");

  //String id = _user.tenantId;
  crashlytics.setUserIdentifier("id");

  if (prefs.getBool('initialRun') == null) {
    ifFirst = true;
    await setDefaultPreferences(prefs);
  } else {
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    if (_user != null) isLogged = true;
    if (isLogged == true) {
      crashlytics.setCustomKey('isLoggedIn', true);
    }
  }

  runApp(App(ifFirst: ifFirst, isLogged: isLogged));
}

class App extends StatefulWidget {
  final bool ifFirst;
  final bool isLogged;

  const App({Key key, this.ifFirst, this.isLogged}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool ifFirst;
  bool isLogged;

  @override
  void initState() {
    super.initState();
    ifFirst = widget.ifFirst;
    isLogged = widget.isLogged;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("Firebase connected");
            return AppFlow(ifFirst: ifFirst, isLogged: isLogged);
          }
          return MaterialApp(
            home: UnknownWelcome(),
          );
        });
  }
}

class AppFlow extends StatelessWidget {
  final bool ifFirst;
  final bool isLogged;
  AppFlow({
    Key key,
    this.ifFirst,
    this.isLogged,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      home: ifFirst
          ? WalkThrough(analytics: analytics, observer: observer)
          : isLogged
              ? BottomBar()
              : Welcome(analytics: analytics, observer: observer),
      routes: {
        '/walkthrough': (context) =>
            WalkThrough(analytics: analytics, observer: observer),
        '/login': (context) => Login(analytics: analytics, observer: observer),
        //'/signup': (context) => SignUp(analytics: analytics, observer: observer),
        "/welcome": (context) =>
            Welcome(analytics: analytics, observer: observer),
        '/profile': (context) =>
            Profile(analytics: analytics, observer: observer),
      },
    );
  }
}
