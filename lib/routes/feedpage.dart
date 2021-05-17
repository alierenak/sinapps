import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/PostCard.dart';
import 'package:sinapps/models/location.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


_sendAnalyticsEvent() async {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  await analytics.logEvent(
    name: "Login",
    parameters: <String, dynamic>{
      'login': 'logged'
    },
  );
}


class FeedPage extends StatefulWidget {

 /* const FeedPage({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;*/



  @override
  _FeedPageState createState() => _FeedPageState();
}

List<Post> posts = [
  Post( username: 'mertture0', userUrl:"lib/images/mert.jpeg", photoUrl:"lib/images/post12.jpeg", location: Location(country:"Turkey", city: 'Acıbadem'), text:'We have empty beds in ER', date: '23 April 2021', likes:32, dislikes: 7, comments:12),
  Post( username: 'surucux', userUrl:"lib/images/berf.jpeg", photoUrl:"lib/images/googleCampus.jpg", location: Location(country:"Turkey", city: 'Acıbadem'), text:'I am going to Google Campus. Does anyone want to come?', date: '22 January 2021', likes:35, dislikes: 5, comments:27 ),
  Post( username: 'atmaca', userUrl:"lib/images/kaan.jpeg", photoUrl:"lib/images/post10.jpeg", location: Location(country:"Turkey", city: 'Acıbadem'), text:'Cool features about the foot structure', date: '7 January 2021', likes:23, dislikes: 8, comments:12 )
];

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics().logEvent(name: 'FeedPage',parameters:null);
    return new MaterialApp(
      home: SafeArea(
        top: false,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Home",
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  color: Colors.grey[300],
                  icon: Icon(Icons.messenger_rounded),
                  onPressed: () {
                    FeedPage();
                  },
                ),
              ]
          ),

          body: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            width:double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: posts.map((post) => PostCard(
                    post: post,
                    delete: () {
                      setState(() {
                        posts.remove(post);
                      });
                    }
                )).toList(),
              ),
            ),
          ),
        ),
      ),
    );

  }
}


