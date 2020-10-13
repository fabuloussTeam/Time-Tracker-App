import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_bloc.dart';
import 'package:timetrackerapp/app/sign_in/sign_in_button.dart';
import 'package:timetrackerapp/app/sign_in/socialSignInButton.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'dart:async';

import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_page.dart';



//On est quitter du statefull au state less prck le state isLoading ne ce charge plus ici, mais dans le fichier sign_in_block
class SignInPage extends StatelessWidget {

  static Widget create(BuildContext context) {
    return Provider<SignInBlock>(
      create: (_) => SignInBlock(),
      child: SignInPage(),
    );
  }

  void _signInError(BuildContext context, PlatformException e) {
    PlatformAlertDialog(
      title: "Sign In failed",
      content: e.message,
      defaultActionText: "OK",
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final bloc = Provider.of<SignInBlock>(context, listen: false);
    try {
      //setState(() => _isLoading = true);
       bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously(
      );
    } catch (e) {
      print(
          "${e.toString(
          )}");
      if (e.code == "network_error") {
        PlatformAlertDialog(
          title: "Sign In failed",
          content: "No Connection find!",
          defaultActionText: "OK",
        ).show(
            context);
      } else {
        _signInError(
            context, e);
      }
    } finally {
     // setState(() => _isLoading = false);
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final bloc = Provider.of<SignInBlock>(context, listen: false);
    try {
     // setState(()=> _isLoading = true);
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle(
      );
    } catch (e) {
      print(
          "${e.toString(
          )}");
      _signInError(
          context, e);
    } finally {
      //setState(()=> _isLoading = false);
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final bloc = Provider.of<SignInBlock>(context, listen: false);
    try {
     // setState(()=> _isLoading = true);
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } catch (e) {
      print("${e.toString()}");
      _signInError(context, e);
    } finally {
    ///  setState(()=> _isLoading = false);
      bloc.setIsLoading(false);

    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBlock>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
        elevation: 2.0,
      ),
      //on A initialiser les donne a false prck notre block.isLoadingStream
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildContaint(context, snapshot.data);
        }
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContaint(BuildContext context, bool isLoading){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildheader(isLoading),
          SizedBox(height: 48.0,),
          SocialSignInButton(
            assetName: "images/google-logo.png",
            text: "Sign in with Google",
            textColor: Colors.black87,
            color: Colors.white,
            onPress: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 8.0,),
          SocialSignInButton(
              assetName: "images/facebook-logo.png",
              text:"Sign in with Facebook",
              color: Color(0xFF334D92),
              textColor: Colors.white,
              onPress: isLoading ? null : () =>_signInWithFacebook(context)
          ),
          SizedBox(height: 8.0,),
          SignInButton(
              text:"Sign in with email",
              color: Colors.teal[700],
              textColor: Colors.white,
              onPress: isLoading ? null : () => _signInWithEmail(context)

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
              onPress: isLoading ? null : ()=>_signInAnonymously(context)
          ),
        ],
      ),
    );
  }


  Widget _buildheader(bool isLoading){
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      "Sign in",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600
      ),
    );
  }
}
