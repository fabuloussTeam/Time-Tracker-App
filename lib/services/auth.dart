import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// Model User
class UserModel {
  String uid;
  UserModel({@required this.uid});
}

// Creation d'une abstrac class
abstract class AuthBase {
  Stream<UserModel> get onAuthStateChange;
  Future<UserModel> currentUser();
  Future<UserModel> signInAnonymously();
  Future<void> signOut();
}

// Implementation de l'abstract class
class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;

  // Le premier User est implementation du model
  UserModel _userFromFirebase(User user){
    if(user == null){
      return null;
    }
    return UserModel(uid: user.uid);
  }

  // Creation d'un stream: pour le changement d'etat
  @override
  Stream<UserModel> get onAuthStateChange {
     return _firebaseAuth.authStateChanges().map(((user) => _userFromFirebase(user)));
  }


  // Utilisateur courant
  Future<UserModel> currentUser() async {
    final currentUser =   _firebaseAuth.currentUser;
    return _userFromFirebase(currentUser);
  }

  // Connection de connection de facon anonyme
  Future<UserModel> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
   // print(_userFromFirebase(authResult.user).uid);
    return _userFromFirebase(authResult.user);
  }

  // Fonction de deconnectio
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}