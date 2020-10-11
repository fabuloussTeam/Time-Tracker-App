import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';

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
  Future<UserModel> signInWithEmailAndPassword(String email, String password, {BuildContext context});
  Future<UserModel> createUserWithEmailAndPassword(String email, String password, {BuildContext context});
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

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password, {context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        PlatformAlertDialog(
          title: "Sign in failed",
          content: "No user found for that email.",
          defaultActionText: "OK",
        ).show(context);
      } else if (e.code == 'wrong-password') {
        print(e.toString());
        PlatformAlertDialog(
          title: "Sign in failed",
          content: "Wrong password. Please retry!",
          defaultActionText: "OK",
        ).show(context);
      } else if (e.code == 'invalid-email'){
        PlatformAlertDialog(
          title: "Create account failed",
          content: "The email address is badly formatted.",
          defaultActionText: "OK",
        ).show(context);
      }
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password, {context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('The password provided is too weak. Should be at least 6 characters');
        PlatformAlertDialog(
          title: "Create account failed",
          content: "The password provided is too weak. Should be at least 6 characters",
          defaultActionText: "OK",
        ).show(context);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        PlatformAlertDialog(
          title: "Create account failed",
          content: "The account already exists for that email.",
          defaultActionText: "OK",
        ).show(context);
      } else if (e.code == 'invalid-email'){
        PlatformAlertDialog(
          title: "Create account failed",
          content: "The email address is badly formatted.",
          defaultActionText: "OK",
        ).show(context);
      }
    } catch (e) {
      print(e);
      PlatformAlertDialog(
        title: "Create account failed",
        content: e.toString(),
        defaultActionText: "OK",
      ).show(context);
    }
  }

  // Fonction de deconnection
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}