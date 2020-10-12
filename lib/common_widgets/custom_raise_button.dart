import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRaiseButton extends StatelessWidget {

  CustomRaiseButton({this.child, this.color, this.borderRadius: 2.0, this.height: 50.0,  this.onPressButton});

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressButton;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(borderRadius)
            )
        ),
        onPressed: onPressButton,
      ),
    );
  }
}
