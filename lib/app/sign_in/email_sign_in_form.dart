import 'package:flutter/material.dart';
import 'package:timetrackerapp/common_widgets/form_submit_button.dart';

 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();

 void _submit(){
   print("email: ${_emailController.text} password: ${_passwordController.text}");
 }



List<Widget> _buildChildren(){
  return [
    TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@gmail.com',
      ),
    ),
    SizedBox(height: 8.0,),
    TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
    ),
    SizedBox(height: 8.0,),
      FormSubmitButton(
        onPressed: _submit,
        text: "Sign in",
    ),
    SizedBox(height: 8.0,),
    FlatButton(
        onPressed: (){},
        child: Text("Need an account? Register"),
    )
  ];
}

//mainAxisSize permet mettre la hauteur sur l'espace ocuuper nette
class EmailSignInForm extends StatelessWidget {
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
