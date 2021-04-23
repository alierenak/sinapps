import 'package:flutter/material.dart';
import 'package:flutter_app_project/routes/login.dart';

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
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "sinapps",
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type : BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                ),
                ],
                ),
              ),
            ),
      );

  }
}