import 'package:flutter/cupertino.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';
import 'post.dart';

class PostCard extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  final Post post;
  final Function delete;
  PostCard({ this.post, this.delete });

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

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.red[800],
                        ),
                        Text(
                          post.location.city,
                          style: TextStyle(
                            fontFamily: 'BrandonText',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],

                    ),
                  ],
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

                SizedBox(width: 8.0),

                Icon(
                  Icons.more_horiz,
                  size: 26.0,
                ),

/*
                IconButton(
                  padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                  alignment: Alignment.bottomLeft,
                  splashRadius: 4.0,
                  icon: Icon(
                    Icons.delete,
                    size: 20.0,
                    color: Colors.red,
                  ),
                  onPressed: delete,
                )
*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tweetAvatar(),
          SizedBox(width:8.0),
          tweetBody(),
          SizedBox(height: 8.0),

        ],
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: AssetImage(post.userUrl),
      ),
    );
  }




  Widget tweetBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          tweetText(),


        ],
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            post.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),

      ],
    );
  }

  Widget tweetText() {
    return Text(
      post.text,
      overflow: TextOverflow.clip,
    );
  }



  Widget tweetIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.black45,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
*/
