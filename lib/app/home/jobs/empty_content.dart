import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String message;
  const EmptyContent({
     Key key,
     this.title ="Nothin here",
     this.message = "Add a new item to get stated"
   });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 32.0, color: Colors.black54),
        ),
        Text(
          message,
          style: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      ],
    );
  }
}
