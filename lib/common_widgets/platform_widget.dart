import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class PlateformWidget extends StatelessWidget {

  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Platform.isIOS){
      buildCupertinoWidget(context);
    }
    return  buildMaterialWidget(context);
  }
}
