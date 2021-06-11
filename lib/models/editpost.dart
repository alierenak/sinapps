import 'package:flutter/material.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'post.dart';
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
import 'package:sinapps/routes/likes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/cupertino.dart';
import 'package:sinapps/models/editpost.dart';
import 'package:sinapps/routes/feedpage.dart';
import 'package:sinapps/routes/postPage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:sinapps/routes/editProfile.dart';
import 'package:sinapps/models/location.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/models/littlePostCard.dart';
import 'package:sinapps/routes/settingspage.dart';
import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:sinapps/routes/welcome.dart';
import 'package:sinapps/routes/login.dart';
import 'package:sinapps/routes/setProfile.dart';
import 'package:sinapps/routes/walkthrough.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/net/firestore_methods.dart';
//import 'package:sinapps/utils/post_templates.dart';
import 'package:sinapps/routes/following.dart';
import 'package:sinapps/routes/followers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EditPost extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Post post;

  String caption, text, newCaption, newText;
  EditPost({@required this.caption, @required this.text, this.post}) {
    newCaption = caption;
    newText = text;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editting Post",
          style: TextStyle(
            fontFamily: 'BrandonText',
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(
                  context);
            }),
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: caption,
                decoration: InputDecoration(labelText: "Caption", ),
                onChanged: (value) {
                  newCaption = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please enter caption";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: text,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Post Text",
                ),
                onChanged: (value) {
                  newText = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please enter post text";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              OutlinedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      Navigator.pop(context, [newCaption, newText]);
                    }
                  },
                  child: Text('Change')
              )
            ],
          ),
        ),
      ),
    );
  }
}
