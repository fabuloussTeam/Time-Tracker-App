import 'package:flutter/cupertino.dart';

class Job {
  final String name;
  final int ratePerHour;
  final String id; // Il s'agit de lid du doc parent: pour la mise a jour

  Job({this.id, @required this.name, @required this.ratePerHour});

  factory Job.fromMap(Map<String, dynamic> data, String id){
    if(data == null){
      return null;
    }
    final String name = data["name"];
    final int ratePerHour = data['ratePerHour'];
    return Job(
        name: name,
        ratePerHour: ratePerHour,
        id: id
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'ratePerHour': ratePerHour
    };
  }
}