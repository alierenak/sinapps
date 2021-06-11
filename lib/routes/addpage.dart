import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:path/path.dart' as Path;
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  // User properties
  user currentUser;
  String postContent, postTitle;
  var pickedFile;
  Position userPosition;
  var photoUrl = "https://firebasestorage.googleapis.com/v0/b/sinapps0.appspot.com/o/profilepictures%2FScreen%20Shot%202021-06-06%20at%2023.43.18.png?alt=media&token=6c28fb47-2924-4b74-a3d6-b47a3844fea0";
  String activation;
  // Controller error about post
  String error = "";
  String contentHint = 'Explain your case and include all necessary information.\n'
      'e.g. I encountered an very rare that and wanted to share my idea about that...';
  String titleHint = "Be spesific and give insight about your case.";
  bool errorHint = false;

  //Flags
  bool locationSetted = false;

  // Bottom sheet controller (close/open)
  double dynamicPadding = 100;
  double dynamicHeight = 100;
  ScrollPhysics scrollPhysics = BouncingScrollPhysics();

  PanelController sheetController = new PanelController();

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
      uid: x.docs[0]['uid'],
      activation: x.docs[0]['activation'],
    );

    setState(() {
      photoUrl = currentUser.photoUrl;
    });
    
  }

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void AddPostCrash() {
    enableCrashlytics();
    crashlytics.setCustomKey('isAddIconPressed', true);
    crashlytics.setCustomKey('error:', "add icon pressed");
    crashlytics.crash();
  }

  Future<void> getDeviceCurrentLocation() async {

    // TO DELETE
    if (userPosition != null) {
      userPosition = null;
      setState(() {
        locationSetted = false;
      });
      return;
    }

    // TO ADD
    Position position;
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userPosition = position;

    setState(() {
      locationSetted = true;
    });

  }

  Future<void> loadPhoto() async  {
    var _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      error = "";
      pickedFile = _pickedFile;
    });
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

    // Check title and content
    if (postContent == "" || postContent == null || postTitle == "" || postTitle == null) {
      setState(() {
        errorHint = true;
        contentHint = "Do you mind to write something here?";
        titleHint = "Do you mind to write something here?";
      });
      return;
    }

    if (pickedFile == null) {
      sheetController.open();
      setState(() {
        error = "* You need to add a photo!";
      });
      return;
    }

    // Check location

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
        "location": userPosition!=null ? GeoPoint(userPosition.latitude, userPosition.longitude) : null,
        "title": postTitle,
        "topics": [],
        "userid": currentUser.uid,
        "userPhotoURL": currentUser.photoUrl,
        "postPhotoURL": imageUrl,
        "username": currentUser.username,
        "activation": currentUser.activation,
      });
      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Succesfully posted"), duration: Duration(milliseconds: 300), ), );
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
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
                addPost();
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
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(15, 10, 5, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(photoUrl),
                            radius: 35.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                    "What happened?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 3/4,
                                child: Focus(
                                  onFocusChange: (c) async {
                                    await Future.delayed(Duration(milliseconds: 100));
                                    if (MediaQuery.of(context).viewInsets.bottom == 0) {
                                      setState(() {
                                        dynamicHeight = 100;
                                      });
                                    } else {
                                      setState(() {
                                        sheetController.animatePanelToPosition(0, duration: Duration(milliseconds: 300));
                                        dynamicHeight = 50;
                                      });
                                    }
                                  },
                                  child: TextField(
                                    onChanged: (value){
                                      setState(() {
                                        postTitle = value;
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
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: titleHint,
                                      hintStyle: TextStyle(
                                          color: errorHint ? Colors.redAccent : Colors.grey[500]
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment(-1, 0),
                        child: Container(
                            child: Text(
                              "Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Focus(
                                onFocusChange: (c) async {
                                  await Future.delayed(Duration(milliseconds: 100));
                                  if (MediaQuery.of(context).viewInsets.bottom == 0) {
                                    setState(() {
                                      dynamicHeight = 100;
                                    });
                                  } else {
                                    setState(() {
                                      sheetController.animatePanelToPosition(0, duration: Duration(milliseconds: 300));
                                      dynamicHeight = 50;
                                    });
                                  }
                                },
                                child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      postContent = value;
                                    });
                                  } ,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontFamily: 'BrandonText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  autocorrect: false,
                                  maxLength: 260,
                                  minLines: 8,
                                  maxLines: 16,
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 0
                                    ),
                                    hintText: contentHint,
                                    hintStyle: TextStyle(
                                        color: errorHint ? Colors.redAccent : Colors.grey[500]
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            controller: sheetController,
            panel: Container(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius:  BorderRadius.only( topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0),),
              ),
              child: ListView(
                physics: scrollPhysics,
                children: [
                  SizedBox(
                    height: dynamicPadding,
                  ),
                  error != "" ? Align(
                    alignment: Alignment(-1.0, 0),
                    child: Container(
                        child: Text(
                          error,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ),
                  ) : Container(),
                  pickedFile == null ? Container(
                    height: 50.0,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        loadPhoto();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Add a photo",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) : Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(right: 20),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                  image: AssetImage(pickedFile.path),
                                )
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                setState((){
                                  pickedFile = null;
                                });
                              },
                              child: Icon(
                                Icons.close_outlined,
                                size: 40,
                              ),
                            ),
                        ),
                      ]
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        getDeviceCurrentLocation();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            !locationSetted ? Icon(
                              Icons.add_location,
                              size: 30.0,
                              color: Colors.white,
                            ) : Icon(
                              Icons.done,
                              size: 30.0,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "State the location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            borderRadius:  BorderRadius.only( topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0),),
            minHeight: dynamicHeight,
            onPanelOpened: () {
              setState(() {
                dynamicPadding = 20;
                scrollPhysics = BouncingScrollPhysics();
              });
            },
            onPanelClosed: () {
              setState(() {
                dynamicPadding = 100;
                scrollPhysics = NeverScrollableScrollPhysics();
              });
            },
            onPanelSlide: (height) {
              setState(() {
                if (height > 0.10) {
                  dynamicPadding = 100 - 80 * height;
                }
              });
            },
            collapsed: Container(
              child: Container(
                padding: EdgeInsets.only(bottom: 50.0),
                child: Icon(
                  Icons.arrow_drop_up,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            body: Center(
              child: Text(""),
            ),
          ),
        ],
      )
    );
  }
}
