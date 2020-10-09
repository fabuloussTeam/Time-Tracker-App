import 'package:flutter/material.dart';
import 'package:timetrackerapp/common_widgets/form_submit_button.dart';
import 'package:timetrackerapp/services/auth.dart';


enum EmailSignInFormType { signin, register }

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;
  EmailSignInForm({@required this.auth});
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

//mainAxisSize permet mettre la hauteur sur l'espace ocuuper nette
class _EmailSignInFormState extends State<EmailSignInForm> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  var _formType = EmailSignInFormType.signin;


// Fonction de connection / Creation compte
  void _submit() async {
        try{
          if(_formType == EmailSignInFormType.signin){
            await widget.auth.signInWithEmailAndPassword(_email, _password);
          } else {
            await widget.auth.createUserWithEmailAndPassword(_email, _password);
          }
          Navigator.of(context).pop();
        } catch(e){
            print(e.toString());
        }
  }

  void _toogleFormType(){
    setState(() {
      _formType = (_formType == EmailSignInFormType.signin) ? EmailSignInFormType.register : EmailSignInFormType.signin;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    final primaryText = _formType == EmailSignInFormType.signin ? "Sign in" : "Create an account";
    final secondaryText = _formType == EmailSignInFormType.signin ? "Need an account? register" : "Have an account? Sign in";
  //  print(secondaryText);
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@gmail.com',
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
      SizedBox(height: 8.0,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
      ),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        onPressed: _toogleFormType,
        child: Text(secondaryText),
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren()
      ),
    );
  }
}
