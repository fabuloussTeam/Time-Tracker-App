import 'package:flutter/material.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/auth_provider.dart';

class HomePage extends StatelessWidget {

// Initialisation de la callback function qui est appele pr la déconnection

  // Fonction de deconnection.
  Future<void> _signOut(BuildContext context) async {
    final auth = AuthProvider.of(context);
    try {
         await auth.signOut();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: "Logout",
      content: "Are you sure you want to logout?",
      cancelActionText: "Cancel",
      defaultActionText: "Logout",
    ).show(context);
    print(didRequestSignOut);
    if(didRequestSignOut == true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          FlatButton(
              onPressed: () => confirmSignOut(context),
              child: Text("Logout", style: TextStyle(fontSize: 18.0, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
