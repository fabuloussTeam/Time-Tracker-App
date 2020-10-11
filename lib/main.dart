import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/landing_page.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // create the initialization Future outside of 'build'
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: FutureBuilder(
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
                home: LandingPage(),
              );
            }
            return CircularProgressIndicator();
          },
      ),
    );
  }
}
