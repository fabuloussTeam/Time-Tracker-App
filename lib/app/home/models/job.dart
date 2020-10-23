import 'package:flutter/cupertino.dart';

class Job {
  final String name;
  final int ratePerHour;

  Job({@required this.name, @required this.ratePerHour});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'ratePerHour': ratePerHour
    };
  }
}