import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/routes/profilepage.dart';


class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}


class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SafeArea(
        top: false,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: AppColors.primary,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  height: 400,
                ),

                Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              minRadius: 30,
                            ),
                            SizedBox(width: 30,),
                            Text(
                              "UserName",
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Column(
                          children: [
                            Text(
                                "This is supposed to show a rounded-edged container with a "
                                    "green left border 3px wide, and the child Text This is a Container."
                                    "However, it just shows a rounded-edged container with an invisible child and an invisible left border."
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  height: 400,
                ),

                Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  height: 400,
                ),
              ],
            ),
          ),

        ),
      ),
    );

  }
}





