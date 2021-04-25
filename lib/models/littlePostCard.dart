import 'package:flutter/cupertino.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';
import 'post.dart';

class littlePostCard extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  final Post post;
  final Function delete;
  littlePostCard({ this.post, this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(post.userUrl),
                      radius: 32.0,
                    ),
                  ],
                ),

                SizedBox(width: 10.0),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      post.username,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.clip,
                    ),

                  ],
                ),
                SizedBox(width: 50,),
                Text(
                  post.date,
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  post.text,
                  style: TextStyle(
                    color: AppColors.textColor1,
                    fontSize: 26,
                    fontFamily: 'BrandonText',
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            SizedBox(height: 12.0),

            Container(
              height: 300,
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Thank you, I thank you for your time. Is it a good way? ma"
                            "xHeight I will never know how much information will be"
                            " loaded dynamically. where i should locate the scroll, i am g"
                            "etting this problem:",
                        style: TextStyle(
                          color: AppColors.textColor1,
                          fontSize: 24,
                          fontFamily: 'BrandonText',
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.clip,
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[400],
                            size: 16,
                          ),

                        ],
                      ),

                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.width/1.8,//MediaQuery.of(context).size.height/2.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(width: 1,),
                      color: Colors.grey[200],
                      image: DecorationImage(
                          image: AssetImage(post.photoUrl),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ],


              ),
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                SizedBox(width: 8.0),

                Icon(
                  Icons.thumb_up,
                  size: 26.0,
                  color: AppColors.primary,
                ),
                Text(
                  '${post.likes}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(width: 8.0),

                Icon(
                  Icons.thumb_down,
                  size: 26.0,
                  color: AppColors.secondary,
                ),

                Text(
                  '${post.dislikes}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(width: 8.0),

                Icon(
                  Icons.comment,
                  size: 26.0,
                ),

                Text(
                  '${post.comments}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}


