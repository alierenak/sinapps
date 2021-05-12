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

  // in order to save and access user preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Firebase initialization
  // await Firebase.initializeApp();

  if (prefs.getBool('initialRun')==null) {
    await setDefaultPreferences(prefs);
    defaultHome = WalkThrough();
  }

  Widget build(BuildContext context) {

    return App(defaultHome: defaultHome);
  }

  runApp(App());
}
  class App extends StatefulWidget {
    final Widget defaultHome;
    const App({Key key, this.defaultHome}): super(key: key);

    @override
      _AppState createState() => _AppState();
    }

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  var defaultHome;
  @override
  void initState() {
    super.initState();
    defaultHome = widget.defaultHome;
}

  //var temp2 = main(_DefaultHome: _defaultHome);
  //var _defaulthome = temp2._DefaultHome;
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("Firebase connected");
            return AppFlow(defaultHome: defaultHome);
          }
          return MaterialApp(
            home: UnknownWelcome(),
          );
        }
    );
  }
}

class AppFlow extends StatelessWidget {
  const AppFlow({
    Key key,
    @required this.defaultHome,
  }) : super(key: key);

  final Widget defaultHome;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    if (defaultHome == Welcome()) {
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
    else {
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




