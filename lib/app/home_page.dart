import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/services/auth.dart';

class HomePage extends StatelessWidget {

// Initialisation de la callback function qui est appele pr la déconnection
  final VoidCallback onSignOut;
  final AuthBase auth;
  HomePage({this.auth, @required this.onSignOut});

  // Fonction de deconnection.
  Future<void> _signOut() async {
    try {
         await auth.signOut();
         // await FirebaseAuth.instance.signOut();
         onSignOut();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          FlatButton(
              onPressed: _signOut,
              child: Text("Logout", style: TextStyle(fontSize: 18.0, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
