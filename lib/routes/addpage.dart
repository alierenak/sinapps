import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/utils/crashlytics.dart';
import 'package:sinapps/models/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddPost extends StatefulWidget {
  //const AddPost({Key key, this.analytics, this.observer}) : super(key: key);

  //final FirebaseAnalytics analytics;
  //final FirebaseAnalyticsObserver observer;

  const AddPost({Key key, this.currentUser}) : super(key: key);

  final user currentUser;
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final picker = ImagePicker();
  File _imageFile = null;
  String _uploadedFileURL =
      "https://firebasestorage.googleapis.com/v0/b/sinapps0.appspot.com/o/profilepictures%2Fpp.jpeg?alt=media&token=c771f64f-9f1d-4c7c-8fc0-567f935e324c";
  final _formKey = GlobalKey<FormState>();
  String fullname, username, description, photourl = "", uid;
  bool private = true;
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


  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void AddPostCrash() {
    enableCrashlytics();
    crashlytics.setCustomKey('isAddIconPressed', true);
    crashlytics.setCustomKey('error:', "add icon pressed");
    crashlytics.crash();
  }

  String caption, textf;
  String photoUrl = null;
  @override
  Widget build(BuildContext context) {

    final CollectionReference users = FirebaseFirestore.instance.collection('posts');
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    Future<void> addPost() async {
      String keyVal = "${widget.currentUser.username}-${DateTime.now()}";
      try {
        await users.doc(keyVal).set({
          'title': caption,
          "dislikes":[],
          "likes":[],
          "photo_url":_uploadedFileURL,
          "username": widget.currentUser.username,
          "userid" :widget.currentUser.uid,
          //"location":
        });
      } catch (e) {
        print(e);
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
