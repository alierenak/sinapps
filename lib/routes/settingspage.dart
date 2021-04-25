import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/routes/profilepage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context){
  return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              "Settings",
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
            automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invite More Doctors",
                    style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 24.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notifications",
                    style: TextStyle(
                      fontFamily: 'BrandonText',
                      fontSize: 24.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Account and Profile",
                    style: TextStyle(
                      fontFamily: 'BrandonText',
                      fontSize: 24.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Help",
                    style: TextStyle(
                      fontFamily: 'BrandonText',
                      fontSize: 24.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("About",
                    style: TextStyle(
                      fontFamily: 'BrandonText',
                      fontSize: 24.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
  );

  }
}

