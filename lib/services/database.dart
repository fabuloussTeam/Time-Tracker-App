
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/home/models/job.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';

import 'api_path.dart';


abstract class Database {
  Future<void> createJob({Job job, BuildContext context});

}

class FirestoreDatabase implements Database {
// UID de l'utilisateur connecté.
  final String uid;
  FirestoreDatabase({@required this.uid})  : assert(uid != null);

  Future<void> createJob({Job job, BuildContext context}) async => await _setData (
      path: APIPath.job(uid, 'job_abc'),
      data: job.toMap(),
      context: context
  );

  Future<void> _setData({String path, Map<String, dynamic> data, BuildContext context}) async {
    final reference = FirebaseFirestore.instance.doc(path);
   //  print("$path: $data");
     print("$data");

     reference.set(data)
        .then((value) => print("Valuer added"))
        .catchError((onError) => PlatformAlertDialog(
         title: "Error",
         content: onError.toString(),
         defaultActionText: "OK",
     ).show(context));
  }

}

