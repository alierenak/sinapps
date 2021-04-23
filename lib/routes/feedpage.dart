import 'package:flutter/material.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/routes/welcome.dart';
import 'package:flutter_app_project/routes/login.dart';
import 'package:flutter_app_project/routes/signup.dart';
import 'package:flutter_app_project/routes/walkthrough.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{
  int currentPage = 0;

  void changePage(int index){
    setState(() {
      currentPage = index;
    });
  }

  final List<Widget> bodyView = [
    WalkThrough(),
    Login(),
    SignUp(),
    Welcome(),
    Login(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "sinapps",
            ),

          ),
          body: bodyView[currentPage],
          bottomNavigationBar: BottomNavigationBar(
            type : BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            iconSize: 35,
            onTap: changePage,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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

