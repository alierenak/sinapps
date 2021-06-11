import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:sinapps/routes/editProfile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/routes/settingspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/routes/following.dart';
import 'package:sinapps/routes/followers.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({Key key, this.otherUser}) : super(key: key);


  final user otherUser;

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int count = 0;
  final controller = PageController(initialPage: 0);
  String followSit = "";
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "",
      fullname = "",
      phoneNumber = "",
      photoUrl = "",
      description = "",
      uid = "",
      activation = "";
  List<dynamic> postsUser = [];
  bool profType;
  List<dynamic> posts = [];
  //var userInff;
  user currentUser;
  bool feedLoading = true;
  int postsSize = 0;


  void _loadUserProf() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    username = x.docs[0]['username'];
    fullname = x.docs[0]['fullname'];
    followers = x.docs[0]['followers'];
    following = x.docs[0]['following'];
    phoneNumber = x.docs[0]['phoneNumber'];
    photoUrl = x.docs[0]['photoUrl'];
    description = x.docs[0]['description'];
    profType = x.docs[0]['profType'];
    uid = x.docs[0]['uid'];
    activation = x.docs[0]['activation'];

    var profPosts = await FirebaseFirestore.instance
        .collection('posts')
        .where('userid', isEqualTo: widget.otherUser.uid)
        .get();
    postsSize = profPosts.size;

    profPosts.docs.forEach((doc) => {
      posts.add(
          Post(
              pid: doc['pid'],
              username: doc['username'],
              userid: doc['userid'],
              userPhotoUrl: doc['userPhotoURL'],
              postPhotoURL: doc['postPhotoURL'],
              location: doc['location'],
              title: doc['title'],
              content: doc['content'],
              date: DateTime.fromMillisecondsSinceEpoch(
                  doc['date'].seconds * 1000),
              likes: doc['likes'],
              comments: doc['comments'],
              topics: doc['topics'],
              isLiked: doc['likes'].contains(uid) ? true : false
          )
      )
    });

    posts..sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      feedLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //_loadUserInfo();
    _loadUserProf();
  }

  Widget build(BuildContext context) {

    currentUser = user(
        username: username,
        fullname: fullname,
        followers: followers,
        following: following,
        posts: postsUser,
        description: description,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        profType: profType,
        uid: uid,
        activation: activation
    );

    if (currentUser.following.contains(widget.otherUser.uid) && count == 1) {
      followSit = "Unfollow";
      count++;
    }
    else if (!currentUser.following.contains(widget.otherUser.uid) && count == 1){
      followSit = "Follow";
      count++;
    }
    count++;


    //_loadUserInfo();
    if (widget.otherUser.profType == true) {
      return MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey[200],
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
                  )
              ),
            ),
            toolbarHeight: 48.0,
            title: Text(
              widget.otherUser.username,
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
          body: Container(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Followers',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Followers(
                                              currentUser: widget.otherUser)));
                            }
                        ),
                        Text(
                          '${widget.otherUser.followers.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.otherUser.photoUrl),
                      radius: 56.0,
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Following',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Following(
                                              currentUser: widget.otherUser)));
                            }
                        ),
                        Text(
                          '${widget.otherUser.following.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.fullname}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.description}',
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

                SizedBox(height: 3.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                'Subcribed Topics',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Topics()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'BrandonText',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$postsSize',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                '$followSit',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if (followSit == "Unfollow") {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayRemove(
                                      [widget.otherUser.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayRemove(
                                      [currentUser.uid])
                                });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    'User unfollowed!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                                setState(() {
                                  followSit = "Follow";
                                });
                              }
                              else {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayUnion(
                                      [widget.otherUser.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayUnion(
                                      [currentUser.uid])
                                });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    'User followed!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                                setState(() {
                                  followSit = "Unfollow";
                                });

                                final CollectionReference notifs = FirebaseFirestore.instance.collection('notifications');
                                var notif_ref = notifs.doc();
                                await notif_ref.set({
                                  "uid": currentUser.uid,
                                  "otherUid": widget.otherUser.uid,
                                  "notifType": "follow",
                                  "userPhotoURL": widget.otherUser.photoUrl,
                                  "pid": "",
                                  "username": widget.otherUser.username,
                                  "notifID": notif_ref.id,
                                  "postPhotoURL": "",
                                });
                              }
                              // TO-DO FOLLOW BUTTON, IF FOLLOWING OR NOT FOLLOWING, PRIVATE, PUBLIC...
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(
                  color: Colors.grey[800],
                  height: 20,
                  thickness: 2.0,
                ),
                //PageView(
                //controller: controller,
                //scrollDirection: Axis.horizontal,
                //children: <Widget>[
                //Column(
                //children: <Widget>[
                //SizedBox(height: 8.0,),
                Expanded(
                  //crossAxisAlignment: CrossAxisAlignment.center,

                  child: PageView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // First View
                      Stack(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.grey[700],
                                size: 12,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.grey[350],
                                size: 9,
                              ),
                            ]),
                        SizedBox(height: 20.0),
                        /*Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            width:double.infinity,
                            child: SingleChildScrollView(
                              child: Column(

                                children: posts.map((post) => littlePostCard(
                                    post: post,
                                )).toList(),

                              ),
                            ),

                          ),*/
                        //padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        //SizedBox(height: 20.0),
                        GridView.count(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          crossAxisCount: 3,
                          children: posts.map((post) {
                            return Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  image: DecorationImage(
                                    image: NetworkImage(post.postPhotoURL),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                height: 150.0);
                          }).toList(),
                        ),
                      ]),

                      // Second View
                      Stack(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.grey[350],
                                size: 9,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.grey[700],
                                size: 12,
                              ),
                            ]),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: posts
                                  .map((post) =>
                                  PostCard(
                                      post: post,
                                      delete: () {
                                        setState(() {
                                          posts.remove(post);
                                        });
                                      }))
                                  .toList(),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                //],
                //),
                //],
              ],
            ),
          ),
        ),

      );
    }
    else if (!currentUser.following.contains(widget.otherUser.uid) && widget.otherUser.profType == false) {
      return MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey[200],
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
                  )
              ),
            ),
            toolbarHeight: 48.0,
            title: Text(
              widget.otherUser.username,
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
          body: Container(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Followers',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            /*onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Followers(
                                              currentUser: widget.otherUser)));
                            }*/
                        ),
                        Text(
                          '${widget.otherUser.followers.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.otherUser.photoUrl),
                      radius: 56.0,
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Following',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            /*onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Following(
                                              currentUser: widget.otherUser)));
                            }*/
                        ),
                        Text(
                          '${widget.otherUser.following.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.fullname}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.description}',
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

                SizedBox(height: 3.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                'Subscribed Topics',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Topics()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'BrandonText',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$postsSize',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                '$followSit',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if (followSit == "Unfollow") {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayRemove(
                                      [widget.otherUser.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayRemove(
                                      [currentUser.uid])
                                });
                                setState(() {
                                  followSit = "Follow";
                                });
                              }
                              else if (followSit == "Follow"){
                                /*FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayUnion(
                                      [widget.otherUser.uid])
                                });

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayUnion(
                                      [currentUser.uid])
                                });*/

                                /*setState(() {
                                  followSit = "Request sent";
                                });*/

                                final CollectionReference notifs = FirebaseFirestore.instance.collection('notifications');
                                var notif_ref = notifs.doc();
                                await notif_ref.set({
                                  "uid": currentUser.uid,
                                  "otherUid": widget.otherUser.uid,
                                  "notifType": "followRequest",
                                  "userPhotoURL": widget.otherUser.photoUrl,
                                  "pid": "",
                                  "username": widget.otherUser.username,
                                  "notifID": notif_ref.id,
                                  "postPhotoURL": "",
                                });


                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    'Follow request is sent!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                              // TO-DO FOLLOW BUTTON, IF FOLLOWING OR NOT FOLLOWING, PRIVATE, PUBLIC...
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(
                  color: Colors.grey[800],
                  height: 20,
                  thickness: 2.0,
                ),
                SizedBox(height: 20.0),

                Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'This account is private \n',
                        style: TextStyle(
                        color: AppColors.textColor,
                          fontFamily: 'BrandonText',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      Icon(
                        Icons.lock,
                        size: 100.0,
                        color: Colors.grey[1000],
                      ),
                    ],
                  ),
                ),



                //PageView(
                //controller: controller,
                //scrollDirection: Axis.horizontal,
                //children: <Widget>[
                //Column(
                //children: <Widget>[
                //SizedBox(height: 8.0,),

                //],
                //),
                //],
              ],
            ),
          ),
        ),

      );
    }

    else if (widget.otherUser.profType == false && currentUser.following.contains(widget.otherUser.uid)) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[200],
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
                  )
              ),
            ),
            toolbarHeight: 48.0,
            title: Text(
              widget.otherUser.username,
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
          body: Container(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Followers',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Followers(
                                              currentUser: widget.otherUser)));
                            }
                        ),
                        Text(
                          '${widget.otherUser.followers.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.otherUser.photoUrl),
                      radius: 56.0,
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                            child: Text('Following',
                              style: TextStyle(
                                fontFamily: 'BrandonText',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Following(
                                              currentUser: widget.otherUser)));
                            }
                        ),
                        Text(
                          '${widget.otherUser.following.length}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.fullname}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.otherUser.description}',
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

                SizedBox(height: 3.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                'Subcribed Topics',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Topics()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'BrandonText',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$postsSize',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[750],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                              BorderSide(width: 2, color: AppColors.primary),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Text(
                                currentUser.following.contains(
                                    widget.otherUser.uid)
                                    ? 'Unfollow'
                                    : 'Follow',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if (followSit == "Unfollow") {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayRemove(
                                      [widget.otherUser.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayRemove(
                                      [currentUser.uid])
                                });
                                setState(() {
                                  followSit = "Follow";
                                });
                              }
                              else {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  "following": FieldValue.arrayUnion(
                                      [widget.otherUser.uid])
                                });

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.otherUser.uid)
                                    .update({
                                  "followers": FieldValue.arrayUnion(
                                      [currentUser.uid])
                                });
                                setState(() {
                                  followSit = "Unfollow";
                                });

                                final CollectionReference notifs = FirebaseFirestore.instance.collection('notifications');
                                var notif_ref = notifs.doc();
                                await notif_ref.set({
                                  "uid": currentUser.uid,
                                  "otherUid": widget.otherUser.uid,
                                  "notifType": "follow",
                                  "userPhotoURL": widget.otherUser.photoUrl,
                                  "pid": "",
                                  "username": widget.otherUser.username,
                                  "notifID": notif_ref.id,
                                  "postPhotoURL": "",
                                });
                              }
                              // TO-DO FOLLOW BUTTON, IF FOLLOWING OR NOT FOLLOWING, PRIVATE, PUBLIC...
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(
                  color: Colors.grey[800],
                  height: 20,
                  thickness: 2.0,
                ),
                //PageView(
                //controller: controller,
                //scrollDirection: Axis.horizontal,
                //children: <Widget>[
                //Column(
                //children: <Widget>[
                //SizedBox(height: 8.0,),
                Expanded(
                  //crossAxisAlignment: CrossAxisAlignment.center,

                  child: PageView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // First View
                      Stack(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.grey[700],
                                size: 12,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.grey[350],
                                size: 9,
                              ),
                            ]),
                        SizedBox(height: 20.0),
                        /*Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            width:double.infinity,
                            child: SingleChildScrollView(
                              child: Column(

                                children: posts.map((post) => littlePostCard(
                                    post: post,
                                )).toList(),

                              ),
                            ),

                          ),*/
                        //padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        //SizedBox(height: 20.0),
                        GridView.count(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          crossAxisCount: 3,
                          children: posts.map((post) {
                            return Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  //padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  image: DecorationImage(
                                    image: NetworkImage(post.postPhotoURL),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                height: 150.0);
                          }).toList(),
                        ),
                      ]),

                      // Second View
                      Stack(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.grey[350],
                                size: 9,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.grey[700],
                                size: 12,
                              ),
                            ]),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: posts
                                  .map((post) =>
                                  PostCard(
                                      post: post,
                                      delete: () {
                                        setState(() {
                                          posts.remove(post);
                                        });
                                      }))
                                  .toList(),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                //],
                //),
                //],
              ],
            ),
          ),
        ),

      );
    }
  }
}
