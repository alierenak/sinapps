import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//hello world

class Welcome extends StatefulWidget {
  //FirebaseAnalytics mFirebaseAnalytics = FirebaseAnalytics().getInstance(this);

  const Welcome({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                  padding: EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(width: 6),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Welcome to ",
                            style: kButtonLightTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: "sinapps",
                                style: TextStyle(
                                  decorationThickness: 2.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage("lib/images/logo.png"),
                        radius: MediaQuery.of(context).size.width / 2.5,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () {
                                    FirebaseAnalytics().logEvent(
                                        name: 'Login', parameters: null);
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20.0,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          /*
                            SizedBox(height: 8,),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 20.0,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey[800],
                                    ),
                                  ),
                                ),
                                //SizedBox(width: 8.0,),
                              ],
                            ),
                            */
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*



 */
