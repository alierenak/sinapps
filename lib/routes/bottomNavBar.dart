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
  user currentUserA ;
  int currentPage = 0;
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String username = "", fullname = "", phoneNumber = "", photoUrl = "", description = "", uid = "";
  bool profType;
  List<dynamic> postsUser = [];
  //var userInff;
 /* void _loadUserInfo() async {
    FirebaseAuth _auth;
    User _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: _user.phoneNumber)
        .get();
    //.then((QuerySnapshot querySnapshot) {
    //  querySnapshot.docs.forEach((doc) async {
    //print(doc['username'] + " " + doc['fullname']);
    //print(doc.data()['username'])


    //});
    //});
    print(x.docs[0]['username']);
    setState(() {
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      username = x.docs[0]['username'];
      fullname = x.docs[0]['fullname'];
      phoneNumber = x.docs[0]['phoneNumber'];
      photoUrl = x.docs[0]['photoUrl'];
      description = x.docs[0]['description'];
      profType = x.docs[0]['profType'];
      uid = x.docs[0]['uid'];
    });
    //print(x.docs[0]['username']);
    //print(x);



  }
*/

  void changePage(int index) {
    setState(() {
      FirebaseAnalytics().logEvent(name: views[index],parameters:null);
      if (index == 2) {
        Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: AddPost()));
      } else {
        currentPage = index;
      }
    });
  }

  final List<String> views = ['FeedPage', 'SearchPage', 'AddPost', 'Notification', 'Profile'];
  final List<Widget> bodyView = [
    FeedPage(),
    SearchPage(),
    AddPost(),
    Noti(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      body: bodyView[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: AppColors.secondary,
        fixedColor: Colors.grey[800],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        iconSize: 35,
        onTap: changePage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[600],
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[600],
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[600],
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[600],
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[600],
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        //  onTap: (index) => onSelectTab(
        //  TabItem.values[index],
        // ),
      ),
    );
  }
}
