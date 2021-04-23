import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/utils/colors.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
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


            bottomNavigationBar: BottomNavigationBar(
              type : BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                  size: 35,
                  ),
                  label: '',
                  //onPressed: activeButton == 1 ? () {} : () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Feed()));}
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                  size: 35,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add,
                  size: 35,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications,
                  size: 35,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                  size: 35,),
                  label: '',
                ),
              ],
              //  onTap: (index) => onSelectTab(
                //  TabItem.values[index],
               // ),

                ),
              ),
            ),
      );

  }
}


/*
  body: PageView(
              scrollDirection: Axis.vertical,
              children:<Widget> [
                Container(
                  color: Colors.grey[700],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:<Widget> [
                           Column(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Icon(
                                 Icons.add_a_photo,
                                 size: 30,
                               ),
                               SizedBox(height: 300,),
                               Icon(
                                 Icons.thumb_up,
                                 size: 30,
                               ),
                               SizedBox(height: 100,),
                               Icon(
                                 Icons.comment,
                                 size: 30,
                               ),
                             ],
                           ),
                       ],
                     ),
                      ),
                          //SizedBox(height: 550,),
                      Container(
                        height: 80,
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                minRadius: 30,
                              ),
                              SizedBox(width: 50,),
                              Text(
                                "Username",
                              ),
                            ],
                          ),
                        ),
                      ),
                          ],
                        ),
                  ),

                Container(
                  color: Colors.grey[700],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:<Widget> [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                ),
                                SizedBox(height: 300,),
                                Icon(
                                  Icons.thumb_up,
                                  size: 30,
                                ),
                                SizedBox(height: 100,),
                                Icon(
                                  Icons.comment,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 550,),
                      Container(
                        height: 80,
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                minRadius: 30,
                              ),
                              SizedBox(width: 50,),
                              Text(
                                "Username",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[700],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:<Widget> [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                ),
                                SizedBox(height: 300,),
                                Icon(
                                  Icons.thumb_up,
                                  size: 30,
                                ),
                                SizedBox(height: 100,),
                                Icon(
                                  Icons.comment,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 550,),
                      Container(
                        height: 80,
                        color: Colors.black54,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                minRadius: 30,
                              ),
                              SizedBox(width: 50,),
                              Text(
                                "Username",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

 */