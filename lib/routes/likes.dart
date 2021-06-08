import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/routes/otherProfilePage.dart';
import 'package:sinapps/utils/colors.dart';

import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/routes/feedpage.dart';
import 'package:sinapps/routes/bottomNavBar.dart';

class Likes extends StatefulWidget {
  const Likes({Key key, this.currentPost}) : super(key: key);
  final Post currentPost;

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  String postId;
  String name;
  String message;

  noResultsFound(context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                  "No Likes found!",
                style: TextStyle(
                  fontFamily: 'BrandonText',
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: double.infinity,
            )
          ],
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
    postId = widget.currentPost.pid;
    var otherUserIds = widget.currentPost.likes;
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Likes",
          style: TextStyle(
            fontFamily: 'BrandonText',
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
      ),
      body: (widget.currentPost.likes.length == 0) ? noResultsFound(context): StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", whereIn: widget.currentPost.likes)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print("iii");
          if (snapshot.hasError) {
            //crashlytics
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            //crashlytics
            return Text("Loading...");

          }
          // ListView
          print("im in");
          return ListView(
            children: (snapshot.data.docs.isEmpty || !snapshot.hasData) ? noResultsFound(context): snapshot.data.docs
                .map((doc) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doc["photoUrl"]),
                    backgroundColor: Colors.black,
                  ),
                  horizontalTitleGap: 25.0,

                  title: Text(doc["username"],
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onTap: () {
                    if (doc['uid'] == _user.uid) {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Profile()));
                    }
                    else {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtherProfilePage(otherUser: user.fromDocument(doc))));
                    }
                  },
                )))
                .toList(),
          );
        },
      ),
    );
  }
}