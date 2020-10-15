import 'dart:async';

import 'package:timetrackerapp/app/sign_in/email_sign_in_model.dart';

class SignInEmailBloc {
  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  void dispose(){
    _modelController.close();
  }
}