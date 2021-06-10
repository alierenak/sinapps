import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'comment.dart';


class CommentCard extends StatefulWidget {
  Comment comment;
  final Function delete;
  CommentCard({this.comment, this.delete});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLoaded = false;

  void likeAction(String commentID) async {

  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello World!"),
          ],
        ),
      ),
    );
  }
}