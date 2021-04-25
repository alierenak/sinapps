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
  final controller = PageController(initialPage: 0);
  int postCount = 0;
  user profUser = user(mail: 'mertture@sabanciuniv.edu', username: 'mertture0', fullname: 'Mert Türe',
      followers: 0, following: 0, posts: 3, description: 'Orthopedics in Acıbadem', photoUrl: 'lib/images/cat.jpg');
  //final String currentUserId = profUser.username;
  List<Post> posts = [
    Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/SuIC.jpg", location:'Istanbul-Acıbadem', text:'Wanna swap shifts?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 ),
    Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/googleCampus.jpg", location:'Istanbul-Acıbadem', text:'I am going to Google Campus. Does anyone want to come?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 ),
    Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/cat.jpg", location:'Istanbul-Acıbadem', text:'How old is this cat?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 )
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            toolbarHeight: 48.0,
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

          body: Container(
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
                            backgroundImage: AssetImage(profUser.photoUrl),
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
                      SizedBox(height: 3.0,),
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
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          ),
                          ],
                        ),
                        ],
                      ),

                      SizedBox(height: 3.0,),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 130,
                                height: 28,
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
                          SizedBox(width:28.0),
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
                                '${profUser.posts}',
                                style: TextStyle(
                                  fontFamily: 'BrandonText',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width:28.0),

                          Column(
                            children: [
                              Container(
                                width: 130,
                                height: 28,
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
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
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
                                          Stack(
                                               children: [
                                                 Row(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children:
                                                     [
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

                                                     ]

                                                 ),
                                                 SizedBox(height: 20.0),
                                                 Container(
                                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                width:double.infinity,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: posts.map((post) => PostCard(
                                                        post: post,
                                                        delete: () {
                                                          setState(() {
                                                            posts.remove(post);
                                                          });
                                                        }
                                                    )).toList(),

                                                  ),
                                                ),

                                              ),
                                ]
                                            ),



                                    // Second View
                                    Stack(
                                        children: [
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:
                                              [
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

                                              ]

                                          ),
                                          SizedBox(height: 20.0),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            width:double.infinity,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: posts.map((post) => PostCard(
                                                    post: post,
                                                    delete: () {
                                                      setState(() {
                                                        posts.remove(post);
                                                      });
                                                    }
                                                )).toList(),

                                              ),
                                            ),

                                          ),
                                        ]
                                    ),



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