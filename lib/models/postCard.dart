import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'post.dart';

class PostCard extends StatelessWidget {

  final Post post;
  final Function delete;
  PostCard({ this.post, this.delete });

  @override

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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

                    SizedBox(width: 20.0),

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

                        SizedBox(height: 8.0),

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
                      fontFamily: 'BrandonText',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),






            SizedBox(height: 12.0),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  post.date,
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(width: 8.0),

                Icon(
                  Icons.thumb_up,
                  size: 16.0,
                  color: AppColors.primary,
                ),
                Text(
                  '${post.likes}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(width: 8.0),

                Icon(
                  Icons.thumb_down,
                  size: 16.0,
                  color: AppColors.third,
                ),

                Text(
                  '${post.dislikes}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(width: 8.0),

                Icon(
                  Icons.comment,
                  size: 16.0,
                ),

                Text(
                  '${post.comments}',
                  style: TextStyle(
                    fontFamily: 'BrandonText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),



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
