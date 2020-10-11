import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlateformWidget {

  final String title;
  final String content;
  final String DefaultActionText;

  PlatformAlertDialog({this.title, this.content, this.DefaultActionText}) : assert(title != null), assert(content != null), assert(DefaultActionText != null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions:  _buildActions(context),
  );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

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
