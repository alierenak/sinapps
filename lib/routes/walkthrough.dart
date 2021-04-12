import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {

  final controller = PageController(initialPage: 0);
  var AppBarTitles = ["WELCOME", "SIGNUP","LOGIN",  "GET STARTED"];
  var PageTitles = ["Welcome to sinapps",  "Signup easily","Fast and quick login", "Create your profile"];
  var ImageURLs = ["lib/images/logo.png",
    "lib/images/signup.png",
    "https://cdn.pttrns.com/614/7772_f.jpg",
    "lib/images/logo.png"
  ];
  var ImageCaptions = ["A social media app for medics all around the globe", "A simple form to signup","Just enter your name and password to login", "Start your experience"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(00.0),
        child: AppBar(
          backgroundColor: Colors.grey[800],
        ),
      ),
      body: PageView(
        pageSnapping: true,
        controller: controller,
        scrollDirection: Axis.horizontal,
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: AssetImage("lib/images/doctors.jpg"),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                  ]
              ),
              SizedBox(
                height: 25,
              ),
              SafeArea(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        PageTitles[0],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(
                          height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            ImageCaptions[0],
                          textAlign: TextAlign.center,
                            style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0,
                            ),
                          ),
                        
                      ),
                    ],
                )
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: AssetImage("lib/images/signup.png"),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                  ]
              ),
              SizedBox(
                height: 25,
              ),
              SafeArea(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        PageTitles[1],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),

                        child:
                          Text(
                            ImageCaptions[1],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0,
                            ),
                          ),

                      ),
                    ],
                  )
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: AssetImage("lib/images/login.png"),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                  ]
              ),
              SizedBox(
                height: 25,
              ),
              SafeArea(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        PageTitles[2],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),

                        child: Text(
                          ImageCaptions[2],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: AssetImage("lib/images/getstarted.jpg"),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                      size: 15,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                  ]
              ),
              SizedBox(
                height: 25,
              ),
              SafeArea(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        PageTitles[3],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          ImageCaptions[3],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 200,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 60,
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
                                  "Welcome Page",
                                  style: kButtonLight,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/welcome');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}