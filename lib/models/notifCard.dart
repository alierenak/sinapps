import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sinapps/models/postView.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/commentview.dart';
import 'package:sinapps/routes/otherProfilePage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/colors.dart';
import 'post.dart';
import 'package:intl/intl.dart';
import 'package:sinapps/routes/likes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:sinapps/models/notif.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:sinapps/routes/postPage.dart';
class NotifCard extends StatefulWidget {
  final Notif nt;
  NotifCard({this.nt});

  @override
  _NotifCardState createState() => _NotifCardState();
}

class _NotifCardState extends State<NotifCard> {
  user otherUser, currentUser, otherUser2;
  bool isLoaded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void otherUserProf() async {
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.nt.otherUid)
        .get();

    otherUser = user(
      username: x.docs[0]['username'],
      fullname: x.docs[0]['fullname'],
      followers: x.docs[0]['followers'],
      following: x.docs[0]['following'],
      posts: [],
      description: x.docs[0]['description'],
      photoUrl: x.docs[0]['photoUrl'],
      phoneNumber: x.docs[0]['phoneNumber'],
      profType: x.docs[0]['profType'],
      uid: x.docs[0]['uid'],
    );

    var xy = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.nt.uid)
        .get();

    otherUser2 = user(
      username: xy.docs[0]['username'],
      fullname: xy.docs[0]['fullname'],
      followers: xy.docs[0]['followers'],
      following: xy.docs[0]['following'],
      posts: [],
      description: xy.docs[0]['description'],
      photoUrl: xy.docs[0]['photoUrl'],
      phoneNumber: xy.docs[0]['phoneNumber'],
      profType: xy.docs[0]['profType'],
      uid: xy.docs[0]['uid'],
    );

    if (currentUser != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void loadUserInfo() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    currentUser = user(
        followers: x.docs[0]['followers'],
        following: x.docs[0]['following'],
        username: x.docs[0]['username'],
        fullname: x.docs[0]['fullname'],
        phoneNumber: x.docs[0]['phoneNumber'],
        photoUrl: x.docs[0]['photoUrl'],
        description: x.docs[0]['description'],
        profType: x.docs[0]['profType'],
        uid: x.docs[0]['uid']
    );

    if (otherUser != null && otherUser2 != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }


  @override
  void initState() {
    loadUserInfo();
    otherUserProf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nt.notifType == "like") {
      return GestureDetector(
        onTap: () async {
          var posts = await FirebaseFirestore.instance
              .collection('posts')
              .where('pid', isEqualTo: widget.nt.pid)
              .get();
          FirebaseAuth _auth;
          User _user;
          _auth = FirebaseAuth.instance;
          _user = _auth.currentUser;
          
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => PostPage(post: Post.fromDocument(posts.docs[0]))));

        },
        child: Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.nt.userPhotoURL),
                  radius: 32.0,
                ),
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(widget.nt.),
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.nt.username + " like your post.",
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if (widget.nt.notifType == "followRequest"){
      return GestureDetector(
        onTap: () async {
          var otherUser = await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: widget.nt.otherUid)
              .get();
          FirebaseAuth _auth;
          User _user;
          _auth = FirebaseAuth.instance;
          _user = _auth.currentUser;

          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => OtherProfilePage(otherUser: otherUser2)));

        },
        child: Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(otherUser2.photoUrl),
                  radius: 32.0,
                ),
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(widget.nt.),
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              otherUser2.username + " started to follow you.",
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),

                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .update({
                                      "followers": FieldValue.arrayUnion(
                                          [otherUser2.uid])
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(otherUser2.uid)
                                        .update({
                                      "following": FieldValue.arrayUnion(
                                          [currentUser.uid])
                                    });

                                    FirebaseFirestore.instance
                                        .collection('notifications')
                                        .doc(widget.nt.notifID)
                                        .update({
                                      "notifType": "follow",
                                    });

                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    minimumSize: Size(20,10),
                                  ),
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20,),

                                TextButton(
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection('notifications')
                                        .doc(widget.nt.notifID)
                                        .delete();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    minimumSize: Size(20,10),
                                  ),
                                  child: Text(
                                    "Decline",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if (widget.nt.notifType == "follow")  {
      return GestureDetector(
        onTap: () async {
          var otherUser = await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: widget.nt.otherUid)
              .get();
          FirebaseAuth _auth;
          User _user;
          _auth = FirebaseAuth.instance;
          _user = _auth.currentUser;

          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => OtherProfilePage(otherUser: otherUser2)));

        },
        child: Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(otherUser2.photoUrl),
                  radius: 32.0,
                ),
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(widget.nt.),
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              otherUser2.username + " started to follow you.",
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    /*return GestureDetector(
      onTap: () async {
        var otherUser = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: sr.itemID)
            .get();
        FirebaseAuth _auth;
        User _user;
        _auth = FirebaseAuth.instance;
        _user = _auth.currentUser;
        if (otherUser.docs[0]['uid'] == _user.uid) {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Profile()));
        }
        else {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtherProfilePage(
                          otherUser: user.fromDocument(otherUser.docs[0]))));
        }
      },
      child: Card(
        color: Colors.grey[200],
        margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(sr.photoUrl),
                radius: 32.0,
              ),
              /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(sr.photoUrl),
                  ),
                ),*/
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sr.identifier,
                            style: TextStyle(
                              color: AppColors.textColor1,
                              fontSize: 16,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            sr.description,
                            style: TextStyle(
                              color: AppColors.textColor1,
                              fontSize: 13,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
