import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_project/models/userlocation.dart';
import 'package:flutter_app_project/service/locationservice.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/main.dart';
import 'package:flutter_app_project/models/user.dart';
import 'package:flutter_app_project/models/post.dart';
import 'package:flutter_app_project/models/PostCard.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: HomeView(),
          )),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(
      child: Text(
          'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
    );
  }
}





/*
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;
  Location location = new Location();
  String error;
  void initState(){
    super.initState();
    currentLocation["latitude"] = 0.0;
    currentLocation["longitude"] = 0.0;
    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result){
      currentLocation = result;
    });
  }
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text(
            "LOCATION",
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              Text("Lat/Lng:${currentLocation["latitude"]}/${currentLocation["longtide"]}",
                style: TextStyle(
              fontSize: 20.0, color: Colors.blueAccent,))
            ],
          ),
        ),
      ),
    );
  }
  void initPlatformState() async{
    Map<String, double> myLocation;
    try{
      myLocation = await location.getLocation();
      error="";
    } on PlatformException catch(e) {
      if(e.code == "PERMISSION_DENIED")
        error = "Permision denied";
      else if(e.code == "PERMISSION_DENIED_NEVER_ASK")
        error = "Permission denied - please ask the user to enable it from the app settings";
      myLocation = null;
    }
    setState(() {
      currentLocation = myLocation;
    });
  }
}
*/