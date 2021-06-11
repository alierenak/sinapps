import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/routes/chats/chatspage.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sinapps/utils/crashlytics.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/models/notif.dart';
import 'package:sinapps/models/notifCard.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "", fullname = "", phoneNumber = "", photoUrl = "", description = "", uid = "";
  List<dynamic> notifications = [];
  bool profType;
  user currentUser;
  bool notifLoading = true;
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

    var notifs = await FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .get();
    var notifs_opp = await FirebaseFirestore.instance
        .collection('notifications')
        .where('otherUid', isEqualTo: uid)
        .get();

    notifs.docs.forEach((doc) => {
      if (doc['notifType'] == "like") {
        notifications.add(
            Notif(
              pid: doc['pid'],
              username: doc['username'],
              uid: doc['uid'],
              userPhotoURL: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              notifType: doc['notifType'],
              otherUid: doc['otherUid'],
              notifID: doc['notifID'],
            )
        )
      }
    });

    notifs_opp.docs.forEach((doc) => {
      if (doc['notifType'] == "follow" || doc['notifType'] == "followRequest") {
        notifications.add(
            Notif(
              pid: doc['pid'],
              username: doc['username'],
              uid: doc['uid'],
              userPhotoURL: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              notifType: doc['notifType'],
              otherUid: doc['otherUid'],
              notifID: doc['notifID'],
            )
        )
      }
    });

    //notifications..sort((a,b) => b.date.compareTo(a.date));
    setState(() {
      notifLoading = false;
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
                "Your notifications are getting ready...",
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

    FirebaseAnalytics().logEvent(name: 'NotifPage', parameters: null);
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
              ),
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: notifLoading ? loadingScreen(context) : notifications.map((notification) => NotifCard(
                    nt: notification,
                    ))
                    .toList(),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
