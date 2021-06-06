import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sinapps/models/location.dart';
import 'package:sinapps/models/post.dart';

import 'package:sinapps/models/user.dart';

import 'package:sinapps/utils/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/utils/crashlytics.dart';

import 'package:sinapps/models/user.dart';
import 'package:path/path.dart' as Path;
import 'package:sinapps/utils/post_templates.dart';

import 'package:sinapps/models/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:sinapps/routes/geopoint/network.dart';
import 'package:sinapps/routes/geopoint/locationclass.dart';

//class AddPost extends StatefulWidget {
  //const AddPost({Key key, this.analytics, this.observer}) : super(key: key);

  //final FirebaseAnalytics analytics;
  //final FirebaseAnalyticsObserver observer;

class AddPost extends StatefulWidget {
  //const AddPost({Key key, this.currentUser}) : super(key: key);
  //final user currentUser;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  user currentUser;
  final picker = ImagePicker();
  File _imageFile = null;
  String _uploadedFileURL =null;
  final _formKey = GlobalKey<FormState>();

  Future pickImage(source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _imageFile = File(pickedFile.path);
    });

    uploadFile(context);
  }

  Future uploadFile(BuildContext context) async {
    String fileName = Path.basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('post_pictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedFileURL = imageUrl;
    });
  }

  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "", fullname = "", phoneNumber = "", photoUrlUser = "", description = "", uid = "";
  bool profType;
  List<dynamic> postsUser = [];
  //var userInff;
  void _loadUserInfo() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();
    //.then((QuerySnapshot querySnapshot) {
    //  querySnapshot.docs.forEach((doc) async {
    //print(doc['username'] + " " + doc['fullname']);
    //print(doc.data()['username'])


    //});
    //});
    //print(x.docs[0]['username']);
    setState(() {
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      username = x.docs[0]['username'];
      fullname = x.docs[0]['fullname'];
      phoneNumber = x.docs[0]['phoneNumber'];
      photoUrlUser = x.docs[0]['photoUrl'];
      description = x.docs[0]['description'];
      profType = x.docs[0]['profType'];
      uid = x.docs[0]['uid'];
    });




  }

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  void AddPostCrash() {
    enableCrashlytics();
    crashlytics.setCustomKey('isAddIconPressed', true);
    crashlytics.setCustomKey('error:', "add icon pressed");
    crashlytics.crash();
  }

    Future _addPost(List<Post> posts) async {

    final CollectionReference collection = FirebaseFirestore.instance.collection('posts');
    for (var i = 0; i < posts.length; i++) {

      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

      File _imageFile = File(pickedFile.path);
      String refID = "${posts[i].userid}_${Timestamp.fromDate(DateTime.now()).nanoseconds}";
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('post_pictures/$refID');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();

      var post_ref = collection.doc();
      try {
        await post_ref.set({
          "pid": post_ref.id,
          "comments": [],
          "content": posts[i].content,
          "date": posts[i].date,
          "likes": posts[i].likes,
          "location": posts[i].location,
          "title": posts[i].title,
          "topics": posts[i].topics,
          "userid": posts[i].userid,
          "userPhotoURL": posts[i].userPhotoUrl,
          "postPhotoURL": imageUrl,
          "username": posts[i].username,
          "topics": posts[i].topics
        }).then((value) => print("${posts[i].date}\t${posts[i].userid}\t${posts[i].username}\t${imageUrl}\t${posts[i].userPhotoUrl}\t${posts[i].title}"));
        //.catchError((error) => print("Failed to add user: $error"));
      } catch (e) {
      print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //_addPost(posts);
    _loadUserInfo();

    getLocationData();
    //print(currentUser.username);
  }

  String caption, textf;
  String photoUrl = null;

  Location loc = Location();


  void getLocationData() async {
   await loc.getCurrentLocation();

  }


  @override
  Widget build(BuildContext context) {
    currentUser = user(
      username: username,
      fullname: fullname,
      followers: followers,
      following: following,
      posts: postsUser,
      description: description,
      photoUrl: photoUrlUser,
      phoneNumber: phoneNumber,
      profType: profType,
      uid: uid,
    );
    //print(_uploadedFileURL);
    //print("fotofoto");
    final CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    Future<void> addPost() async {
      //String keyVal = "${_user.phoneNumber}-${DateTime.now().microsecondsSinceEpoch}";
      try {
        var post_ref = posts.doc();
        await post_ref.set({
          "pid": post_ref.id,
          "comments": [],
          "content": textf,
          "date": DateTime.now(),
          "likes": [],
          "location": GeoPoint(41.122543, 29.006332),
          "title": caption,
          "topics": [],
          "userid": currentUser.uid,
          "userPhotoURL": currentUser.photoUrl,
          "postPhotoURL": _uploadedFileURL,
          "username": currentUser.username,
          //"location":
        });
      } catch (e) {
        print(e);
        print("error");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        title: Text(
          'Add Post',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 24,
            fontFamily: 'BrandonText',
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.grey[300],
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              AddPost();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: 300,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          onChanged: (value){
                            setState(() {
                              caption = value;
                            });
                          } ,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w600,
                          ),
                          minLines: 1,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            fillColor: AppColors.captionColor,
                            filled: true,
                            hintText: 'Caption',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          onChanged: (value){
                            setState(() {
                              textf = value;
                            });
                          } ,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w600,
                          ),
                          maxLength: 260,
                          minLines: 8,
                          maxLines: 16,
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            fillColor: AppColors.captionColor,
                            filled: true,
                            hintText: 'Whats going on...',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            color: Colors.black26,
                            child: IconButton(
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.photo_outlined,
                                size: 18.0,
                              ),
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                              },
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            color: Colors.black26,
                            child: IconButton(
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.add_location,
                                size: 18.0,
                              ),
                              onPressed: () async {
                                await getLocationData();
                                print(loc.latitude);
                                print(loc.longitude);
                              },
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            color: Colors.black26,
                            child: IconButton(
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.link,
                                size: 18.0,
                              ),
                              onPressed: () {
                                AddPost();
                              },
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            color: Colors.black26,
                            child: IconButton(
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.poll,
                                size: 18.0,
                              ),
                              onPressed: () {
                                AddPost();
                              },
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            color: Colors.black26,
                            child: IconButton(
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.gif,
                                size: 18.0,
                              ),
                              onPressed: () {
                                AddPost();
                              },
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 36.0,
                            width: 90.0,
                            color: AppColors.primary,
                            child: IconButton(
                              alignment: Alignment.center,
                              color: Colors.grey[300],
                              icon: Icon(
                                Icons.add,
                                size: 24.0,
                                color: Colors.black54,
                              ),
                              onPressed: () async {

                                await addPost();
                                print("added");
                                print(caption);
                                print(textf);
                                //AddPostCrash();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
