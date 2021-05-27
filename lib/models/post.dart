import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/location.dart';

class Post {
  String pid;
  String username;
  String photoUrl;
  String userid;
  String userPhotoUrl;
  String content;
  GeoPoint location;
  String title;
  DateTime date;
  List<dynamic> comments;
  List<dynamic> likes;
  List<dynamic> topics;

  // ABOUT UI
  bool isLiked;

  Post({this.pid, this.username, this. photoUrl, this.userid, this.userPhotoUrl, this.content, this.location, this.title, this.date, this.comments, this.likes, this.topics, this.isLiked=false});
}

class Comment {
  String userid;
  String content;
  DateTime date;
  Comment({this.userid, this.content, this.date});
}
