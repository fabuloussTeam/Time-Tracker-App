import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/home_page.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_page.dart';
import 'package:timetrackerapp/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;
  LandingPage({this.auth});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  UserModel _user; // Come from UserMoodel class

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  // Retrive the current user if connected
  Future<void> _checkCurrentUser() async {
    UserModel currUser = await widget.auth.currentUser();
    // User user =  FirebaseAuth.instance.currentUser;
    _updateUser(currUser);
  }

  // update user state to redirect forward SignIn page or Home Page
  void _updateUser(UserModel user){
   setState(() {
     _user = user;
   });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }

    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
