import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:sinapps/routes/welcome.dart';

class Setprofile extends StatefulWidget {
  @override
  _SetprofileState createState() => _SetprofileState();
}

class _SetprofileState extends State<Setprofile> {
  //List<String> setP = [];
  final _formKey = GlobalKey<FormState>();
  String fullname, username, description, photourl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Container(
          //flex: 1,
          margin: EdgeInsets.all(40.0),
          padding: EdgeInsets.all(25.0),

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
                              "Welcome!",
                              style: TextStyle(
                                color: AppColors.primaryh,
                                fontSize: 42.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 6,),
                            Text(
                              "Feed me with\n some details.",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 27.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 28.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(photourl),
                          radius: 40.0,
                          child: GestureDetector(
                            onTap: () {
                              print("bana basıldı");
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.photo_camera),
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
                              hintText: 'Fullname',
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
                                return 'Please enter your fullname';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              fullname = value;
                            },
                          ),
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
                    SizedBox(height: 12),
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
                              hintText: 'Description (optional)',
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
                              return null;
                            },
                            onSaved: (String value) {
                              description = value;
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
                          //padding: const EdgeInsets.symmetric(vertical: 2.0),
                          //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          height: 40.0,
                          width: 150.0,
                          child: OutlinedButton(
                            //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                            //width:0.8,
                            style: OutlinedButton.styleFrom(
                              //backgroundColor: AppColors.secondary,
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

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Created an Account!')));
                                Navigator.pop(
                                  context,
                                  [fullname, username, description, photourl],
                                );
                              }
                            },

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Have Fun!',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20.0,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            //style: OutlinedButton.styleFrom(
                            //backgroundColor: AppColors.secondary,
                            //),
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

/*
IconButton(
onPressed: () {
Navigator.pop(context, [fullname,username]);
},
icon: Icon(Icons.add),
),*/
