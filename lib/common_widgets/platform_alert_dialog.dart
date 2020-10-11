import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlateformWidget {

  final String title;
  final String content;
  final String textDefaultAction;

  PlatformAlertDialog({this.title, this.content, this.textDefaultAction});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return null;
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
   return null;
  }


}
