import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/sign_in/validators.dart';

import 'email_sign_in_form_stateful.dart';


class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  EmailSignInChangeModel({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailSignInFormType.signin
  });

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