import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/postView.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/otherProfilePage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/colors.dart';
import 'post.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final PageController controller = PageController(initialPage: 0);
  final Post post;
  final Function delete;
  PostCard({this.post, this.delete});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  user otherUser;
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "",
      fullname = "",
      phoneNumber = "",
      photoUrl = "",
      description = "",
      uid = "";
  List<dynamic> postsUser = [];
  bool profType;
  List<dynamic> posts = [];
  void otherUserProf() async {
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.post.userid)
        .get();
    setState(() {
      username = x.docs[0]['username'];
      fullname = x.docs[0]['fullname'];
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      phoneNumber = x.docs[0]['phoneNumber'];
      photoUrl = x.docs[0]['photoUrl'];
      description = x.docs[0]['description'];
      profType = x.docs[0]['profType'];
      uid = x.docs[0]['uid'];
    });

  }


  void goToComments(
      {BuildContext context, String postId, String ownerId, String mediaUrl}) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return PostView(
        postId: postId,
      );
    }));
  }

  void likeAction(String postid) async {

    FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;

    print(postid);
    var currPost = await FirebaseFirestore.instance
        .collection('posts')
        .where('pid', isEqualTo: postid)
        .get();

    var currLikes = currPost.docs[0]['likes'];

    bool flag;
    if (currLikes.contains(_user.uid)) {
      currLikes.remove(_user.uid);
      flag = false;
    } else {
      currLikes.add(_user.uid);
      flag = true;
    }
    await FirebaseFirestore.instance.collection('posts')
        .doc(postid).update({"likes": currLikes});
    setState(() {
      widget.post.isLiked = flag;
      widget.post.likes = currLikes;
    });
  }
  @override
  void initState() {
    super.initState();

    otherUserProf();
  }


  Widget build(BuildContext context) {
    otherUser = user(
        username: username,
        fullname: fullname,
        followers: followers,
        following: following,
        posts: postsUser,
        description: description,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        profType: profType,
        uid: uid
    );
    return Card(
      margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.post.userPhotoUrl),
                      radius: 32.0,
                    ),
                    TextButton(
                      child: Text(widget.post.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.clip,
                      ),
                      onPressed : () {
                        FirebaseAuth _auth;
                        User _user;
                        _auth = FirebaseAuth.instance;
                        _user = _auth.currentUser;
                        print(otherUser.uid + " mm" + _user.uid);
                        if (otherUser.uid == _user.uid) {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        }
                        else {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OtherProfilePage(otherUser: otherUser)));
                        }
                      }
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US').format(widget.post.date),
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.red[800],
                        ),
                        Text(
                          "istinye üniversitesi",
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: TextStyle(
                    color: AppColors.textColor1,
                    fontSize: 26,
                    fontFamily: 'BrandonText',
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              height: 300,
              child: PageView(
                controller: widget.controller,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.post.content,
                        textAlign: TextAlign.justify,
                        maxLines: 9,
                        style: TextStyle(
                          color: AppColors.textColor1,
                          fontSize: 24,
                          fontFamily: 'BrandonText',
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.grey[600],
                            size: 10,
                          ),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[300],
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.width /
                        1.8, //MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        width: 1,
                      ),
                      color: Colors.grey[200],
                      image: DecorationImage(
                          image: NetworkImage(widget.post.photoUrl), fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    widget.post.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                    size: 26.0,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    likeAction(widget.post.pid);
                  },
                ),
                Text(
                  "${widget.post.likes.length}",
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(
                    Icons.comment,
                    size: 26.0,
                  ),
                  onPressed: () {
                    //goToComments(postId: widget.post.pid);
                  },
                ),
                Text(
                  "${widget.post.comments.length}",
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 26.0,
                  ),
                  onPressed: () {
                    //goToComments(postId: widget.post.pid);
                  },
                )
/*
                IconButton(
                  padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                  alignment: Alignment.bottomLeft,
                  splashRadius: 4.0,
                  icon: Icon(
                    Icons.delete,
                    size: 20.0,
                    color: Colors.red,
                  ),
                  onPressed: delete,
                )
*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}