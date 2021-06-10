import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/location.dart';

class Comment {
  String postid;
  String userid;
  String userPhotoURL;
  String content;
  List<String> likes;

  Comment({this.postid, this.userid, this.userPhotoURL, this.content, this.likes});
}





