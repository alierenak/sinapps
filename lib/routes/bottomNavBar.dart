import 'package:flutter/material.dart';
import 'package:sinapps/routes/notificationpage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/routes/searchview.dart';
import 'package:sinapps/routes/feedpage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/routes/addpage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class BottomBar extends StatefulWidget {



  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPage = 0;

  void changePage(int index) {
    setState(() {
      FirebaseAnalytics().logEvent(name: views[index],parameters:null);
      currentPage = index;
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
