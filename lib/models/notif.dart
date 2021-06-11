import 'package:sinapps/models/notif.dart';

class Notif {
  String userPhotoURL;
  String username;
  String notifType;
  String pid;
  String uid;
  String otherUid;
  String postPhotoURL;
  String notifID;
//String date;

  Notif({this.userPhotoURL, this.username, this.notifType, this.pid = "", this.uid, this.otherUid, this.postPhotoURL = "", this.notifID});
}
