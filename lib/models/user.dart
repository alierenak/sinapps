class user {

  String username;
  String fullname;
  String photoUrl;
  String phoneNumber;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  String description;

  user({this.username, this.fullname, this.followers, this.following, this.posts, this.description, this.photoUrl, this.phoneNumber});

  user.fromData(Map<String, dynamic> data)
  : username = data['username'],
  fullname = data['fullname'],
  followers = data['followers'],
  following = data['following'],
  posts = data['posts'],
  description = data['description'],
  photoUrl = data['photoUrl'],
  phoneNumber = data['phoneNumber'];

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
    };
  }
}