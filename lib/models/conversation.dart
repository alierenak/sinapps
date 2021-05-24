import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/models/user.dart';

class Conversation {
  String displayMessage;
  String conversationID;
  String otherUsername;
  String photoUrl;
  List<String> members;

  Conversation(
    this.displayMessage,
    this.conversationID,
    this.otherUsername,
    this.members,
    this.photoUrl,
  );

/*
  factory Conversation.fromSnapshot(DocumentSnapshot snapshot, user otherUser) {
    return Conversation(
      snapshot.id,
      otherUser.username,
      otherUser.photoUrl,
      snapshot['displaymessage'],
    );
  } */
}
