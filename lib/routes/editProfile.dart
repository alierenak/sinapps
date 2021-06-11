import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:sinapps/routes/profilepage.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sinapps/routes/welcome.dart';

class EditProfile extends StatefulWidget {
  //List <bool> _selections = List.generate(2, (_) => false);
  const EditProfile({Key key, this.currentUser}) : super(key: key);
  final user currentUser;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //TextEditingController displayNameController = TextEditingController();
  TextEditingController displayPhoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  user currentUser;
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool bioValid = true;
  bool phoneNumberValid = true;
  final picker = ImagePicker();
  File _imageFile;
  String _uploadedFileURL = "";
  int idx = 0;

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
        FirebaseStorage.instance.ref().child('profilepictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedFileURL = imageUrl;
      print(_uploadedFileURL);
    });
    print(_uploadedFileURL);
  }

  updateUserData() {
    bool priv;
    setState(() {
      bioController.text.trim().length > 100
          ? bioValid = false
          : bioValid = true;

      displayPhoneNumberController.text.trim().length != 13
          ? phoneNumberValid = false
          : phoneNumberValid = true;
    });

    if (displayPhoneNumberController.text.isEmpty) {
      displayPhoneNumberController.text = widget.currentUser.phoneNumber;
      phoneNumberValid = true;
    }
    if (bioController.text.isEmpty) {
      bioController.text = widget.currentUser.description;
      bioValid = true;
    }
    if (_selections[0] == true) {
      priv = false;
    } else {
      priv = true;
    }

    if (bioValid && phoneNumberValid) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUser.uid)
          .update({
            "description": bioController.text,
            "phoneNumber": displayPhoneNumberController.text,
            "photoUrl": _uploadedFileURL,
            "profType": priv,
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
      print(_uploadedFileURL);
      SnackBar successSnackBar =
          SnackBar(content: Text("Profile has been updated."));
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
      idx = 0;
    } else {
      SnackBar successSnackBar = SnackBar(
          content: Text(
              "Phone number is not valid or description is longer than 100 characters."));
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
    }
  }
  /*user profUser = user(
      username: 'mertture0',
      fullname: 'Mert Türe',
      followers: [],
      following: [],
      posts: [],
      description: 'Orthopedics in Acıbadem',
      photoUrl: 'lib/images/mert.jpeg',
      phoneNumber: '+905553332211');*/

  //this.User.photoUrl = 'lib/images/cat.jpg';
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  void initState() {
    super.initState();
    _uploadedFileURL = widget.currentUser.photoUrl;
  }

/*
  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }
*/
  /*Column buildDisplayNameField() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Fullname",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "${widget.currentUser.fullname}",
          ),
        )
      ],
    );
  }*/

  Column buildDisplayPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Phone number",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayPhoneNumberController,
          decoration: InputDecoration(
            hintText: "${widget.currentUser.phoneNumber}",
          ),
        )
      ],
    );
  }

  Column buildPrivateField() {
    if (widget.currentUser.profType == true && idx == 0) {
      _selections[0] = false;
      _selections[1] = true;
      idx++;
    } else if (idx == 0) {
      idx++;
      _selections[1] = false;
      _selections[0] = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Profile Visibility",
              style: TextStyle(color: Colors.grey),
            )),
        ToggleButtons(
          selectedColor: Colors.black,
          fillColor: Colors.grey[500],
          children: [
            Icon(Icons.lock),
            Icon(Icons.lock_open),
          ],
          //isSelected: privIndex,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < _selections.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  _selections[buttonIndex] = true;
                } else {
                  _selections[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: _selections,
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Description",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "${widget.currentUser.description}",
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    bottom: 8.0,
                  ),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(_uploadedFileURL),
                  ),
                ),
                TextButton(
                  child: Text('Change Profile Photo'),
                  onPressed: () {
                    print("ProfilePhotoChangeButton Pressed");
                    pickImage(ImageSource.gallery);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      ///buildDisplayNameField(),
                      buildDisplayPhoneNumberField(),
                      buildBioField(),
                      SizedBox(
                        height: 25,
                      ),
                      buildPrivateField(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    TextButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Welcome()));
                      
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.currentUser.uid)
                            .update({
                            "activation": "deactivated",
                        })
                            .then((value) => print("User Deactivated"))
                            .catchError((error) => print("Failed to deactivate user: $error"));
                        var posts_deact =  await FirebaseFirestore.instance
                            .collection('posts')
                            .where('userid', isEqualTo: widget.currentUser.uid)
                            .get();

                      posts_deact.docs.forEach((doc) =>
                      {
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(doc['pid'])
                            .update({
                          "activation": "deactivated",
                        })
                      });
                        SnackBar successSnackBar =
                        SnackBar(content: Text("Profile has been deactivated."));
                        _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);



                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      minimumSize: Size(115,10),
                    ),
                    child: Text(
                      "Deactivate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                    SizedBox(width: 20,),

                    TextButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.currentUser.uid)
                            .delete()
                            .then((value) => print("User Deleted"))
                            .catchError((error) => print("Failed to delete user: $error"));

                        SnackBar successSnackBar =
                        SnackBar(content: Text("Profile has been deleted."));
                        _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);

                        MaterialPageRoute(builder: (context) => Welcome());



                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        minimumSize: Size(115,10),
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomBar()));

                    updateUserData();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
