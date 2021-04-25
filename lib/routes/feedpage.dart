import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/PostCard.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

List<Post> posts = [
  Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/SuIC.jpg", location:'Istanbul-Acıbadem', text:'Wanna swap shifts?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 ),
  Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/googleCampus.jpg", location:'Istanbul-Acıbadem', text:'I am going to Google Campus. Does anyone want to come?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 ),
  Post( username: 'mertture0', userUrl:"lib/images/cat.jpg", photoUrl:"lib/images/cat.jpg", location:'Istanbul-Acıbadem', text:'How old is this cat?', date: '23 April 2021', likes:9, dislikes: 3, comments:3 )
];

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: SafeArea(
        top: false,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: AppColors.primary,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            width:double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: posts.map((post) => PostCard(
                    post: post,
                    delete: () {
                      setState(() {
                        posts.remove(post);
                      });
                    }
                )).toList(),
              ),
            ),
          ),
        ),
      ),
    );

  }
}


