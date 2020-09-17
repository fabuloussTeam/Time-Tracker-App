import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_button.dart';
import 'package:timetrackerapp/app/sign_in/socialSignInButton.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

Future<void> _signInAnonymously() async {
  try {
    final  authResult = await FirebaseAuth.instance.signInAnonymously();
    print("${authResult.user.uid}");
  } catch (e) {
    print("${e.toString()}");
  }

}

 @override
 Widget build(BuildContext context) {

    Widget _buildContaint(){
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 48.0,),
            SocialSignInButton(
              assetName: "images/google-logo.png",
              text: "Sign in with Google",
              textColor: Colors.black87,
              color: Colors.white,
              onPress: (){},
            ),
            SizedBox(height: 8.0,),
            SocialSignInButton(
                assetName: "images/facebook-logo.png",
                text:"Sign in with Facebook",
                color: Color(0xFF334D92),
                textColor: Colors.white,
                onPress: (){}
            ),
            SizedBox(height: 8.0,),
            SignInButton(
                text:"Sign in with email",
                color: Colors.teal[700],
                textColor: Colors.white,
                onPress: (){}
            ),
            SizedBox(height: 8.0,),
            Text(
              "or",
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0,),
            SignInButton(
                text:"Go anonymous",
                color: Colors.lime[300],
                textColor: Colors.black87,
                onPress: _signInAnonymously
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Container(
          child: _buildContaint()
      ),
      backgroundColor: Colors.grey[200],
    );

  }

}
