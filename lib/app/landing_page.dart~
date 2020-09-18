import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/home_page.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_page.dart';
import 'package:timetrackerapp/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;
  LandingPage({this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: auth.onAuthStateChange,
        // ignore: missing_return
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            UserModel user = snapshot.data;
            if(user == null){
              return SignInPage(
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
            );
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
