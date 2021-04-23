import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/bottomnavi.dart';
/*
class BottomNavi extends StatefulWidget {
  @override
  _BottomNaviState createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: indexPage,
      children: [
        //HomePage(),
        //SearchPage(),
        //NewPostPage(),
        //ActivityPage(),
        //AccountPage(),
      ],
    );
  }

  Widget getBottomNavigationBar() {
    return Container(height: 70,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurRadius: 2,
          ),
        ],
      ),
      child: BottomAppBar(
        color: AppColors.appbarmenuColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: appBarButton(
                      icon: Icons.home,
                      isActive: activeButton == 1,
                      onPressed: activeButton == 1 ? () {} : () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Feed()));}
                  )),
              Expanded(
                  child: appBarButton(
                      icon: Icons.search,
                      isActive: activeButton == 2,
                      onPressed: activeButton == 2 ? () {} : () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search()));}
                  )),
              Expanded(
                  child: appBarButton(
                    icon: Icons.add,
                    isActive: activeButton == 3,
                  )),
              Expanded(
                  child: appBarButton(
                    icon: Icons.message,
                    isActive: activeButton == 4,
                  )),
              Expanded(
                  child: appBarButton(
                      icon: Icons.person,
                      isActive: activeButton == 5,
                      onPressed: activeButton == 5 ? () {} : () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileEdit()));}
                  )),
            ]),
      ),
    );
  }
}

class appBarButton extends StatelessWidget {
  appBarButton({@required this.icon, @required this.isActive, this.onPressed});

  IconData icon;
  bool isActive;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: isActive ? () {} : onPressed,
      elevation: 5.0,
      fillColor:
      isActive ? Color(0xFF3F82E6) : AppColors.third,
      child: Icon(
        icon,
        size: 23.0,
        color: isActive ? Colors.white : Colors.black,
      ),
      shape: CircleBorder(),
    );
  }
}*/
