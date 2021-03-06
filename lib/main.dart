import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/landing_page.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_page.dart';
import 'package:timetrackerapp/services/auth.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // create the initialization Future outside of 'build'
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Something Went Wrong");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LandingPage(
                auth: Auth(),
              ),
            );
          }

          return CircularProgressIndicator();
        },
    );
  }
}
