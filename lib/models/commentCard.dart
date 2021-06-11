import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/utils/colors.dart';
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
  bool isLiked = false;
  user currentUser;


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
  }

  void likeAction(String commentID) async {

    var currPost = await FirebaseFirestore.instance
        .collection('comments')
        .where('cid', isEqualTo: commentID)
        .get();

    var currLikes = currPost.docs[0]['likes'];
    bool flag;
    if (currLikes.contains(currentUser.uid)) {
      currLikes.remove(currentUser.uid);
      flag = false;
    } else {
      currLikes.add(currentUser.uid);
      flag = true;
    }

    await FirebaseFirestore.instance.collection('comments').doc(commentID).update({"likes": currLikes});

    setState(() {
      isLiked = flag;
      widget.comment.likes = currLikes;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey[300],
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.comment.userPhotoURL),
                      radius: 35.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 6/10,
                          child: Text(
                            widget.comment.content,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      splashRadius: 15,
                      iconSize: 5,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        size: 26.0,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        likeAction(widget.comment.cid);
                      },
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}