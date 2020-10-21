import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_form_bloc_based.dart';
import 'email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }


}


