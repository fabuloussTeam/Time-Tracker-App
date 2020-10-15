enum EmailSignInFormType { signin, register }

class EmailSignInModel {
  final String email;
  final String password;
  final EmailSignInModel formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel({this.email, this.password, this.isLoading, this.submitted, this.formType});

  // Creation d'une copy de EmailSignInModel coe c'est immutable
   copyWith( {email, password, formType, isLoading, submitted} ) {
    EmailSignInModel(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted
    );
  }
}