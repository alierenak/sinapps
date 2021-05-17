import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:sinapps/routes/welcome.dart';
import 'package:sinapps/routes/login.dart';
import 'package:sinapps/routes/signup.dart';
import 'package:sinapps/routes/walkthrough.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/welcome.dart';
import 'routes/unknownWelcome.dart';


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

  if (prefs.getBool('initialRun')==null) {
    ifFirst = true;
    await setDefaultPreferences(prefs);
  } else {
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    if (_user != null)
      isLogged = true;
  }

  runApp(App(ifFirst: ifFirst, isLogged: isLogged));
}
  class App extends StatefulWidget {
    final bool ifFirst;
    final bool isLogged;

    const App({Key key, this.ifFirst, this.isLogged}): super(key: key);

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
        }
    );
  }
}

class AppFlow extends StatelessWidget {
  final bool ifFirst;
  final bool isLogged;
  const AppFlow({
    Key key,
    this.ifFirst,
    this.isLogged,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        home: ifFirst ? WalkThrough(analytics: analytics, observer: observer) : isLogged ? BottomBar() : Welcome(analytics: analytics, observer: observer),
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




