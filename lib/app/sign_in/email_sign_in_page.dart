import 'package:flutter/material.dart';
import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {

  final AuthBase auth;
  EmailSignInPage({@required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            child: _builContext(context),
        ),
      )
    );
  }

  Widget _builContext(BuildContext context) {
    return EmailSignInForm(auth: auth);
  }
}


