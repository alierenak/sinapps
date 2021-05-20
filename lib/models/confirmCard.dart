import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';

class ConfirmCard extends StatefulWidget {
  @override
  _ConfirmCardState createState() => _ConfirmCardState();
}

class _ConfirmCardState extends State<ConfirmCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white30,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Do you want to sign out",
              ),
            ],
          )
        ],
      ),
    );
  }
}
