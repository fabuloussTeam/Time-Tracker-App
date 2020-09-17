import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/home_page.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  User _user; // Come from firebase_auth

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  // Retrive the current user if connected
  Future<void> _checkCurrentUser() async {
    User user =  FirebaseAuth.instance.currentUser;
    _updateUser(user);
  }

  // update user state to redirect forward SignIn page or Home Page
  void _updateUser(User user){
   setState(() {
     _user = user;
   });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInPage(
        onSignIn: _updateUser,
      );
    }

    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
