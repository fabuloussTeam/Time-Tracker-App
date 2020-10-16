import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/sign_in/email_sign_in_model.dart';
import 'package:timetrackerapp/app/sign_in/validators.dart';
import 'package:timetrackerapp/common_widgets/form_submit_button.dart';
import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_bloc.dart';

// Utilisation des Mixin: en ajoutan" with EmailAndPasswordValidators
class EmailSignInFormBlocBased extends StatefulWidget with EmailAndPasswordValidators {
  final EmailSignInBloc bloc;
  EmailSignInFormBlocBased({@required this.bloc});

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
        create: (context) => EmailSignInBloc(auth: auth),
       child: Consumer<EmailSignInBloc>(
           builder: (context, bloc, _) => EmailSignInFormBlocBased(bloc: bloc),
       ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() => _EmailSignInFormBlocBasedState();
}

//mainAxisSize permet mettre la hauteur sur l'espace ocuuper nette
class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


// Fonction de connection / Creation compte
  Future<void> _submit(BuildContext context) async {
    try{
          await widget.bloc.submit();
          print("Sorti de la submi here");
        if(widget.bloc.submit() != null){
           Navigator.of(context).pop();
         }
    } catch(e){
      print("sotie erreur ${e.toString()}");
    }
  }

  // _emailEditingComplete
  void _emailEditingComplete(EmailSignInModel model){
    final newFocus = widget.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType(EmailSignInModel model){
    widget.bloc.updateWith(
      email: "",
      password: "",
      formType: (model.formType == EmailSignInFormType.signin)
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin,
      isLoading: false,
      submitted: false,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  List<Widget> _buildChildren(BuildContext context, EmailSignInModel model){
    final primaryText = model.formType == EmailSignInFormType.signin ? "Sign in" : "Create an account";
    final secondaryText = model.formType == EmailSignInFormType.signin ? "Need an account? register" : "Have an account? Sign in";
    //  print(secondaryText);

    // Verifie que le champ email et password est remplit
    bool submitEnable = widget.emailValidator.isValid(model.email) && widget.passwordValidator.isValid(model.password) && ! model.isLoading;
    bool showErrorTextEmail = model.submitted && ! widget.emailValidator.isValid(model.email);
    bool showErrorTextPassword = model.submitted && ! widget.emailValidator.isValid(model.password);


    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@gmail.com',
            errorText: showErrorTextEmail ? widget.invalidEmailErrorText : null,
            enabled: model.isLoading == false
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocusNode,
        onEditingComplete: () =>_emailEditingComplete(model),
        onChanged: (email) => widget.bloc.updateWith(email: email),
      ),
      SizedBox(height: 8.0,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            labelText: 'Password',
            errorText: showErrorTextPassword ?  widget.invalidPasswordErrorText : null,
            enabled: model.isLoading == false
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        onEditingComplete: () => _submit(context),
        onChanged: (password) => widget.bloc.updateWith(password: password),
      ),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        onPressed: submitEnable ? () => _submit(context) : null,
        text: primaryText,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        onPressed: !model.isLoading ? () =>_toogleFormType(model) : null,
        child: Text(secondaryText),
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(context, model)
          ),
        );
      }
    );
  }

}
