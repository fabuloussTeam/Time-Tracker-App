import 'package:flutter/material.dart';
import 'package:timetrackerapp/services/auth.dart';

class HomePage extends StatelessWidget {

// Initialisation de la callback function qui est appele pr la déconnection
  final AuthBase auth;
  HomePage({this.auth});

  // Fonction de deconnection.
  Future<void> _signOut() async {
    try {
         await auth.signOut();
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
