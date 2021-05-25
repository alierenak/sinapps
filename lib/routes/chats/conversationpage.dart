import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/models/user.dart';
import 'package:sinapps/routes/chats/chatspage.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/models/conversation.dart';

class ConversationPage extends StatefulWidget {
  final String otherUsername;
  final user currUser;
  final String conversationId;
  final List<dynamic> members;
  final String photoUrl;

  final String otherPhotoUrl;

  const ConversationPage({
    Key key,
    this.otherPhotoUrl,
    this.photoUrl,
    this.otherUsername,
    this.currUser,
    this.conversationId,
    this.members,
  }) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  CollectionReference _ref;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection("chats/${widget.conversationId}/messages");
  }

  void sent() {
    checkIfSent = true;
    print("sent");
  }

  bool checkIfSent = false;
  @override
  Widget build(BuildContext context) {
    String otherUser;
    String showPhoto;
    if (widget.currUser.photoUrl == widget.photoUrl) {
      showPhoto = widget.otherPhotoUrl;
    } else {
      showPhoto = widget.photoUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        titleSpacing: -5,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(showPhoto),
              backgroundColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.otherUsername,
                style: TextStyle(
                  fontFamily: 'BrandonText',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatsPage(
                            currentUser: widget.currUser,
                          )),
                );
              }),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatsPage(
                            currentUser: widget.currUser,
                          )));
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream:
                    _ref.orderBy("timeStamp", descending: false).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return !snapshot.hasData
                      ? CircularProgressIndicator()
                      : ListView(
                          children: snapshot.data.docs
                              .map(
                                (doc) => ListTile(
                                  title: Align(
                                    alignment:
                                        widget.currUser.uid == doc["senderId"]
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        doc["message"],
                                        style: TextStyle(
                                          fontFamily: 'BrandonText',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[500],
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(10),
                                              right: Radius.circular(10))),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                }),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      controller: _editingController,
                      style: TextStyle(
                        fontFamily: 'BrandonText',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type...",
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                        hintStyle: TextStyle(
                          fontFamily: 'BrandonText',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    sent();
                    await _ref.add({
                      "senderId": widget.currUser.uid,
                      "message": _editingController.text,
                      "display": _editingController.text,
                      "timeStamp": DateTime.now(),
                    });
                    _editingController.clear();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
