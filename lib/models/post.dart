import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/location.dart';

class Post {
  String pid;
  String username;
  String userid;
  String userPhotoUrl;
  String content;
  GeoPoint location;
  String title;
  DateTime date;
  String postPhotoURL;
  List<dynamic> comments;
  List<dynamic> likes;
  List<dynamic> topics;
  String activation;
  // ABOUT UI
  bool isLiked;

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      username: doc['username'],
      location: doc['location'],
      date: DateTime.fromMillisecondsSinceEpoch(doc['date'].seconds * 1000),
      title: doc['title'],
      userPhotoUrl: doc['userPhotoURL'],
      content: doc['content'],
      pid: doc['pid'],
      userid: doc['userid'],
      comments: doc['comments'],
      likes: doc['likes'],
      topics: doc['topics'],
      postPhotoURL: doc['postPhotoURL'],
      activation: doc['activation'],
    );
  }



  Post({this.pid, this.username, this.userid, this.userPhotoUrl, this.content, this.location, this.title, this.date, this.comments, this.likes, this.topics, this.isLiked=false, this.postPhotoURL, this.activation});
}
