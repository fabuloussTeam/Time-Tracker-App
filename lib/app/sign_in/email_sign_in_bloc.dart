import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/sign_in/email_sign_in_model.dart';
import 'package:timetrackerapp/services/auth.dart';

class SignInEmailBloc {

  final AuthBase auth;
  SignInEmailBloc({@required this.auth});

  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose(){
    _modelController.close();
  }

  // Creation de la  Function submit

  void submit() async {
    updateWith(submitted: true, isLoading: true);
    try{
      // ignore: unrelated_type_equality_checks
      if(_model.formType == EmailSignInFormType.signin){
         await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
         await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }
    } catch(e){
     rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }


  // Function de mise a jour des element du
  // formulaire a partir de la function copyWith du model EmailSignInModel
  void updateWith({
  String email,
  String password,
  EmailSignInFormType formType,
  bool isLoading,
  bool submitted
}){
    // update model
   _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted
    );

   _modelController.add(_model);
  }

}