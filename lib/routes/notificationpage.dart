import 'package:flutter/cupertino.dart';
import 'package:sinapps/models/notif.dart';
import 'package:sinapps/models/notifCard.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

List<NotifPost> notifs = [
  NotifPost(
      name: "Berfin Sürücü",
      photo: "lib/images/cat.jpg",
      date: "5 m",
      text: "liked your photo."),
  NotifPost(
      name: "Ali Eren Ak",
      photo: "lib/images/cat.jpg",
      date: " 15 h",
      text: "started to following you!"),
  NotifPost(
      name: "Mert Türe",
      photo: "lib/images/cat.jpg",
      date: "2d",
      text: "liked your comment."),
  NotifPost(
      name: "Kaan Atmaca",
      photo: "lib/images/cat.jpg",
      date: "1y",
      text: "commented on your post."),
  NotifPost(
      name: "Kaan Atmaca",
      photo: "lib/images/cat.jpg",
      date: "1y",
      text: "sent a message"),
  NotifPost(
      name: "Berfin Sürücü",
      photo: "lib/images/cat.jpg",
      date: "1y",
      text: "sent a message"),
  NotifPost(
      name: "Ali Eren Ak",
      photo: "lib/images/cat.jpg",
      date: "1y",
      text: "sent following request"),
  NotifPost(
      name: "Mert Türe",
      photo: "lib/images/cat.jpg",
      date: "1y",
      text: "liked your photo"),
];

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[350],
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
            title: Text(
              'Notifications',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 24,
                fontFamily: 'BrandonText',
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              color: Colors.grey[300],
              icon: Icon(Icons.refresh_sharp),
              onPressed: () {
                Noti();
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: notifs
                        .map((notification) => NotifCard(
                      notification: notification,
                    ))
                        .toList(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
