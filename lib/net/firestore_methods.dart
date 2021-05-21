import 'package:sinapps/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirestoreService {
    final FirestoreService _firestoreService = FirestoreService();
    final CollectionReference _usersCollectionReference =
        FirebaseFirestore.instance.collection('users');

    User _currentUser;
    User get currentUser => _currentUser;

    Future getUser(String uid) async {
      try {
        var userData = await _usersCollectionReference.doc(uid).get();
      } catch(e) {
        return e.message;
      }
    }

    Future _populateCurrentUser (User cUser) async{
      if (user != null) {
        _currentUser = await _firestoreService.getUser(cUser.phoneNumber);
      }
    }
}