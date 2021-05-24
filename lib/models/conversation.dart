import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/models/user.dart';

class Conversation {
  String conversationID;
  String otherUsername;
  String photoUrl;
  List<String> members;
  String displaymessage;

  Conversation(
    this.conversationID,
    this.otherUsername,
    this.photoUrl,
    this.members,
    this.displaymessage,
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
