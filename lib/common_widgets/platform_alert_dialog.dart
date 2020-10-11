import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlateformWidget {

  final String title;
  final String content;
  final String defaultActionText;

  PlatformAlertDialog({this.title, this.content, this.defaultActionText}) : assert(title != null), assert(content != null), assert(defaultActionText != null);


  Future<bool> show(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => this
    );
  }

  // Contenu pour IOS
  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions:  _buildActions(context),
    );
  }

  // Contenue pour Android

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  //Bouton action
  List<Widget> _buildActions(BuildContext context){
    return [
      PlatformAlertDialogAction(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("OK"),
      ),
    ];
  }
}

class PlatformAlertDialogAction extends PlateformWidget {
  final Widget child;
  final VoidCallback onPressed;
  PlatformAlertDialogAction({this.child, this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context){
    return CupertinoDialogAction(
       child: child,
       onPressed: onPressed
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context){
    return FlatButton(
        child: child,
        onPressed: onPressed
    );
  }
}
