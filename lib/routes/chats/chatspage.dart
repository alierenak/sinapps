import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/utils/colors.dart';
import 'conversationpage.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/chats/startConversation.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key key, this.currentUser}) : super(key: key);
  final user currentUser;

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String userId;
  String name;
  String message;

  @override
  Widget build(BuildContext context) {
    userId = widget.currentUser.uid;
    var otherUserIds = widget.currentUser.following;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      startConversation(currentUser: widget.currentUser)));
        },
        child: IconButton(
          icon: Icon(Icons.chat_bubble),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Message",
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .where("members", arrayContains: userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            //crashlytics
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            //crashlytics
            return Text("Loading...");
          }

          return ListView(
            children: snapshot.data.docs
                .map((doc) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("lib/images/pp.png"),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(
                        doc["otherUsername"],
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        doc["displayMessage"],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Column(
                        children: [
                          Text("19:30"),
                          Container(
                            margin: EdgeInsets.all(4),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConversationPage(
                                      userId: userId,
                                      otherUsername: "mert",
                                      conversationId: userId + otherUserIds[1],
                                    )));
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
