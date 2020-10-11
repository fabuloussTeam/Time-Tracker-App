import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlateformWidget {

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.cancelActionText,
    @required this.defaultActionText}) : assert(title != null), assert(content != null), assert(defaultActionText != null);


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
    final actions = <Widget>[];
    //Ici le cancel button est ajouter ssi le cancelActionText est non null. ie est remplit
    if(cancelActionText != null){
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
   actions.add(
     PlatformAlertDialogAction(
       child: Text(defaultActionText),
       onPressed: () => Navigator.of(context).pop(true),
     ),
   );
    return actions;
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
