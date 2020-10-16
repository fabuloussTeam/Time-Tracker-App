import 'package:timetrackerapp/app/sign_in/validators.dart';

enum EmailSignInFormType { signin, register }

class EmailSignInModel with EmailAndPasswordValidators {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel({
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
  EmailSignInModel copyWith( {
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted
  } ) {
   return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted
    );
  }
}