import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; //Kaan Atmaca
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter_app_project/routes/welcome.dart';
import 'package:flutter_app_project/main.dart';

/*
void main() {
  runApp(MaterialApp(
    home: WalkThrough(),
  ));
}
*/

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    PageTitles[0],
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: NetworkImage(ImageURLs[0]),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(  PageTitles[1],
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: NetworkImage(ImageURLs[1]),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

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
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(  PageTitles[2],
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: NetworkImage(ImageURLs[2]),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    PageTitles[0],
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,),
                      image: DecorationImage(
                          image: NetworkImage(ImageURLs[2]),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}