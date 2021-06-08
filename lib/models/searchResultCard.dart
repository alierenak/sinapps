import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/searchResult.dart';
import 'package:sinapps/routes/otherProfilePage.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/postPage.dart';
class SearchResultCard extends StatelessWidget {

  final SearchResult sr;
  final String itType;
  SearchResultCard({this.sr, this.itType});





  @override
  Widget build(BuildContext context) {
    if (itType == "user") {
      return GestureDetector(
        onTap: () async {
          var otherUser = await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: sr.itemID)
              .get();
          FirebaseAuth _auth;
          User _user;
          _auth = FirebaseAuth.instance;
          _user = _auth.currentUser;
          if (otherUser.docs[0]['uid'] == _user.uid) {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => Profile()));
          }
          else {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtherProfilePage(
                            otherUser: user.fromDocument(otherUser.docs[0]))));
          }
        },
        child: Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(sr.photoUrl),
                  radius: 32.0,
                ),
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(sr.photoUrl),
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sr.identifier,
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              sr.description,
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
              ],
            ),
          ),
        ),
      );
    }
    else {
      return GestureDetector(
        onTap: () async {
          var otherPost = await FirebaseFirestore.instance
              .collection('posts')
              .where('pid', isEqualTo: sr.itemID)
              .get();
          FirebaseAuth _auth;
          User _user;
          _auth = FirebaseAuth.instance;
          _user = _auth.currentUser;

            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        PostPage(
                            post: Post.fromDocument(otherPost.docs[0]))));

        },
        child: Card(
          color: Colors.grey[200],
          margin: EdgeInsets.fromLTRB(7, 6, 7, 6),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(sr.photoUrl),
                  radius: 32.0,
                ),
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: AppColors.textColor1,
                    child: NetworkImage(sr.photoUrl),
                  ),
                ),*/
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sr.identifier,
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 16,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              sr.description,
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
              ],
            ),
          ),
        ),
      );
    }
  }
}