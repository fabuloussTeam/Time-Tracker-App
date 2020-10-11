import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/home_page.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_page.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/auth_provider.dart';

class LandingPage extends StatelessWidget {

  // On a retirer les call back function. On a StreamBuilder + onAuthStateChange pour changer de page
  // Ici le state se met automatiquement a jour avec la function Stream onAuthStateChange dans auth.dart
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<UserModel>(
        stream: auth.onAuthStateChange,
        // ignore: missing_return
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            UserModel user = snapshot.data;
            if(user == null){
              return SignInPage();
            }
            return HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
    );

  }
}
