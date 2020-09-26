import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
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

  // Function de connection de facon anonyme
  Future<UserModel> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
   // print(_userFromFirebase(authResult.user).uid);
    return _userFromFirebase(authResult.user);
  }

  // Function de connection avec Google
  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUserAccount = await googleSignIn.signIn();
    if(googleUserAccount != null){
      GoogleSignInAuthentication googleAuth = await googleUserAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        final authResult = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken
            )
        );
        print("Le nom d'affichage : ${authResult.user.displayName}");
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
          message: "Misson Google Auth Token",
        );
      }
    } else {
      throw PlatformException(
        code: "ERROR_ABORTED_BY_USER",
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {

    final LoginResult result = await FacebookAuth.instance.login();
    // Create a credential from the access token

     if(result != null){
       final FacebookAuthCredential facebookAuthCredential =
       FacebookAuthProvider.credential(result.accessToken.token);
       final authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
       return _userFromFirebase(authResult.user);
     } else {
       throw PlatformException(
         code: "ERROR_ABORTED_BY_USER",
         message: 'Sign in aborted by user',
       );
     }
    // Once signed in, return the UserCredential
  }

  // Fonction de deconnectio
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}