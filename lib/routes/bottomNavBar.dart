import 'package:flutter/material.dart';
import 'package:sinapps/routes/notificationpage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/routes/searchview.dart';
import 'package:sinapps/routes/feedpage.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>{
  int currentPage = 0;

  void changePage(int index){
    setState(() {
      currentPage = index;
    });
  }

  final List<Widget> bodyView = [
    FeedPage(),
    SearchPage(),
    FeedPage(),
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
            type : BottomNavigationBarType.fixed,
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

