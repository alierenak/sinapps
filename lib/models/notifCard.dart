import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/notif.dart';
import 'package:sinapps/utils/colors.dart';

class NotifCard extends StatelessWidget {
  final String photo;
  final String name;
  final String text;
  //final String date;

  NotifCard({this.photo, this.name, this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                height: 50.0,
                width: 50.0,
                color: AppColors.textColor1,
                child: Image.asset(photo),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AppColors.textColor1,
                            fontSize: 16,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            color: AppColors.textColor1,
                            fontSize: 13,
                            fontFamily: 'BrandonText',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /*
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  // date,
                  "date",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 13,
                    fontFamily: 'BrandonText',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            )
            */
          ],
        ),
      ),
    );
  }
}
