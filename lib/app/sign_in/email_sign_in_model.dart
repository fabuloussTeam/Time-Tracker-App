enum EmailSignInFormType { signin, register }

class EmailSignInModel {
  final String email;
  final String password;
  final bool isLoading;
  final bool submitted;
  final EmailSignInModel formType;

  EmailSignInModel({this.email, this.password, this.isLoading, this.submitted, this.formType});
}