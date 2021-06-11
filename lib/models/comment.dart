import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/location.dart';

class Comment {
  String cid;
  String postid;
  String userid;
  String userPhotoURL;
  String content;
  List<dynamic> likes;

  Comment({this.cid, this.postid, this.userid, this.userPhotoURL, this.content, this.likes});
}





