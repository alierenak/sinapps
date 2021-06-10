import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:sinapps/models/postView.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/otherProfilePage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/post.dart';
import 'package:intl/intl.dart';
import 'package:sinapps/routes/likes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class PostPage extends StatefulWidget {
  final PageController controller = PageController(initialPage: 0);
  final Post post;
  PostPage({this.post});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  user otherUser, currentUser;
  bool isLoaded = false;

  void otherUserProf() async {
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: widget.post.userid)
        .get();

    otherUser = user(
      username: x.docs[0]['username'],
      fullname: x.docs[0]['fullname'],
      followers: x.docs[0]['followers'],
      following: x.docs[0]['following'],
      posts: [], // TODO: IS IT IMPORTANT?
      description: x.docs[0]['description'],
      photoUrl: x.docs[0]['photoUrl'],
      phoneNumber: x.docs[0]['phoneNumber'],
      profType: x.docs[0]['profType'],
      uid: x.docs[0]['uid'],
    );

    if (currentUser != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

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
        uid: x.docs[0]['uid']);

    if (otherUser != null) {
      setState(() {
        isLoaded = true;
      });
    }
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
    var currPost = await FirebaseFirestore.instance
        .collection('posts')
        .where('pid', isEqualTo: postid)
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
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .update({"likes": currLikes});
    setState(() {
      widget.post.isLiked = flag;
      widget.post.likes = currLikes;
    });
  }

  var first;
  _getLocation() async {
    final coordinates = new Coordinates(
        widget.post.location.latitude, widget.post.location.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
    });
    //print("${first.featureName} : ${first.addressLine}");
  }

  @override
  void initState() {
    loadUserInfo();
    otherUserProf();
    super.initState();
  }

  Widget build(BuildContext context) {
    _getLocation();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 30.0,
                color: Colors.grey[300],
              )),
        ),
        toolbarHeight: 48.0,
        title: Text(
          widget.post.username,
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
      body: Card(
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
                      (isLoaded && otherUser.uid != currentUser.uid)
                          ? TextButton(
                              child: Text(
                                widget.post.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              onPressed: () {
                                print(otherUser.uid + " mm" + currentUser.uid);
                                if (otherUser.uid == currentUser.uid) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OtherProfilePage(
                                                  otherUser: otherUser)));
                                }
                              })
                          : Container(),
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
                            "${first.adminArea} : ${first.subAdminArea}",
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
                            image: NetworkImage(widget.post.postPhotoURL),
                            fit: BoxFit.fill),
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
                    splashRadius: 15,
                    iconSize: 5,
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      widget.post.isLiked
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                      size: 26.0,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      likeAction(widget.post.pid);
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      minimumSize: Size(5, 5),
                    ),
                    child: Text(
                      "${widget.post.likes.length}",
                      style: TextStyle(
                        fontFamily: 'BrandonText',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Likes(currentPost: widget.post)));
                    },
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
      ),
    );
  }
}
