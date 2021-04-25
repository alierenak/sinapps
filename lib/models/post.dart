import 'package:flutter/material.dart';

class Post {
  String username;
  String photoUrl;
  String userUrl;
  String location;
  String text;
  String date;
  int comments;
  int likes;
  int dislikes;
  List<String> topics;
  Post({ this.username, this. userUrl, this. photoUrl, this.location, this.text, this.date, this.likes, this.dislikes, this.comments });
}
