import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sinapps/models/comment.dart';
import 'package:sinapps/models/commentCard.dart';
import 'package:sinapps/models/post.dart';
import 'package:sinapps/models/postCard.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPage extends StatefulWidget {

  const CommentPage({Key key, this.post}) : super(key: key);
  final Post post;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  List<dynamic> comments = [];
  String newComment;
  user currentUser;
  String currentUserPhoto = "https://firebasestorage.googleapis.com/v0/b/sinapps0.appspot.com/o/profilepictures%2FScreen%20Shot%202021-06-06%20at%2023.43.18.png?alt=media&token=6c28fb47-2924-4b74-a3d6-b47a3844fea0";

  loadingScreen(context) {
    return [
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
                "Comments loading...",
                style: TextStyle(
                    color: AppColors.textColor
                )
            )
          ],
        ),
      )
    ];
  }

  void loadUserInfo() async {

    FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _user.uid)
        .get();

    currentUser = user(
        followers: x.docs[0]['followers'],
        following: x.docs[0]['following'],
        username: x.docs[0]['username'],
        fullname: x.docs[0]['fullname'],
        phoneNumber: x.docs[0]['phoneNumber'],
        photoUrl: x.docs[0]['photoUrl'],
        description: x.docs[0]['description'],
        profType: x.docs[0]['profType'],
        uid: x.docs[0]['uid']
    );

    setState(() {
      currentUserPhoto = currentUser.photoUrl;
    });

  }

  void loadComments() async {
    var post = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.post.pid).get();

    List<dynamic> listOfcids = post['comments'];

    for(int i=0; i< listOfcids.length; i++) {

      var comment = await FirebaseFirestore.instance
          .collection('comments')
          .doc(listOfcids[i]).get();

      setState(() {
        print("Comment added!");
        comments.add(
          Comment(
              cid: comment['cid'],
              postid: comment['postid'],
              userid: comment['userid'],
              userPhotoURL: comment['userPhotoURL'],
              content: comment['content'],
              likes: comment['likes'],
          )
        );
        print("Hello");
      });
    }
  }

  void addComment() async {

    Comment c = Comment(
        userid: currentUser.uid,
        userPhotoURL: currentUserPhoto,
        content: newComment,
        likes: []
    );

    final CollectionReference comments = FirebaseFirestore.instance.collection('comments');
    try {
      var com_ref = comments.doc();
      await com_ref.set({
        "postid": widget.post.pid,
        "cid": com_ref.id,
        "userid": currentUser.uid,
        "userPhotoURL": currentUserPhoto,
        "content": newComment,
        "likes": []
      });

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.post.pid).update({
        "comments": FieldValue.arrayUnion([com_ref.id]),
      });

      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Comment added!"), duration: Duration(milliseconds: 300), ), );
      Navigator.push(context,MaterialPageRoute(builder: (context) => CommentPage(post: widget.post)));

    } catch (e) {
      print(e);
      return;
    }
  }

  void initState() {
    super.initState();
    // LOAD CURRENT USER
    loadUserInfo();
    loadComments();
    // LOAD COMMENTS

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Home",
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[800],
            elevation: 0.0,

        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                  children: [
                    // POST
                    PostCard(post: widget.post,),
                    // COMMENTS
                    Column(
                      children: comments.map((comment) => CommentCard(
                          comment: comment,
                          delete: () {
                            setState(() {
                              comments.remove(comment);
                            });
                          }
                      )).toList(),
                    ),
                  ],
                )
            ),

            // WRITE A COMMENT VIEW
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey[300],
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUserPhoto),
                        radius: 35.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 6/10,
                            child: TextField(
                              onChanged: (value){
                                setState(() {
                                  newComment = value;
                                });
                              } ,
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                              minLines: 1,
                              maxLines: 2,
                              autocorrect: false,
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "What are you thinking?",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_comment,
                          color: AppColors.primary,
                        ),
                        onPressed: () => {
                          addComment()
                        },
                      )
                    ],
                  )
              ),
            )
          ],
        )
    );
  }
}
