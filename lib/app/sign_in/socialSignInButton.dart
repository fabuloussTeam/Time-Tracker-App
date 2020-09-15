import 'package:flutter/material.dart';
import 'package:timetrackerapp/common_widgets/custom_raise_button.dart';

class SocialSignInButton extends CustomRaiseButton {
  SocialSignInButton({@required String text, @required String assetName, Color color, Color textColor, VoidCallback onPress}) :
        assert(text != null),
        assert(assetName != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(text, style: TextStyle(color: textColor, fontSize: 15.0),),
              Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetName)),
            ],
          ),
          // borderRadius: 8.0,
          color: color,
          onPressButton: onPress
      );

}