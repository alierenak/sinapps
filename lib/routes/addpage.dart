import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:path/path.dart' as Path;

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  user currentUser;
  String postContent, postTitle;
  var pickedFile;
  Position userPosition;
  String error = "";

  final _formKey = GlobalKey<FormState>();

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

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void AddPostCrash() {
    enableCrashlytics();
    crashlytics.setCustomKey('isAddIconPressed', true);
    crashlytics.setCustomKey('error:', "add icon pressed");
    crashlytics.crash();
  }

  Future<void> getDeviceCurrentLocation() async {
    Position position;
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userPosition = position;
    print("Location: ${position.longitude}");
  }

  Future<void> addPost() async {
    /*
    final coordinates = new Coordinates(userPosition.latitude, userPosition.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.addressLine);
    print(first.adminArea);
    print(first.locality);
    print(first.subLocality);
     */

    if (pickedFile == null) {
      setState(() {
        error = "You need to add picture!";
      });
      return;
    }

    File _imageFile = File(pickedFile.path);
    String refID = "${currentUser.uid}_${Timestamp.fromDate(DateTime.now()).nanoseconds}";
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('post_pictures/$refID');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    try {
      var post_ref = posts.doc();
      await post_ref.set({
        "pid": post_ref.id,
        "comments": [],
        "content": postContent,
        "date": DateTime.now(),
        "likes": [],
        "location": GeoPoint(userPosition.latitude, userPosition.longitude),
        "title": postTitle,
        "topics": [],
        "userid": currentUser.uid,
        "userPhotoURL": currentUser.photoUrl,
        "postPhotoURL": imageUrl,
        "username": currentUser.username,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 24,
            fontFamily: 'BrandonText',
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
              Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            size: 30.0,
            color: Colors.grey[300],
          )
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100)
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 90.0,
            child: TextButton(
              onPressed: () {
                print("Hello");
              },
              child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                  )
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          print("Hello");
                        },
                        child: Container(
                          height: 36.0,
                          width: 36.0,
                          child: Row(
                            children: [
                             Icon(
                                  Icons.photo_outlined,
                                  size: 18.0,
                             ),
                              SizedBox(width: 5,),
                              Text(
                                "Add photo"
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Container(
                          child: Text(
                            "Title",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                postTitle = value;
                              });
                            } ,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 13,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                            minLines: 1,
                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Be spesific and give insight about your post.',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Container(
                          child: Text(
                            "Content",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: AppColors.captionColor,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              onChanged: (value){
                                setState(() {
                                  postContent = value;
                                });
                              } ,
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                              autocorrect: false,
                              maxLength: 260,
                              minLines: 8,
                              maxLines: 16,
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0
                                ),
                                hintText: 'Explain your case and include all necessary information.\n'
                                    'e.g. I encountered an very rare that and wanted to share my idea about that...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 60,
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                                  getDeviceCurrentLocation();
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
            Align(
              alignment: Alignment(-0.85, 0),
              child: Container(
                child: Text(
                  error,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
