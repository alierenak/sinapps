import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/routes/chats/chatspage.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sinapps/routes/commentview.dart';
import 'package:sinapps/utils/crashlytics.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


_sendAnalyticsEvent() async {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  await analytics.logEvent(
    name: "Login",
    parameters: <String, dynamic>{'login': 'logged'},
  );
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  void MessageCrash() {
    enableCrashlytics();
    crashlytics.setCustomKey("isMessangerIconPressed", true);
    crashlytics.setCustomKey('error: ', "messanger icon pressed");
  }

  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "", fullname = "", phoneNumber = "", photoUrl = "", description = "", uid = "";
  List<dynamic> posts = [];
  bool profType;
  user currentUser;
  bool feedLoading = true;
  String activation;



  void _loadUserFeed() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    username = x.docs[0]['username'];
    fullname = x.docs[0]['fullname'];
    followers = x.docs[0]['followers'];
    following = x.docs[0]['following'];
    phoneNumber = x.docs[0]['phoneNumber'];
    photoUrl = x.docs[0]['photoUrl'];
    description = x.docs[0]['description'];
    profType = x.docs[0]['profType'];
    uid = x.docs[0]['uid'];
    activation = x.docs[0]['activation'];

    var feed_posts = await FirebaseFirestore.instance
        .collection('posts')
        .where('userid', whereIn: following)
        .get();
    print(feed_posts.size);
    feed_posts.docs.forEach((doc) => {
      if (doc['activation'] == "active") {
        posts.add(
            Post(
              pid: doc['pid'],
              username: doc['username'],
              userid: doc['userid'],
              userPhotoUrl: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              location: doc['location'],
              title: doc['title'],
              content: doc['content'],
              date: DateTime.fromMillisecondsSinceEpoch(
                  doc['date'].seconds * 1000),
              likes: doc['likes'],
              comments: doc['comments'],
              topics: doc['topics'],
              isLiked: doc['likes'].contains(uid) ? true : false,
              activation: doc['activation'],
            )
        )
      }
    });

    posts..sort((a,b) => b.date.compareTo(a.date));
      setState(() {
        print("its in");
      feedLoading = false;
    });

  }

  loadingScreen(context) {
    return [
      Padding(
        padding: const EdgeInsets.only(top:100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 75,
                      height: 75,
                      child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
                "Your feed is getting ready...",
                style: TextStyle(
                  color: AppColors.textColor
                )
            )
          ],
        ),
      )

    ];
  }

  void initState() {
    super.initState();
    _loadUserFeed();
  }

  @override
  Widget build(BuildContext context) {

    currentUser = user(
        username: username,
        fullname: fullname,
        followers: followers,
        following: following,
        description: description,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        profType: profType,
        uid: uid
    );

    FirebaseAnalytics().logEvent(name: 'FeedPage', parameters: null);
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
                    print(currentUser.uid);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage(currentUser: currentUser)));
                    //MessageCrash();
                  },
                ),
              ]),
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: feedLoading ? loadingScreen(context) : posts.map((post) => PostCard(
                        post: post,
                        delete: () {
                          setState(() {
                            posts.remove(post);
                          });
                        }))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
