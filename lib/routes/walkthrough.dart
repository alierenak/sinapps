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
  var AppBarTitles = ["WELCOME", "INTRO", "PROFILES"];
  var PageTitles = ["Awesome CS310 app", "Signup easily", "Create your profile"];
  var ImageURLs = ["https://adtechresources.com/wp-content/uploads/2020/02/Mobile-Application.jpeg",
    "https://cdn.pttrns.com/764/8981_f.jpg", "https://cdn.pttrns.com/614/7772_f.jpg",];
  var ImageCaptions = ["Your personal course material","Just use your SU-Net account",
    "Update your flutter knowledge"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
                          image: NetworkImage(ImageURLs[0]),
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
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
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

                      Text(
                        ImageCaptions[0],
                        style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0,
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
                          image: NetworkImage(ImageURLs[1]),
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
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
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

                      Text(
                        ImageCaptions[1],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0,
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
                          image: NetworkImage(ImageURLs[2]),
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
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
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

                      Text(
                        ImageCaptions[2],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0,
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
                          image: NetworkImage(ImageURLs[2]),
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
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[350],
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[700],
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

                      Text(
                        ImageCaptions[2],
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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