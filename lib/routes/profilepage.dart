import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/main.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/PostCard.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int postCount = 0;
  user profUser = user(mail: 'mertture@sabanciuniv.edu', username: 'mertture0', fullname: 'Mert Türe',
      followers: 0, following: 0, posts: 0, description: 'Orthopedics in Acıbadem');
  List<Post> posts = [
    Post( username: 'mertture0', photoUrl:'', location:'Istanbul-Acıbadem', text:'Wanna swap shifts?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 )
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              'Profile',
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

          body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(

                      children: <Widget>[
                        Text(
                          'Followers',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: 'BrandonText',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${profUser.followers}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 50.0),
                    CircleAvatar(
                      backgroundImage: AssetImage("lib/images/cat.jpg"),
                      radius: 56.0,
                    ),
                    SizedBox(width: 50.0),
                    Column(
                      children: <Widget>[
                        Text(
                          'Following',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          '${profUser.following}',
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
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Column(

                    children: <Widget>[
                    Text(
                    '${profUser.fullname}',
                      style: TextStyle(
                        fontFamily: 'BrandonText',
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    ],
                  ),
                  ],
                ),

                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Column(

                      children: <Widget>[
                        Text(
                          '${profUser.description}',
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


                SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 40,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[750],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          side: BorderSide(width: 2, color: AppColors.primary),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'BrandonText',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                      ),
                    ),
                  ],
                ),

                Divider(
                  color: Colors.grey[800],
                  height: 30,
                  thickness: 2.0,
                ),

                Column(
                  children: posts.map((post) => PostCard(
                      post: post,
                      delete: () {
                        setState(() {
                          posts.remove(post);
                        });
                      }
                  )).toList(),
                ),
              ],
            ),
          )
      ),
    );
  }
}