import 'package:flutter/material.dart';
import 'package:sinapps/models/notif.dart';
import 'package:sinapps/utils/colors.dart';

class NotifCard extends StatelessWidget {
  final NotifPost notification;
  NotifCard({this.notification});



  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[100],
      margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                height: 60.0,
                width: 60.0,
                color: AppColors.textColor1,
                child: Image.asset(notification.photo),
              ),

            ),
            Expanded(

              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                        notification.name,
                          style: TextStyle(
                            color: AppColors.textColor1,
                            fontSize: 13,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          notification.text,
                          style: TextStyle(
                            color: AppColors.textColor1,
                            fontSize: 13,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 25,),
                        Text(
                          notification.date,
                          style: TextStyle(

                            color: Colors.black26,
                            fontSize: 13,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w300,

                          ),
                        ),
                      ],
                    ),
                  ],
                ),

            ),
            ),
          ],
        ),
      ),
    );
  }
}


