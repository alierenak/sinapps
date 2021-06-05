import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/utils/colors.dart';

import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/routes/feedpage.dart';
import 'package:sinapps/routes/bottomNavBar.dart';

class Followers extends StatefulWidget {
  const Followers({Key key, this.currentUser}) : super(key: key);
  final user currentUser;

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  String userId;
  String name;
  String message;

  @override
  Widget build(BuildContext context) {
    userId = widget.currentUser.uid;
    var otherUserIds = widget.currentUser.following;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Followers",
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", whereIn: widget.currentUser.followers)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            //crashlytics
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            //crashlytics
            return Text("Loading...");
          }
          // ListView

          return ListView(
            children: snapshot.data.docs
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
                    /*String otherUsername;
                if (doc["otherUsername"] ==
                    widget.currentUser.username) {
                  otherUsername = doc["secondUsername"];
                } else {
                  otherUsername = doc["otherUsername"];
                }

                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                          currUser: widget.currentUser,
                          conversationId: doc["conversationID"],
                          members: doc["members"],
                          otherUsername: otherUsername,
                          photoUrl: doc["photoUrl"],
                          otherPhotoUrl: doc["otherPhotoUrl"],
                        )));*/*/
                  },
                )))
                .toList(),
          );
        },
      ),
    );
  }
}