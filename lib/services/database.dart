
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/home/models/job.dart';

import 'api_path.dart';


abstract class Database {
  Future<void> createJob(Job job);

}

class FirestoreDatabase implements Database {
// UID de l'utilisateur connecté.
  final String uid;
  FirestoreDatabase({@required this.uid})  : assert(uid != null);

  Future<void> createJob(Job job) async => await _setData (
      path: APIPath.job(uid, 'job_abc'),
      data: job.toMap()
  );

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
     print("$path: $data");
    await reference.set(data);
  }

}

