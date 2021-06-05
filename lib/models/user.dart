import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String username;
  String fullname;
  String photoUrl;
  String phoneNumber;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  String description;
  bool profType;
  String uid;
  String activation;
  user(
      {this.username,
      this.fullname,
      this.followers,
      this.following,
      this.posts,
      this.description,
      this.photoUrl,
      this.phoneNumber,
      this.profType,
      this.uid,
      this.activation});

  user.fromData(Map<String, dynamic> data)
      : username = data['username'],
        fullname = data['fullname'],
        followers = data['followers'],
        following = data['following'],
        posts = data['posts'],
        description = data['description'],
        photoUrl = data['photoUrl'],
        phoneNumber = data['phoneNumber'],
        profType = data['profType'],
        uid = data['uid'],
        activation = data['activation'];

  factory user.fromDocument(DocumentSnapshot doc) {
      return user(
       username: doc['username'],
        fullname: doc['fullname'],
        followers: doc['followers'],
        following: doc['following'],
        posts: doc['posts'],
        description: doc['description'],
        photoUrl: doc['photoUrl'],
        phoneNumber: doc['phoneNumber'],
        profType: doc['profType'],
        uid: doc['uid'],
        activation: doc['activation'],
    );
  }




  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'followers': followers,
      'following': following,
      'posts': posts,
      'description': description,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'profType': profType,
      'uid': uid,
      'activation': activation
    };
  }

  //String getUsername(String userid) {
  //  if (uid == userid) return username;
  // }
}

//List<user> allUsers;
