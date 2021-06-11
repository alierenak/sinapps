import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sinapps/routes/notificationpage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/routes/searchview.dart';
import 'package:sinapps/routes/feedpage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/routes/addpage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sinapps/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  user currentUserA;
  int currentPage = 0;
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "",
      fullname = "",
      phoneNumber = "",
      photoUrl = "",
      description = "",
      uid = "";
  bool profType;
  List<dynamic> postsUser = [];

  void changePage(int index) {
    setState(() {
      FirebaseAnalytics().logEvent(name: views[index], parameters: null);
      if (index == 2) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: AddPost()));
      } else {
        currentPage = index;
      }
    });
  }

  final List<String> views = [
    'FeedPage',
    'SearchPage',
    'AddPost',
    'Notification',
    'Profile'
  ];
  final List<Widget> bodyView = [
    FeedPage(),
    SearchPage(),
    AddPost(),
    NotifPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: bodyView[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        fixedColor: AppColors.primary,
        unselectedItemColor: Colors.grey[300],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        iconSize: 35,
        onTap: changePage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.search),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.add),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.notifications),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.person),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
