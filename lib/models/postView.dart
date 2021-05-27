import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';

class PostView extends StatefulWidget {

  const PostView({this.postId});
  final postId;

  @override
  _PostViewState createState() => _PostViewState();

}

class _PostViewState extends State<PostView> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:100),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120.0,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 75,
                          height: 75,
                          child: new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                    "Post is getting ready...",
                    style: TextStyle(
                        color: AppColors.textColor
                    )
                )
              ],
            ),
          )
        ]
    );
  }
}