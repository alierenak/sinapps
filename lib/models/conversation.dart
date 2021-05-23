import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sinapps/routes/profilepage.dart';
import 'package:sinapps/models/user.dart';

class Conversation {
  String id;
  String username;
  String photoUrl;
  String displaymessage;

  Conversation(
      this.id,
      this.username,
      this.photoUrl,
      this.displaymessage,
      );

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot, user otherUser) {
    return Conversation(
      snapshot.id,
      otherUser.username,
      otherUser.photoUrl,
      snapshot['displaymessage'],
    );
  }
}