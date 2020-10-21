import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/sign_in/validators.dart';
import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_form_stateful.dart';


class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  final AuthBase auth;

  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailSignInFormType.signin
  });


  // Creation de la  Function submit
  Future<void> submit(context) async {
    updateWith(submitted: true, isLoading: true);
    try{
      // ignore: unrelated_type_equality_checks
      if(formType == EmailSignInFormType.signin){
         var response =  await auth.signInWithEmailAndPassword(email, password, context);
        if(response != null){
          print("connecter au dashboard $response");
          Navigator.of(context).pop(this);
        } else {
          print("Non connecté au dashboard $response");
        }
      } else {
        await auth.createUserWithEmailAndPassword(email, password, context);
      }
    } catch(e){
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }


  void  toogleFormType(){
    final formType = (this.formType == EmailSignInFormType.signin)
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

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);


  String get primaryButtonText {
    return formType == EmailSignInFormType.signin
      ? "Sign in"
      : "Create an account";
   }
   String get secondaryButtonText {
    return formType == EmailSignInFormType.signin
         ? "Need an account? register"
         : "Have an account? Sign in";
   }

   bool get canSubmit {
     return emailValidator.isValid(email) &&
         passwordValidator.isValid(password) &&
         ! isLoading;
   }

   String get showTextErrorEmail {
     bool showErrorText = submitted && !emailValidator.isValid(email);
     return showErrorText ? invalidEmailErrorText : null;
   }

   String get showTextErrorPassword {
    bool showErrorText = submitted && !emailValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
   }

  // Creation d'une copy de EmailSignInModel coe c'est immutable
 void updateWith( {
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted
  } ) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.formType = formType ?? this.formType;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
  }
}
