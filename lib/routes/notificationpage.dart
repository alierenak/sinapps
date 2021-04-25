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
      photo: "lib/images/berf.jpeg",
      date: "5m",
      text: "liked your photo."),
  NotifPost(
      name: "Ali Eren Ak",
      photo: "lib/images/ali.jpeg",
      date: " 15h",
      text: "started to following you!"),
  NotifPost(
      name: "Mert Türe",
      photo: "lib/images/mert.jpeg",
      date: "2d",
      text: "liked your comment."),
  NotifPost(
      name: "Kaan Atmaca",
      photo: "lib/images/kaan.jpeg",
      date: "5d",
      text: "commented on your post."),
  NotifPost(
      name: "Kaan Atmaca",
      photo: "lib/images/kaan.jpeg",
      date: "2m",
      text: "sent a message"),
  NotifPost(
      name: "Berfin Sürücü",
      photo: "lib/images/berf.jpeg",
      date: "6m",
      text: "sent a message"),
  NotifPost(
      name: "Ali Eren Ak",
      photo: "lib/images/ali.jpeg",
      date: "8m",
      text: "sent following request"),
  NotifPost(
      name: "Mert Türe",
      photo: "lib/images/mert.jpeg",
      date: "1y",
      text: "liked your photo"),
];


class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
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
            automaticallyImplyLeading: false,
            actions: <Widget>[
            IconButton(
              color: Colors.grey[300],
              icon: Icon(Icons.refresh_sharp),
              onPressed: () {
                Noti();
              },
            ),
        ]
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: 5,),
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
          ),
    );

  }
}
