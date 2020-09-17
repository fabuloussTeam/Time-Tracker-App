import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// Model User
class User {
  String uid;
  User({@required this.uid});
}

class Auth {

  final _firebaseAuth = FirebaseAuth.instance;


  // Le premier User est implementation du model
  User _userFromFirebase(User user){
    if(user == null){
      return null;
    }
    return User(uid: user.uid);
  }


  Future<User> currentUser() async {
    final currentUser =   _firebaseAuth.currentUser;
    return _userFromFirebase(currentUser as User);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    print(_userFromFirebase(authResult.user as User));
    return _userFromFirebase(authResult.user as User);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}