import 'package:flutter/material.dart';
import 'package:timetrackerapp/common_widgets/custom_raise_button.dart';

class SignInButton extends CustomRaiseButton {
  SignInButton({@required String text, Color color, Color textColor, VoidCallback onPress}) : super(
      child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15.0)
      ),
      // borderRadius: 8.0,
      color: color,
      onPressButton: onPress
  );

}