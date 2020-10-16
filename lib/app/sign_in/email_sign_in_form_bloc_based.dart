import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/sign_in/email_sign_in_model.dart';
import 'package:timetrackerapp/app/sign_in/validators.dart';
import 'package:timetrackerapp/common_widgets/form_submit_button.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';

import 'email_sign_in_bloc.dart';

// Utilisation des Mixin: en ajoutan" with EmailAndPasswordValidators
class EmailSignInFormBlocBased extends StatefulWidget {
  final EmailSignInBloc bloc;
  EmailSignInFormBlocBased({@required this.bloc});

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
        create: (context) => EmailSignInBloc(auth: auth, context: context),
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
  Future<void> _submit() async {
    try{
           // ignore: unnecessary_statements
           await widget.bloc.submit();

    } catch(e){
      print("sotie erreur xxxx ${e.toString()}");
      PlatformAlertDialog(
        title: "Create account failed",
        content: "The email address is badly formatted.",
        defaultActionText: "OK",
      ).show(context);
    }
  }

  // _emailEditingComplete
  void _emailEditingComplete(EmailSignInModel model){
    final newFocus = model.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType(){
    widget.bloc.toogleFormType();
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
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@gmail.com',
            errorText: model.showTextErrorEmail,
            enabled: model.isLoading == false
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocusNode,
        onEditingComplete: () =>_emailEditingComplete(model),
        onChanged: widget.bloc.updateEmail,
      ),
      SizedBox(height: 8.0,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            labelText: 'Password',
            errorText: model.showTextErrorPassword,
            enabled: model.isLoading == false
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        onEditingComplete: _submit,
        onChanged: widget.bloc.updatePassword
      ),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        onPressed: model.canSubmit ? _submit : null,
        text: model.primaryButtonText,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        onPressed: !model.isLoading ? _toogleFormType : null,
        child: Text(model.secondaryButtonText),
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
        print("email is: ${model.email} and password is: ${model.password}");
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
