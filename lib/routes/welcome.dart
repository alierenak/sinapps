import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter_app_project/main.dart';
//hello world
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
        body:Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 26),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Center(
                child: RichText(
                  text: TextSpan(
                    text: "Welcome to ",
                    style: kButtonLight,
                    children: <TextSpan>[
                      TextSpan(
                        text: "sinapps",
                        style: TextStyle(
                          decorationThickness: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Spacer(),
            CircleAvatar(
              radius: 180,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundImage: AssetImage("lib/images/logo.png"),
                radius: 200,
              ),
            ),

            Spacer(),
            Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20.0,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
           SizedBox(height: 10,),
           Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20.0,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                    ),
                  ),
                 //SizedBox(width: 8.0,),
                ],
              ),
            //SizedBox(height: 5,),
          ],
        ),
    ),

    );
  }
}