import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinapps/routes/chats/chatspage.dart';
import 'package:sinapps/routes/chats/conversationpage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:sinapps/models/user.dart';
import 'package:sinapps/models/conversation.dart';

class startConversation extends StatefulWidget {
  const startConversation({Key key, this.currentUser}) : super(key: key);
  final user currentUser;

  @override
  _startConversationState createState() => _startConversationState();
}

class _startConversationState extends State<startConversation> {
  //List<String> setP = [];
  user otherUser;
  String otherUserId;
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
        FirebaseStorage.instance.ref().child('profilepictures/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      _uploadedFileURL = imageUrl;
    });
  }

  String otherUsername = "";
  String conversationID = "";
  Future<Conversation> StartConversation(
      user user, String otherUserId, String otherUserPhotoUrl) async {
    var ref = FirebaseFirestore.instance.collection('chats');

    var documentRef = await ref.add({
      "displayMessage": "hello",
      "otherUsername": otherUsername,
      "members": [user.uid, otherUserId],
      "conversationID": conversationID,
    });
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    Future<void> addUser(user cUser) async {
      try {
        await users.doc(cUser.uid).set(cUser.toJson());
        //.then((value) => print("User Added"))
        //.catchError((error) => print("Failed to add user: $error"));
      } catch (e) {
        print(e);
        return e.message;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start Conversation',
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
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Container(
          //flex: 1,
          margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 80),
          padding: EdgeInsets.all(40.0),

          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(width: 6),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              "Search Username",
                              style: TextStyle(
                                color: AppColors.primaryh,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Username',
                              //labelText: 'Username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              username = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 2.0),
                          height: 50.0,
                          width: 180.0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side:
                                  BorderSide(width: 2, color: Colors.grey[800]),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                var result = await FirebaseFirestore.instance
                                    .collection('users')
                                    .where('username', isEqualTo: username)
                                    .get();
                                print(result.docs[0]['uid']);
                                if (result.size != 0) {
                                  otherUserId = result.docs[0]['uid'];
                                  otherUsername = result.docs[0]['username'];
                                  if (_user.uid.length >= otherUserId.length) {
                                    conversationID = _user.uid + otherUserId;
                                  } else {
                                    conversationID = otherUserId + _user.uid;
                                  }

                                  String otherUserPhotoUrl =
                                      result.docs[0]['photoUrl'];

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Started a conversation!')));
                                  StartConversation(widget.currentUser,
                                      otherUserId, otherUserPhotoUrl);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConversationPage(
                                                userId: _user.uid,
                                                otherUserId: otherUserId,
                                                otherUsername: result.docs[0]
                                                    ['username'],
                                                conversationId: conversationID,
                                              )));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('There is no user!')));
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Start Conversation',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16.0,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
