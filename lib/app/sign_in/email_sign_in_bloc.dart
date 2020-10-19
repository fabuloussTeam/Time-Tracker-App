import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/sign_in/email_sign_in_model.dart';
import 'package:timetrackerapp/services/auth.dart';

class EmailSignInBloc {

  final AuthBase auth;
  final BuildContext context;
  EmailSignInBloc({@required this.auth, this.context});

  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose(){
    _modelController.close();
  }

  void toogleFormType(){
    final formType = (_model.formType == EmailSignInFormType.signin)
        ? EmailSignInFormType.register
        : EmailSignInFormType.signin;
    updateWith(
      email: "",
      password: "",
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }


  // Creation de la  Function submit
Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try{
      // ignore: unrelated_type_equality_checks
      if(_model.formType == EmailSignInFormType.signin){
        var response =  await auth.signInWithEmailAndPassword(_model.email, _model.password, context);
         if(response != null){
           print("connecter au dashboard $response");
            Navigator.of(context).pop(this);
         } else {
            print("Non connecté au dashboard $response");
         }
      } else {
         await auth.createUserWithEmailAndPassword(_model.email, _model.password, context);
      }
    } catch(e){
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

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