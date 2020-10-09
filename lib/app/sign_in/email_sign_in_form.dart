import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/sign_in/validators.dart';
import 'package:timetrackerapp/common_widgets/form_submit_button.dart';
import 'package:timetrackerapp/services/auth.dart';


enum EmailSignInFormType { signin, register }

// Utilisation des Mixin: en ajoutan" with EmailAndPasswordValidators
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;
  EmailSignInForm({@required this.auth});
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

//mainAxisSize permet mettre la hauteur sur l'espace ocuuper nette
class _EmailSignInFormState extends State<EmailSignInForm> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  var _formType = EmailSignInFormType.signin;
  bool _submitted = false;
  bool _isLoading = false;


// Fonction de connection / Creation compte
  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
        try{
          if(_formType == EmailSignInFormType.signin){
           var response = await widget.auth.signInWithEmailAndPassword(_email, _password);
          //  print("jdjjfkdlf ${await widget.auth.signInWithEmailAndPassword(_email, _password)}");
            if(response != null){
               Navigator.of(context).pop(this);
            }
          } else {
            await widget.auth.createUserWithEmailAndPassword(_email, _password);
          }
        } catch(e){
            print(e.toString());
        } finally {
         setState(() {
           _isLoading = false;
         });
        }
  }

  // _emailEditingComplete
  void _emailEditingComplete(){
    final newFocus = widget.emailValidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;
   FocusScope.of(context).requestFocus(newFocus);
  }

  void _toogleFormType(){
    setState(() {
      _submitted = false;
      _formType = (_formType == EmailSignInFormType.signin) ? EmailSignInFormType.register : EmailSignInFormType.signin;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(BuildContext context){
    final primaryText = _formType == EmailSignInFormType.signin ? "Sign in" : "Create an account";
    final secondaryText = _formType == EmailSignInFormType.signin ? "Need an account? register" : "Have an account? Sign in";
  //  print(secondaryText);

    // Verifie que le champ email et password est remplit
    bool submitEnable = widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password) && ! _isLoading;
    bool showErrorTextEmail = _submitted && ! widget.emailValidator.isValid(_email);
    bool showErrorTextPassword = _submitted && ! widget.emailValidator.isValid(_password);

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@gmail.com',
          errorText: showErrorTextEmail ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocusNode,
        onEditingComplete: _emailEditingComplete,
        onChanged: (email) => _updateState(),
      ),
      SizedBox(height: 8.0,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: showErrorTextPassword ?  widget.invalidPasswordErrorText : null,
            enabled: _isLoading == false
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        onEditingComplete: _submit,
        onChanged: (password) => _updateState(),

      ),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        text: primaryText,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        onPressed: !_isLoading ? _toogleFormType : null,
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
        children: _buildChildren(context)
      ),
    );
  }

  void _updateState(){
    setState(() {});
  }
}
