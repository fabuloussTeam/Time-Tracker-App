enum EmailSignInFormType { signin, register }

class EmailSignInModel {
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